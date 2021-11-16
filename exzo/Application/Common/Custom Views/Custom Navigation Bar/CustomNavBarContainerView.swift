//
//  CustomNavBarContainerView.swift
//  exzo
//
//  Created by Deven Nathanael on 05/11/21.
//

import SwiftUI

struct CustomNavBarContainerView<Content: View>: View {
    
    let content: Content
    @State private var twoColumnsNavBar: Bool = false
    @State private var title: String = ""
    @State private var subtitle: String?
    @State private var showButton: NavBarButton = NavBarButton.addButton
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBarView(twoColumnsNavBar: twoColumnsNavBar, title: title, subtitle: subtitle, showButton: showButton) {}
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onPreferenceChange(CustomNavBarTwoColumnsNavBarPreferenceKey.self, perform: { value in
            self.twoColumnsNavBar = value
            
        })
        .onPreferenceChange(CustomNavBarTitlePreferenceKey.self, perform: { value in
            self.title = value
            
        })
        .onPreferenceChange(CustomNavBarSubtitlePreferenceKey.self, perform: { value in
            self.subtitle = value
            
        })
        .onPreferenceChange(CustomNavBarShowButtonPreferenceKey.self, perform: { value in
            self.showButton = value
            
        })
    }
}

struct CustomNavBarContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarContainerView {
            ZStack {
                Color.green.ignoresSafeArea()
                
                Text("Hello World!")
                    .foregroundColor(.white)
                    .customNavBarItems(twoColumnsNavBar: true, title: "7 Nov 2020", subtitle: "", showButton: NavBarButton.editButton)
            }
        }
    }
}
