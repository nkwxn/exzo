//
//  ProductView.swift
//  Atemis
//
//  Created by Daniella Stefani on 01/11/21.
//

import SwiftUI

struct ProductView: View {
    @StateObject var viewModel = ProductViewModel()
    @State var isPresented = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CustomNavBarView(twoColumnsNavBar: false, title: "Products", subtitle: nil, showButton: .addButton) {
                    self.isPresented.toggle()
                }
                List {
                    ForEach(Array(viewModel.products.enumerated()), id: \.0) {
                        ProductRow(product: $1)
                    }
                    .onDelete(perform: viewModel.deleteItem)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .sheet(isPresented: $isPresented) {
                    AddProduct()
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarHidden(true)
            .navigationTitle("Products")
//            .toolbar {
//                ToolbarItem(placement: .automatic) {
//                    Button(action: { self.isPresented.toggle() }) {
//                        Image(systemName: "plus")
//                    }
//                }
//            }
        }
    }
}
