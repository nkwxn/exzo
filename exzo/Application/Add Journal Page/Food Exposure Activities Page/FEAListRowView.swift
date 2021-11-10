//
//  FEAListRowView.swift
//  exzo
//
//  Created by Deven Nathanael on 10/11/21.
//

import SwiftUI

struct DefaultIcon: View {
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(Color("accent_brandy"), lineWidth: 2.4)
                .background(Circle().fill(Color("")))
                .frame(width: 34, height: 34)
            Image(systemName: "")
            .font(.system(size: 24))
            .foregroundColor(Color("accent_brandy"))
        }
    }
}

struct FEAListRowView: View {
    let name: String = "Default"
    var body: some View {
        HStack {
            DefaultIcon()
            Text(name)
            Spacer()
        }
    }
}

struct FEAListRowView_Previews: PreviewProvider {
    static var previews: some View {
        FEAListRowView()
    }
}
