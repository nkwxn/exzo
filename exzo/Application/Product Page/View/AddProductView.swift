//
//  AddMoviewView.swift
//  Atemis
//
//  Created by Daniella Stefani on 01/11/21.
//

import SwiftUI

struct AddProduct: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    static let DefaultProductType = "Product Type"
    static let DefaultProductName = "Product Name"
    
    @State var name = ""
    @State var type = ""
    @State var image: UIImage? = UIImage(systemName: "camera") //kayanya mesti bikin asset buat empty state? idk lol haha
    @State var showOption = false
    @State var showPhotoLibrarySheet = false
    @State var showCameraSheet = false
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
            Form {
                HStack(alignment: .center, spacing: 11.0) {
                    Section {
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
                            Picker("", selection: $selectedType) {
                                ForEach(productType) { typeOfProduct in
                                    Text(typeOfProduct.productType.rawValue).tag(typeOfProduct.productType)
                                        .frame(alignment: .leading)
                                }
                            }
                        }
                        Divider()
                        Section(header: Text("Product Name")) {
                            TextField("Name", text: $name)
                        }
                        Divider()
                    }
                }
            }
            .navigationTitle(Text("Add Product"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addProductAction) {
                        Text("Done").bold()
                    }
                }
            }
        }
    }
    
    private func addProductAction() {
        CDStorage.shared.createProduct(name: name, type: selectedType, image: image)
        self.presentationMode.wrappedValue.dismiss()
    }
}
