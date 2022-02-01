//
//  Batu.swift
//  skripsiDifa
//
//  Created by Difa N Pratama on 07/01/22.
//

import Foundation
import SwiftUI

struct Bahan: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var bahanMengandung: [String]
    var description: String
}
