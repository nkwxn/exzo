//
//  RoundedSquareContainer.swift
//  exzo
//
//  Created by Nicholas on 18/11/21.
//

import SwiftUI

struct RoundedSquareContainer<Content: View>: View {
    var autoPadding: Bool
    var outerPadding = true
    let content: () -> Content
    var body: some View {
        if autoPadding {
            if outerPadding {
                content()
                    .padding()
                    .background {
                        bg
                    }
                    .padding(.vertical, 7)
                    .padding(.horizontal)
            } else {
                content()
                    .padding()
                    .background {
                        bg
                    }
            }
        } else {
            if outerPadding {
                content()
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
            }
        }
    }
    
    var bg: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(Color.white)
            .shadow(radius: 5)
    }
}
