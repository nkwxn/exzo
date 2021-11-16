//
//  FEAListRowView.swift
//  exzo
//
//  Created by Deven Nathanael on 10/11/21.
//

import SwiftUI

struct FEAListRowView: View {
    let name: String
    let image: String
    let favorite: Bool
    let color: String
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .background {
                    Circle()
                        .strokeBorder(Color(color), lineWidth: 2)
                        .background(Circle().fill(Color.clear))
                }
                .frame(width: 40, height: 40)
                .foregroundColor(Color(color))
            Text(name)
            Spacer()
            if favorite {
                Image(systemName: "star.fill")
                    .foregroundColor(Color.yellow)
            }
        }
    }
}

struct FEAListRowView_Previews: PreviewProvider {
    static var previews: some View {
        FEAListRowView(name: "ASDF", image: "Icon002", favorite: true, color: "accent_copper")
        FEAListRowView(name: "Ghjkl", image: "Icon002", favorite: false, color: "accent_copper")
    }
}
