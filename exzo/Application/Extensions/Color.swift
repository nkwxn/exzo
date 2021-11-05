//
//  Color.swift
//  exzo
//
//  Created by Difa N Pratama on 03/11/21.
// Resource : [https://stackoverflow.com/questions/58516229/how-to-add-a-new-swiftui-color]

import Foundation
import SwiftUI

extension Color {
    static let customUI = Color.CustomUI()
    static let copper = Color("accent_copper")
    static let brandy = Color("accent_brandy")
    static let accentYellow = Color("accent_yellow")
    static let antique = Color("accent_antique")
    
    struct CustomUI {
        let green = Color("green_primary")
        let copper = Color("accent_copper")
        let brandy = Color("accent_brandy")
        let accentYellow = Color("accent_yellow")
        let antique = Color("accent_antique")
    }
}
