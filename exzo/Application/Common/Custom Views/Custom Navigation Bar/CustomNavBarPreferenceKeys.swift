//
//  CustomNavBarPreferenceKeys.swift
//  exzo
//
//  Created by Deven Nathanael on 08/11/21.
//

import Foundation
import SwiftUI

struct CustomNavBarTwoColumnsNavBarPreferenceKey: PreferenceKey {
    
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

struct CustomNavBarTitlePreferenceKey: PreferenceKey {
    
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

struct CustomNavBarSubtitlePreferenceKey: PreferenceKey {
    
    static var defaultValue: String?
    
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = nextValue()
    }
}

struct CustomNavBarShowButtonPreferenceKey: PreferenceKey {
    
    static var defaultValue: NavBarButton = NavBarButton.none
    
    static func reduce(value: inout NavBarButton, nextValue: () -> NavBarButton) {
        value = nextValue()
    }
}

extension View {
   
    func customNavigationTwoColumnsNavBar(_ showTitle: Bool) -> some View {
        preference(key: CustomNavBarTwoColumnsNavBarPreferenceKey.self, value: showTitle)
    }
    
    func customNavigationTitle(_ title: String) -> some View {
        preference(key: CustomNavBarTitlePreferenceKey.self, value: title)
    }
    
    func customNavigationSubtitle(_ subtitle: String?) -> some View {
        preference(key: CustomNavBarSubtitlePreferenceKey.self, value: subtitle)
    }

    func customNavigationShowButton(_ showButton: NavBarButton) -> some View {
        preference(key: CustomNavBarShowButtonPreferenceKey.self, value: showButton)
    }
    
    func customNavBarItems(twoColumnsNavBar: Bool = false, title: String = "", subtitle: String? = nil, showButton: NavBarButton = NavBarButton.none) -> some View {
        self
            .customNavigationTwoColumnsNavBar(twoColumnsNavBar)
            .customNavigationTitle(title)
            .customNavigationSubtitle(subtitle)
            .customNavigationShowButton(showButton)
    }
}
