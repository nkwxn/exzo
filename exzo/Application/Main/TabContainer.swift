//
//  TabContainer.swift
//  Atemis
//
//  Created by Nicholas on 26/10/21.
//

import SwiftUI

struct TabContainer: View {
    @Environment(\.colorScheme) var colorScheme
    
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
            SettingsView(profileImage: "pp_004", profileName: "Regina Georgia")
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
        .tabViewStyle(backgroundColor: colorScheme == .light ? .white : .black, itemColor: Color.gray, selectedItemColor: Color.accentColor, badgeColor: Color.red)
    }
}

struct TabContainer_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}
