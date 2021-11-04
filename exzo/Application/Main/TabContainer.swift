//
//  TabContainer.swift
//  Atemis
//
//  Created by Nicholas on 26/10/21.
//

import SwiftUI

struct TabContainer: View {
    var body: some View {
        TabView {
            Text("Avenir")
                .font(.custom("Avenir", size: 50))
                .tabItem {
                    Image(systemName: "a.square")
                    Text("Avenir")
                }
            Text("Lexend")
                .font(.custom("Lexend", size: 50))
                .tabItem {
                    Image(systemName: "l.square")
                    Text("Lexend")
                }
        }
    }
}

struct TabContainer_Previews: PreviewProvider {
    static var previews: some View {
        TabContainer()
    }
}
