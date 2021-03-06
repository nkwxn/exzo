//
//  NewUserAccount.swift
//  Atemis
//
//  Created by Nicholas on 30/10/21.
//

import Foundation
import CloudKit

struct NewUserAccount: Identifiable {
    var id = UUID()
    var rID: CKRecord.ID?
    var recordID: String?
    var fName: String
    var lName: String
    var email: String
    var pwd: String
    
    var picThumb: String?
    var nickName: String?
}
