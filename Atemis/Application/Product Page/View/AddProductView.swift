//
//  AddMoviewView.swift
//  Atemis
//
//  Created by Daniella Stefani on 01/11/21.
//

import SwiftUI

struct AddProduct: View {
    static let DefaultProductType = "Product Type"
    static let DefaultProductName = "Product Name"
    
    @State var name = ""
//    @State var type = ""
//    @State var image = UIImage()
//    let onComplete: (String, String, UIImage) -> Void
    let onComplete: (String) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $name)
                }
                Section {
                    Button(action: addProductAction) {
                        Text("Add Product")
                    }
                }
            }
            .navigationTitle(Text("Add Product"))
        }
    }
    private func addProductAction() {
        onComplete(name.isEmpty ? AddProduct.DefaultProductName: name)
    }
}
