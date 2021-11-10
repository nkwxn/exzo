//
//  UDHelper.swift
//  Atemis
//
//  Created by Deven Nathanael on 01/11/21.
//

import Foundation
import SwiftUI

enum UDKey: String{
    case loginUserID = "loginUserID"
    case newUser = "newUser"
    case triggeredBodyParts = "triggeredBodyParts"
}

class UDHelper{
    static let sharedUD = UDHelper()
    
    let defaults = UserDefaults.standard
    
    func createUD(key: String, value: Any){
        defaults.setValue(value, forKey: key)
    }
    
    func isNewUser() -> Bool {
        defaults.bool(forKey: UDKey.newUser.rawValue)
    }
    
    func setNewUser() {
        defaults.setValue(false, forKey: UDKey.newUser.rawValue)
    }    
}

struct DeviceUserDefault{
    let defaults = UserDefaults.standard
//    private func getUserDefault(){
//        let tempArchiveItems = defaults.data(forKey: "BodyPart")
//        print("tempArchiveItems ", tempArchiveItems as Any)
//        if(tempArchiveItems != nil){
//            devices = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(tempArchiveItems!) as! []
//            //            print("Devices User Default = ", devices[0].deviceName)
//        }
//        return devices
//    }
//    public func addDevice(device: DeviceDetail){
//        var devices = getUserDefault()
//        device.deviceID = totalDevice
//        devices.insert(device, at: devices.endIndex)
//        setUserDefault(devices: devices)
//    }
//
//    public func setUD(store: Any?, key: String){
//        defaults.set(store, forKey: key)
//    }
//
    
}
