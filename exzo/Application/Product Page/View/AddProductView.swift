//
//  AddMoviewView.swift
//  Atemis
//
//  Created by Daniella Stefani on 01/11/21.
//

import SwiftUI
import CoreML

struct AddProduct: View {
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
    @State var tmpArray: [String] = []
    @State var textClassify = ""
    @State var collapse: [Task] = []
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
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                HStack(alignment: .center, spacing: 11.0) {
                    Section {
                        ZStack(alignment: .trailing) {
                            if let image = image {
                                Image(uiImage: image)
                                    .resizable()
                                    .cornerRadius(15)
                                    .frame(width: 141, height: 181, alignment: .leading)
                                    .background(Color.white.opacity(0.2))
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .onTapGesture {
                                        showOption = true
                                    }
                            }
                            Image("camer")
                                .resizable()
                                .frame(width: 29, height: 29)
                                .opacity(image != UIImage(imageLiteralResourceName: "PhotoProduct") ? 1 : 0)
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
                            Picker("", selection: $selectedType) {
                                ForEach(productType) { typeOfProduct in
                                    Text(typeOfProduct.productType.getLocalizedName())
                                        .tag(typeOfProduct.productType)
                                        
                                }
                            }
                        }
                        Divider()
                        Section(header: Text("Nama Produk")) {
                            TextField("Name", text: $name)
                        }
                        Divider()
                    }
                }
                HStack {
                    Text("Daftar Bahan Produk")
                    Spacer()
                    Button {
                        self.showingScanningView = true
                        
                    } label: {
                        Image("camer")
                            .resizable()
                            .frame(width: 29, height: 29)
                    }.opacity(recognizedText.count != 0 ? 1 : 0)

                }
                
                ZStack {
                    if isScan == true {
                        ScrollView {
                            ForEach(tmpArray, id: \.self) { index in
                                var take: [Bahan] = bahanBerbahya.filter({$0.name == "\(index)"})
                                ProdukRow(namaProduk: index, descProduk: take[0].description, bahanProduk: take[0].bahanMengandung)
                            }
                        }
                        .listStyle(PlainListStyle())
                        
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
                }.sheet(isPresented: $showingScanningView) {
                    ScanIngredientView(recognizedText: self.$recognizedText, scanDone: self.$isScan)
                        .onDisappear {
                            DispatchQueue.main.async {
                                tmpArray = checkAvoid(name: recognizedText)
                            }
                        }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle(Text("Tambahkan Produk"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Batalkan")
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addProductAction) {
                        Text("Selesai").bold()
                    }
                }
            }
        }
    }
    
    private func addProductAction() {
        CDStorage.shared.createProduct(name: name, type: selectedType, image: image, ingredients: tmpArray)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct ProdukRow: View {
    @State private var isExpanded: Bool = false
    var namaProduk: String
    var descProduk: String
    var bahanProduk: [String]
    var bahan: String {
        var bahan: String = ""
        for (index, item) in bahanProduk.enumerated() { // how to limit cuman 3
            if index < 3 {
                bahan += "\(item), "
            }
            
        }
        return bahan
    }
    var body: some View {
        content
            .frame(maxWidth: 400)
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 5) {
            if !isExpanded {
                withAnimation {
                    header
                        .cornerRadius(10, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
                }
                
            } else {
                withAnimation {
                    header
                        .cornerRadius(10, corners: [.topLeft, .topRight])
                }
            }
            if isExpanded {
                VStack{
                    Text(descProduk)
                        .padding(10)
                        .opacity(isExpanded ? 1 : 0)
                    Divider()
                        .foregroundColor(Color.black)
                    Text("Common of \(namaProduk) are \(bahan)")
                        .font(Avenir(.caption).getFont().italic())
                        .padding(10)
                }
            }
            
        }
    }
    
    private var header: some View {
        HStack {
            Text(namaProduk)
                .padding(10)
                .foregroundColor(Color.white)
            Spacer()
            Image(systemName: !isExpanded ? "chevron.down" : "chevron.up")
                .foregroundColor(Color.white)
            Spacer()
                .frame(width:20)
        }
        .contentShape(Rectangle())
        .padding(.vertical, 4)
        .background(Color("accent_copper"))
        .onTapGesture {
            withAnimation { isExpanded.toggle() }
        }
    }
}
