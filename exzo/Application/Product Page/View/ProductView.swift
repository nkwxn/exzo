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
    @State var isGo = false
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CustomNavBarView(twoColumnsNavBar: false, title: "Produk", subtitle: nil, showButton: .addButton) {
                    self.isPresented.toggle()
                }
                Spacer()
                    .frame(height: 5)
                List {
                    ForEach($viewModel.products, id: \.self) { product in
                        ZStack {
                            NavigationLink {
                                DetailProductView(product: product.wrappedValue)
                            } label: {
                                ProductRow(product: product.wrappedValue)
                            }
                            .buttonStyle(PlainButtonStyle())
                            ProductRow(product: product.wrappedValue)
                        }
                    }
                    .onDelete(perform: viewModel.deleteItem)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .environment(\.defaultMinListRowHeight, 2)

                .sheet(isPresented: $isPresented) {
                    AddProduct()
                        .interactiveDismissDisabled(true)
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarHidden(true)
            .navigationTitle("Produk")
        }
    }
}
