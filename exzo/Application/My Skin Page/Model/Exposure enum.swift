//
//  Exposure.swift
//  exzo
//
//  Created by Daniella Stefani on 04/11/21.
//

import Foundation
import SwiftUI

enum Exposures: String {
    case pollen = "Pollen"
    case dust = "Dust"
    case sun = "Sun"
    case mould = "Mould"
    
    func getImage() -> Image {
        switch self {
        case .pollen:
            return Image(systemName: "p.circle.fill")
        case .dust:
            return Image(systemName: "d.circle.fill")
        case .sun:
            return Image(systemName: "s.circle.fill")
        case .mould:
            return Image(systemName: "m.circle.fill")
        }
    }
}
