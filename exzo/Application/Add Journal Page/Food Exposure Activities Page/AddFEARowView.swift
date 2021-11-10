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
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 17))
            Spacer()
            if chooseImage {
                icon
            } else {
            Text(name)
                    .font(.system(size: 15))
                    .fontWeight(.medium)
            }
        }
    }
}

struct FEARowView_Previews: PreviewProvider {
    static var previews: some View {
        AddFEARowView(title: "Category", chooseImage: false, icon: nil, name: "...")
    }
}
