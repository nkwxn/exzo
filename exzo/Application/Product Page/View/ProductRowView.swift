//
//  ProductRowView.swift
//  Atemis
//
//  Created by Daniella Stefani on 01/11/21.
//

import SwiftUI

struct ProductRow: View {
    let product: Product
    
    var body: some View {
        product.productName.map(Text.init).font(.title)
    }
}
