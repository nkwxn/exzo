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
            // TODO: Replace ModalPlaceholder with the list of journal made by Stef
            ModalPlaceholder()
                .tabItem {
                    Image(systemName: "scribble.variable")
                    Text("My Skin")
                }
            ProductView()
                .tabItem {
                    Image(systemName: "scribble.variable")
                    Text("Product")
                }
            Text("Avenir")
                .font(.custom("Avenir", size: 50))
                .tabItem {
                    Image(systemName: "scribble.variable")
                    Text("Insights")
                }
            Text("Lexend")
                .font(.custom("Lexend", size: 50))
                .tabItem {
                    Image(systemName: "scribble.variable")
                    Text("Settings")
                }
        }
    }
}

struct TabContainer_Previews: PreviewProvider {
    static var previews: some View {
        TabContainer()
    }
}
