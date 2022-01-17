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
    // FIXME:  //kayanya mesti bikin asset buat empty state? idk lol haha
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
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .strokeBorder(Color.copper, lineWidth: 2)
                    VStack {
                        if let ingredients = product.productIngr as? [String] {
                            ForEach(ingredients, id: \.self){ index in
                                Text("\(index)")
                                    .padding()
                            }
                        }
                        
                    }
                    
//                    Text((product.productIngr ?? "" as NSObject) as! DateInterval)
//                        .padding()
                }.sheet(isPresented: $showingScanningView) {
                    ScanIngredientView(recognizedText: self.$recognizedText)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle(Text("Add Product"))
            .navigationBarTitleDisplayMode(.inline)
        
    }
    
   
}
