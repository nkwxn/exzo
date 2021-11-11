//
//  AddFEARowView.swift
//  exzo
//
//  Created by Deven Nathanael on 09/11/21.
//

import SwiftUI

struct AddFEARowView: View {
    let title: String
    let chooseImage: Bool
    let icon: Image?
    let name: String
    let color: Color?
    
    private func safeColor() -> Color {
        color ?? Color.brandy
    }
    
    private func safeIcon() -> Image {
        icon ?? Image(systemName: "")
    }
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            if chooseImage {
                safeIcon()
                    .resizable()
                    .scaledToFit()
                    .background {
                        Circle()
                            .strokeBorder(safeColor(), lineWidth: 2)
                    }
                    .frame(width: 40, height: 40)
                    .foregroundColor(color)
            } else {
            Text(name)
                    .foregroundColor(Color.secondary)
            }
        }
    }
}

struct FEARowView_Previews: PreviewProvider {
    static var previews: some View {
        AddFEARowView(title: "Category", chooseImage: false, icon: nil, name: "...", color: nil)
        AddFEARowView(title: "Category", chooseImage: true, icon: Image("Icon005"), name: "...", color: Color.brandy)
    }
}
