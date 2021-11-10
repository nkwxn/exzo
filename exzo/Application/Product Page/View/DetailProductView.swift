//
//  AddMoviewView.swift
//  Atemis
//
//  Created by Daniella Stefani on 01/11/21.
//

import SwiftUI

struct DetailProductView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    static let DefaultProductType = "Product Type"
    static let DefaultProductName = "Product Name"
    
    @Binding var name: String
    @Binding var type: String
    //FIXME:  //kayanya mesti bikin asset buat empty state? idk lol haha
    @Binding var image: UIImage
    @Binding var showOption: Bool
    @Binding var showPhotoLibrarySheet: Bool
    @Binding var showCameraSheet: Bool
    @Binding var recognizedText: String
    
    //Vision state
    @Binding var isScan: Bool
    @Binding private var showingScanningView: Bool
    
    @Binding var selectedType: ProductType
    
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
        NavigationView {
            VStack(alignment: .leading) {
                
                HStack(alignment: .center, spacing: 11.0) {
                    Section {
                        ZStack(alignment: .trailing){
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
                                .opacity(image != UIImage(imageLiteralResourceName: "PhotoProduct") ? 1 : 0)
                                .offset(x: -10, y: -65)
                        }
                        
                    }
                    .confirmationDialog("Choose photo source", isPresented: $showOption, titleVisibility: .visible) {
                        Button("Photo Library") {
                            showPhotoLibrarySheet = true
                        }
                        Button("Camera") {
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
                        Section(header: Text("Type of Product")) {
                            Text(product.productType ?? "")
                        }
                        Divider()
                        Section(header: Text("Product Name")) {
                            Text(product.productName ?? "")
                        }
                        Divider()
                    }
                }
                HStack {
                    Text("List of Ingredients")
                    Spacer()
                    Button {
                        self.showingScanningView.toggle()
                    } label: {
                        Image("camer")
                            .resizable()
                            .frame(width: 29, height: 29)
                    }.opacity(recognizedText != "" ? 1 : 0)

                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .strokeBorder(Color.copper, lineWidth: 2)
                    Button {
                        self.isScan.toggle()
                        self.showingScanningView.toggle()
                    } label: {
                        VStack {
                            Image(systemName: "camera")
                                .frame(width: 18, height: 18)
                            Text("Scan your Ingredients")
                                .scaledFont(name: "Avenir", size: 18)
                        }
                    }.opacity(isScan ? 0 : 1)

                    Text(recognizedText)
                        .padding()
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
    
   
}
