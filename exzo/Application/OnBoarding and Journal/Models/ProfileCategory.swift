//
//  ProfileCategory.swift
//  exzo
//
//  Created by Nicholas on 22/11/21.
//

import Foundation
import SwiftUI

enum ProfileCategory: String, CaseIterable {
    case child = "Anak"
    case adult = "Dewasa"
    
    func getImageName() -> Image {
        switch self {
        case .child:
            return Image("L0 - KidsB")
        case .adult:
            return Image("L0 - Boy")
        }
    }
    
    func getProfileDesc() -> String {
        switch self {
        case .child:
            return "Kami senang jika Anda memperkenalkan kami dengan anak Anda! Silakan masukkan beberapa informasi tentangnya."
        case .adult:
            return "Kami senang jika Anda memperkenalkan diri Anda agar menjadi lebih dekat. Silakan masukkan beberapa informasi Anda."
        }
    }
}
