//
//  SelectIconView.swift
//  exzo
//
//  Created by Deven Nathanael on 09/11/21.
//

import SwiftUI

struct SelectIconView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var iconSelection: String
    var accentColor: Color
    
    var gridItems = Array(repeating: GridItem(.flexible()), count: 5)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems) {
                ForEach(1..<38) { iconIndex in
                    Image("Icon\(String(format: "%03d", iconIndex))")
                        .resizable()
                        .scaledToFit()
                        .background {
                            Circle()
                                .strokeBorder(accentColor, lineWidth: 2)
                                .background(Circle().fill(Color.clear))
                        }
                        .foregroundColor(accentColor)
                        .onTapGesture {
                            // set the icon selection string and go back
                            iconSelection = "Icon\(String(format: "%03d", iconIndex))"
                            dismiss()
                        }
                }
            }
            .padding()
        }
        .navigationTitle("Select Icon")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SelectIconView_Previews: PreviewProvider {
    static var previews: some View {
        SelectIconView(iconSelection: .constant(""), accentColor: .accentYellow)
    }
}
