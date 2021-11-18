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
            InsightsView()
                .tabItem {
                    Image(systemName: "chart.pie")
                    Text("Insights")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
    }
}

struct TabContainer_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}
