//
//  ProductRowView.swift
//  Atemis
//
//  Created by Daniella Stefani on 01/11/21.
//

import SwiftUI

struct ProductRow: View {
    let product: Product
    
    func getImage() -> UIImage {
        if let safeImage = product.productImage as? UIImage {
            return safeImage
        } else {
            return UIImage()
        }
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(radius: 3, x: 2, y: 5)
            HStack {
                Image(uiImage: getImage())
                    .resizable()
                    .frame(width: 112, height: 104, alignment: .leading)
                    .background(Color.black.opacity(0.2))
                    .aspectRatio(contentMode: .fill)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                VStack {
                    Text(product.productType ?? "")
                        .font(.system(size: 18, weight: .bold))
                        .frame(width: 190, height: 21, alignment: .leading)
                    Text(product.productName ?? "")
                        .font(.system(size: 14))
                        .frame(width: 190, height: 17, alignment: .leading)
                        .lineLimit(nil)
                }
            }
            .frame(alignment: .leading)
        }
        .padding(.bottom, 4)
    }
}
