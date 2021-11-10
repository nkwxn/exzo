//
//  TriggerAreas.swift
//  exzo
//
//  Created by Daniella Stefani on 04/11/21.
//

import Foundation

enum TriggerArea: String {
    case face = "Face"
    case frontShoulder = "Front Shoulder"
    case frontLeftShoulder = "Front Left Shoulder"
    case frontRightShoulder = "Front Right Shoulder"
    case frontLeftBisep = "Front Left Bisep"
    case frontRightBisep = "Front Right Bisep"
    case frontChest = "Front Chest"
    case frontLeftArm = "Front Left Arm"
    case frontRightArm = "Front Right Arm"
    case frontBelly = "Front Belly"
    case frontLeftFinger = "Front Left Finger"
    case frontRightFinger = "Front Right Finger"
    case frontGenitals = "Genitals"
    case frontLeftThigh = "Front Left Thigh"
    case frontRightThigh = "Front Right Thigh"
    case frontLeftKnee = "Front Left Knee"
    case frontRightKnee = "Front Right Knee"
    case frontLeftFoot = "Front Left Foot"
    case frontRightFoot = "Front Right Foot"
    
    case backHead = "Head"
    case backShoulder = "Back Shoulder"
    case backLeftShoulder = "Back Left Shoulder"
    case backRightShoulder = "Back Right Shoulder"
    case backLeftBisep = "Back Left Bisep"
    case backRightBisep = "Back Right Bisep"
    case backChest = "Back Chest"
    case backLeftArm = "Back Left Arm"
    case backRightArm = "Back Right Arm"
    case backBelly = "Back Belly"
    case backLeftFinger = "Back Left Finger"
    case backRightFinger = "Back Right Finger"
    case backLeftThigh = "Back Left Thigh"
    case backRightThigh = "Back Right Thigh"
    case backLeftKnee = "Back Left Knee"
    case backRightKnee = "Back Right Knee"
    case backLeftFoot = "Back Left Foot"
    case backRightFoot = "Back Right Foot"

    // swiftlint:disable all
    func getScore() -> Double {
        switch self {
        case .face:
            return 4.5
        case .frontLeftShoulder:
            return 1.5
        case .frontShoulder:
            return 6
        case .frontRightShoulder:
            return 1.5
        case .frontLeftBisep:
            return 1.5
        case .frontChest:
            return 6
        case .frontRightBisep:
            return 1.5
        case .frontLeftArm:
            return 1.5
        case .frontBelly:
            return 6
        case .frontRightArm:
            return 1.5
        case .frontLeftFinger:
            return 1
        case .frontGenitals:
            return 1
        case .frontRightFinger:
            return 1
        case .frontLeftThigh:
            return 3
        case .frontRightThigh:
            return 3
        case .frontLeftKnee:
            return 3
        case .frontRightKnee:
            return 3
        case .frontLeftFoot:
            return 3
        case .frontRightFoot:
            return 3
         
        case .backHead:
            return 4.5
        case .backLeftShoulder:
            return 1.5
        case .backShoulder:
            return 6
        case .backRightShoulder:
            return 1.5
        case .backLeftBisep:
            return 1.5
        case .backChest:
            return 6
        case .backRightBisep:
            return 1.5
        case .backLeftArm:
            return 1.5
        case .backBelly:
            return 6
        case .backRightArm:
            return 1.5
        case .backLeftFinger:
            return 1
        case .backRightFinger:
            return 1
        case .backLeftThigh:
            return 3
        case .backRightThigh:
            return 3
        case .backLeftKnee:
            return 3
        case .backRightKnee:
            return 3
        case .backLeftFoot:
            return 3
        case .backRightFoot:
            return 3
        }
    }
}
