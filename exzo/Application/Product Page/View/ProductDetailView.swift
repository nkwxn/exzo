//
//  ProductDetailView.swift
//  Exzo
//
//  Created by Difa N Pratama on 01/11/21.
//

import SwiftUI

struct DetailProductView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    static let DefaultProductType = "Tipe Produk"
    static let DefaultProductName = "Nama Produk"
    
    @State var name = ""
    @State var type = ""
    @State var image: UIImage? = UIImage(imageLiteralResourceName: "PhotoProduct")
    @State var showOption = false
    @State var showPhotoLibrarySheet = false
    @State var showCameraSheet = false
    @State private var recognizedText: [String] = []
    
    // Vision state
    @State var isScan: Bool = false
    @State private var showingScanningView = false
    
    @State var selectedType = ProductType.others
    
    var productType: [ProType] = ProductType.allCases.map { type in
        return ProType(productType: type)
    }
    struct ProType: Identifiable {
        var id = UUID()
        var productType: ProductType
    }
    
    let product: Product
    
    func getImage() -> UIImage {
        if let safeImage = product.productImage as? UIImage {
            return safeImage
        } else {
            return UIImage()
        }
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack(alignment: .center, spacing: 11.0) {
                Section {
                    ZStack(alignment: .trailing) {
                        Image(uiImage: getImage())
                            .resizable()
                            .cornerRadius(15)
                            .frame(width: 141, height: 181, alignment: .leading)
                            .background(Color.white.opacity(0.2))
                            .aspectRatio(contentMode: .fill)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .onTapGesture {
                                showOption = true
                            }
                        Image("camer")
                            .resizable()
                            .frame(width: 29, height: 29)
                            .offset(x: -10, y: -65)
                    }
                    
                }
                .confirmationDialog("Pilih sumber foto", isPresented: $showOption, titleVisibility: .visible) {
                    Button("Galeri") {
                        showPhotoLibrarySheet = true
                    }
                    Button("Kamera") {
                        showCameraSheet = true
                    }
                }
                .sheet(isPresented: $showPhotoLibrarySheet) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                }
                .sheet(isPresented: $showCameraSheet) {
                    ImagePicker(sourceType: .camera, selectedImage: self.$image)
                }
                
                VStack(alignment: .leading) {
                    Section(header: Text("Tipe Produk")) {
                        Text(ProductType(rawValue: product.productType ?? "")?.getLocalizedName() ?? "")
                    }
                    Divider()
                    Section(header: Text("Nama Produk")) {
                        Text(product.productName ?? "")
                    }
                    Divider()
                }
            }
            HStack {
                Text("Daftar Bahan")
                Spacer()
                Button {
                    self.showingScanningView.toggle()
                } label: {
                    Image("camer")
                        .resizable()
                        .frame(width: 29, height: 29)
                }
            }
            
            ZStack {
                if let ingredients = product.productIngr as? [String] {
                    if isScan || !ingredients.isEmpty {
                        ScrollView {
                            ForEach(ingredients, id: \.self) { index in
                                var take: [Bahan] = bahanBerbahya.filter({$0.name == "\(index)"})
                                if !take.isEmpty {
                                    ProdukRow(namaProduk: index, descProduk: take[0].description, bahanProduk: take[0].bahanMengandung)
                                }
                            }
                        }
                    } else {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .strokeBorder(Color.copper, lineWidth: 2)
                            .opacity(isScan ? 0 : 1)
                        Button {
                            self.showingScanningView = true
                        } label: {
                            VStack {
                                Image(systemName: "camera")
                                    .frame(width: 18, height: 18)
                                Text("Pindai Bahan Produk Anda")
                                    .scaledFont(name: "Avenir", size: 18)
                            }
                        }
                    }
                }
            }.sheet(isPresented: $showingScanningView) {
                ScanIngredientView(recognizedText: self.$recognizedText, scanDone: self.$isScan)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(Text("Detil Produk"))
        .navigationBarTitleDisplayMode(.inline)
        
    }
}
