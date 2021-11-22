//
//  ProfileCategory.swift
//  exzo
//
//  Created by Nicholas on 22/11/21.
//

import Foundation
import SwiftUI

enum ProfileCategory: String, CaseIterable {
    case child = "Child"
    case adult = "Adult"
    
    func getImageName() -> Image {
        switch self {
        case .child:
            return Image("childbtn")
        case .adult:
            return Image("adultbtn")
        }
    }
    
    func getProfileDesc() -> String {
        switch self {
        case .child:
            return "We would be happy if you introduce us with your child! Please input some information about him/her."
        case .adult:
            return "We would be happy if you introduce yourself to us! Please input some information about you."
        }
    }
}
