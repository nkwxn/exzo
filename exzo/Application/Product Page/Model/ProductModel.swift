//
//  ProductModel.swift
//  Atemis
//
//  Created by Daniella Stefani on 01/11/21.
//

import Foundation

enum ProductType: String, CaseIterable {
    case shampoo = "Shampoo"
    case bodyWash = "Body Wash"
    case faceWash = "Face Wash"
    case moisturizer = "Moisturizer"
    case ointment = "Ointment"
    case lotion = "Lotion"
    case cream = "Cream"
    case handCream = "Hand Cream"
    case sunscreen = "Sunscreen"
    case others = "Others"
    
    // TODO: Create localization in 2 languages
    func getLocalizedName() -> String {
        switch self {
        case .shampoo:
            return "Sampo"
        case .bodyWash:
            return "Sabun Badan"
        case .faceWash:
            return "Sabun Cuci Muka"
        case .moisturizer:
            return "Pelembap"
        case .ointment:
            return "Salep"
        case .lotion:
            return "Losion"
        case .cream:
            return "Krim"
        case .handCream:
            return "Krim Tangan"
        case .sunscreen:
            return "Tabir Surya"
        case .others:
            return "Lainnya"
        }
    }
}
