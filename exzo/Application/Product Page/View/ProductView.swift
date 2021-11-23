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
                CustomNavBarView(twoColumnsNavBar: false, title: "Products", subtitle: nil, showButton: .addButton) {
                    self.isPresented.toggle()
                }
                Spacer()
                    .frame(height: 5)
                List {
                    ForEach(Array(viewModel.products.enumerated()), id: \.0) {
                        ProductRow(product: $1)
                            .onTapGesture {
                                isGo.toggle()
                            }
                        NavigationLink(destination: DetailProductView(product: $1), isActive: $isGo) {
                        }.opacity(0)
                    }
                    .onDelete(perform: viewModel.deleteItem)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .environment(\.defaultMinListRowHeight, 2)

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
