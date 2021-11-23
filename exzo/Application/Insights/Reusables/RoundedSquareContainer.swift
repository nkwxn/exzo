//
//  RoundedSquareContainer.swift
//  exzo
//
//  Created by Nicholas on 18/11/21.
//

import SwiftUI

struct RoundedSquareContainer<Content: View>: View {
    let autoPadding: Bool
    let content: () -> Content
    var body: some View {
        if autoPadding {
            content()
                .padding()
                .background {
                    bg
                }
                .padding(.vertical, 7)
                .padding(.horizontal)
        } else {
            content()
                .background {
                    bg
                }
                .padding(.vertical, 7)
                .padding(.horizontal)
        }
    }
    
    var bg: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(Color.white)
            .shadow(radius: 5)
    }
}
