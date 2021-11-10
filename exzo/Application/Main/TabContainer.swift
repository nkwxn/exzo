//
//  TabContainer.swift
//  Atemis
//
//  Created by Nicholas on 26/10/21.
//

import SwiftUI

struct TabContainer: View {
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            // TODO: Replace ModalPlaceholder with the list of journal made by Stef
            MySkinView()
                .tabItem {
                    Image(systemName: "face.smiling")
                    Text("My Skin")
                }
            ProductView()
                .tabItem {
                    Image(systemName: "viewfinder.circle")
                    Text("Product")
                }
            Text("Insights Coming Soon")
                .font(.custom("Avenir", size: 50))
                .tabItem {
                    Image(systemName: "chart.pie")
                    Text("Insights")
                }
            Text("Settings")
                .font(.custom("Lexend", size: 50))
                .tabItem {
                    Image(systemName: "gearshape")
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
