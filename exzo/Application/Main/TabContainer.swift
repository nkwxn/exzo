//
//  TabContainer.swift
//  Atemis
//
//  Created by Nicholas on 26/10/21.
//

import SwiftUI

struct TabContainer: View {
    @State private var selection: Tab = .mySkin
    enum Tab {
        case mySkin
        case product
        case insight
        case settings
    }

    var body: some View {
        TabView(selection: $selection) {
            Text("Avenir")
                .font(.custom("Avenir", size: 50, relativeTo: .caption))
                .tag(Tab.mySkin)
                .tabItem {
                    Image(systemName: "a.square")
                    Text("Avenir")
                }
                
            Text("Lexend")
                .font(.custom("Lexend", size: 50))
                .tag(Tab.mySkin)
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
