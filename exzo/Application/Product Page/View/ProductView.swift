//
//  ProductView.swift
//  Atemis
//
//  Created by Daniella Stefani on 01/11/21.
//

import SwiftUI

struct ProductView: View {
    @FetchRequest(
        entity: Product.entity(),
        sortDescriptors: [
        NSSortDescriptor(keyPath: \Product.productName, ascending: true)
    ]) var products: FetchedResults<Product>
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var isPresented = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(products, id: \.idProduct) {
                    ProductRow(product: $0)
                }
            }
            .sheet(isPresented: $isPresented) {
                AddProduct { name in
                    self.addProduct(name: name)
                    self.isPresented = false
                }
            }
            .navigationBarTitle(Text("Products"))
            .navigationBarItems(trailing:
                Button(action: { self.isPresented.toggle() }) {
                  Image(systemName: "plus")
                }
            )
        }
    }
    
    func addProduct (name: String) {
        let newProduct = Product(context: managedObjectContext)
        
        newProduct.productName = name
        
        saveContext()
        
        print("\(newProduct.productName)")
    }
    
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
}
