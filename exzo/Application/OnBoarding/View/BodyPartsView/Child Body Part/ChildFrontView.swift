//
//  ChildFrontView.swift
//  exzo
//
//  Created by Difa N Pratama on 23/11/21.
//

import SwiftUI

// swiftlint:disable all
struct ChildFrontView: View {
    //  Front Body
    @State var isChildFrontHead: Bool = false
    @State var isChildFrontBelly: Bool = false
    @State var isChildFrontChest: Bool = false
    @State var isChildFrontShoulder: Bool = false
    @State var isChildFrontNeck: Bool = false
    @State var isChildFrontVital: Bool = false
    //  Front Arm
    @State var isChildFrontRightShoulder: Bool = false
    @State var isChildFrontRightElbow: Bool = false
    @State var isChildFrontRightArm: Bool = false
    @State var isChildFrontRightFinger: Bool = false
    @State var isChildFrontLeftShoulder: Bool = false
    @State var isChildFrontLeftElbow: Bool = false
    @State var isChildFrontLeftArm: Bool = false
    @State var isChildFrontLeftFinger: Bool = false
    //  Front Knee
    @State var isChildFrontRightHip: Bool = false
    @State var isChildFrontRightThigh: Bool = false
    @State var isChildFrontRightKnee: Bool = false
    @State var isChildFrontRightLeg: Bool = false
    @State var isChildFrontRightFoot: Bool = false
    @State var isChildFrontLeftHip: Bool = false
    @State var isChildFrontLeftThigh: Bool = false
    @State var isChildFrontLeftKnee: Bool = false
    @State var isChildFrontLeftLeg: Bool = false
    @State var isChildFrontLeftFoot: Bool = false
    
    @Binding var score: Float
    @Binding var bodyArr: [String]
    var body: some View {
        ZStack {
            // MARK: - Body
            Group {
                Button {
                    self.isChildFrontHead.toggle()
                    if isChildFrontHead {
                        score += 4.5
                        bodyArr.append("CF - Head")
                    } else {
                        score -= 4.5
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isChildFrontHead ? "SCF - Head" : "CF - Head")
                        .resizable()
                        .frame(width: 44.93, height: 54.81)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 44.93, height: 54.81)
                .position(x: (UIScreen.main.bounds.width / 4.32), y: (UIScreen.main.bounds.height / 3.95))
                
                Button {
                    self.isChildFrontNeck.toggle()
                    if isChildFrontNeck {
                        score += 6.0
                        bodyArr.append("CF - Neck")
                    } else {
                        score -= 6.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isChildFrontNeck ? "SCF - Neck" : "CF - Neck")
                        .resizable()
                        .frame(width: 20.31, height: 6.26)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 20.31, height: 6.26)
                .position(x: (UIScreen.main.bounds.width / 4.32), y: (UIScreen.main.bounds.height / 3.45))
                
                Button {
                    self.isChildFrontShoulder.toggle()
                    if isChildFrontShoulder {
                        score += 6.0
                        bodyArr.append("CF - Shoulder")
                    } else {
                        score -= 6.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isChildFrontShoulder ? "SCF - Shoulder" : "B - Shoulder")
                        .resizable()
                        .frame(width: 52.22, height: 21.11)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 52.22, height: 21.11)
                .position(x: (UIScreen.main.bounds.width / 4.35), y: (UIScreen.main.bounds.height / 3.26))
                
                Button {
                    self.isChildFrontChest.toggle()
                    if isChildFrontChest {
                        score += 6.0
                        bodyArr.append("CF - Chest")
                    } else {
                        score -= 6.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isChildFrontChest ? "SCF - Chest" : "CF - Chest")
                        .resizable()
                        .frame(width: 50.42, height: 29.5)
                        .aspectRatio(contentMode: .fill)
                }
                .frame(width: 50.42, height: 29.5)
                .position(x: (UIScreen.main.bounds.width / 4.33), y: (UIScreen.main.bounds.height / 2.97))
                
                Button {
                    self.isChildFrontBelly.toggle()
                    if isChildFrontBelly {
                        score += 6.0
                        bodyArr.append("CF - Belly")
                    } else {
                        score -= 6.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isChildFrontBelly ? "SCF - Belly" : "CF - Belly")
                        .resizable()
                        .frame(width: 51.93, height: 35.35)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 51.93, height: 35.35)
                .position(x: (UIScreen.main.bounds.width / 4.32), y: (UIScreen.main.bounds.height / 2.7))
                
                Button {
                    self.isChildFrontVital.toggle()
                    if (isChildFrontVital) {
                        bodyArr.append("CF - Vital")
                        score += 1.0
                    } else {
                        score -= 1.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isChildFrontVital ? "SCF - Vital" : "CF - Vital")
                        .resizable()
                        .frame(width: 14.66, height: 14.97)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 14.66, height: 14.97)
                .position(x: (UIScreen.main.bounds.width / 4.32), y: (UIScreen.main.bounds.height / 2.53))
                
                Button {
                    self.isChildFrontRightHip.toggle()
                    if isChildFrontRightHip {
                        score += 3.0
                        bodyArr.append("CF - Right Hip")
                    } else {
                        score -= 3.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isChildFrontRightHip ? "SCF - Right Hip" : "CF - Right Hip")
                        .resizable()
                        .frame(width: 27.46, height: 37.6)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 27.46, height: 37.6)
                .position(x: (UIScreen.main.bounds.width / 5.18), y: (UIScreen.main.bounds.height / 2.51))
                Button {
                    self.isChildFrontLeftHip.toggle()
                    if isChildFrontLeftHip {
                        score += 3.0
                        bodyArr.append("CF - Left Hip")
                    } else {
                        score -= 3.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isChildFrontLeftHip ? "SCF - Left Hip" : "CF - Left Hip")
                        .resizable()
                        .frame(width: 27.31, height: 37.92)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 27.31, height: 37.92)
                .position(x: (UIScreen.main.bounds.width / 3.72), y: (UIScreen.main.bounds.height / 2.51))
            }
            
            // MARK: - Left Hand
            Group {
                Button {
                    self.isChildFrontLeftShoulder.toggle()
                    if isChildFrontLeftShoulder {
                        score += 1.5
                        bodyArr.append("CF - Left Shoulder")
                    } else {
                        score -= 1.5
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isChildFrontLeftShoulder ? "SCF - Left Shoulder" : "CF - Left Shoulder")
                        .resizable()
                        .frame(width: 16.13, height: 44.03)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 16.13, height: 44.03)
                .position(x: (UIScreen.main.bounds.width / 3.15), y: (UIScreen.main.bounds.height / 3.05))
                
                Button {
                    self.isChildFrontLeftElbow.toggle()
                    if isChildFrontLeftElbow {
                        score += 1.5
                        bodyArr.append("CF - Left Elbow")
                    } else {
                        score -= 1.5
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isChildFrontLeftElbow ? "SCF - Left Elbow" : "CF - Left Elbow")
                        .resizable()
                        .frame(width: 12.7, height: 13.21)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 12.7, height: 13.21)
                .position(x: (UIScreen.main.bounds.width / 3.04), y: (UIScreen.main.bounds.height / 2.79))
                
                Button {
                    self.isChildFrontLeftArm.toggle()
                    if isChildFrontLeftArm {
                        score += 1.5
                        bodyArr.append("CF - Left Arm")
                    } else {
                        score -= 1.5
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isChildFrontLeftArm ? "SCF - Left Arm" : "CF - Left Arm")
                        .resizable()
                        .frame(width: 18.55, height: 29.46)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 18.55, height: 29.46)
                .position(x: (UIScreen.main.bounds.width / 2.94), y: (UIScreen.main.bounds.height / 2.63))
                
                Button {
                    self.isChildFrontLeftFinger.toggle()
                    if isChildFrontLeftFinger {
                        score += 1.5
                        bodyArr.append("CF - Left Finger")
                    } else {
                        score -= 1.5
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isChildFrontLeftFinger ? "SCF - Left Finger" : "CF - Left Finger")
                        .resizable()
                        .frame(width: 20.88, height: 34.1)
                        .aspectRatio(contentMode: .fit)
                    
                }
                .frame(width: 20.88, height: 34.1)
                .position(x: (UIScreen.main.bounds.width / 2.85), y: (UIScreen.main.bounds.height / 2.4))
                
            }
            
            // MARK: - Right Hand
            Group {
                Button {
                    self.isChildFrontRightShoulder.toggle()
                    if isChildFrontRightShoulder {
                        score += 1.5
                        bodyArr.append("CF - Right Shoulder")
                    } else {
                        score -= 1.5
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isChildFrontRightShoulder ? "SCF - Right Shoulder" : "CF - Right Shoulder")
                        .resizable()
                        .frame(width: 16.13, height: 44.03)
                        .aspectRatio(contentMode: .fit)
                    
                }
                .frame(width: 16.13, height: 44.03)
                .position(x: (UIScreen.main.bounds.width / 6.97), y: (UIScreen.main.bounds.height / 3.05))
                
                Button {
                    self.isChildFrontRightElbow.toggle()
                    if isChildFrontRightElbow {
                        score += 1.5
                        bodyArr.append("CF - Right Elbow")
                    } else {
                        score -= 1.5
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isChildFrontRightElbow ? "SCF - Right Elbow" : "CF - Right Elbow")
                        .resizable()
                        .frame(width: 12.7, height: 13.21)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 12.7, height: 13.21)
                .position(x: (UIScreen.main.bounds.width / 7.6), y: (UIScreen.main.bounds.height / 2.79))
                
                Button {
                    self.isChildFrontRightArm.toggle()
                    if isChildFrontRightArm {
                        score += 1.5
                        bodyArr.append("CF - Right Arm")
                    } else {
                        score -= 1.5
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isChildFrontRightArm ? "SCF - Right Arm" : "CF - Right Arm")
                        .resizable()
                        .frame(width: 18.55, height: 29.46)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 18.55, height: 29.46)
                .position(x: (UIScreen.main.bounds.width / 8.4), y: (UIScreen.main.bounds.height / 2.63))
                
                Button {
                    self.isChildFrontRightFinger.toggle()
                    if (isChildFrontRightFinger) {
                        score += 1.5
                        bodyArr.append("CF - Right Finger")
                    } else {
                        score -= 1.5
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isChildFrontRightFinger ? "SCF - Right Finger" : "CF - Right Finger")
                        .resizable()
                        .frame(width: 20.88, height: 34.1)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 20.88, height: 34.1)
                .position(x: (UIScreen.main.bounds.width / 9.2), y: (UIScreen.main.bounds.height / 2.4))
                
            }
            
            //  MARK: - Right Knee
            Group {
                Button {
                    self.isChildFrontRightThigh.toggle()
                    if isChildFrontRightThigh {
                        score += 3.0
                        bodyArr.append("CF - Right Thigh")
                    } else {
                        score -= 3.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isChildFrontRightThigh ? "SCF - Right Thigh" : "CF - Right Thigh")
                        .resizable()
                        .frame(width: 25.78, height: 37.61)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 25.78, height: 37.61)
                .position(x: (UIScreen.main.bounds.width / 5.24), y: (UIScreen.main.bounds.height / 2.25))
                
                Button {
                    self.isChildFrontRightKnee.toggle()
                    if isChildFrontRightKnee {
                        score += 3.0
                        bodyArr.append("CF - Right Knee")
                    } else {
                        score -= 3.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isChildFrontRightKnee ? "SCF - Right Knee" : "CF - Right Knee")
                        .resizable()
                        .frame(width: 17.48, height: 17.85)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 17.48, height: 17.85)
                .position(x: (UIScreen.main.bounds.width / 5.05), y: (UIScreen.main.bounds.height / 2.12))
                
                Button {
                    self.isChildFrontRightLeg.toggle()
                    if isChildFrontRightLeg {
                        score += 3.0
                        bodyArr.append("CF - Right Leg")
                    } else {
                        score -= 3.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isChildFrontRightLeg ? "SCF - Right Leg" : "CF - Right Leg")
                        .resizable()
                        .frame(width: 18.71, height: 42.46)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 18.71, height: 42.46)
                .position(x: (UIScreen.main.bounds.width / 5.05), y: (UIScreen.main.bounds.height / 1.99))
                
                Button {
                    self.isChildFrontRightFoot.toggle()
                    if isChildFrontRightFoot {
                        score += 3.0
                        bodyArr.append("CF - Right Foot")
                    } else {
                        score -= 3.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isChildFrontRightFoot ? "SCF - Right Foot" : "CF - Right Foot")
                        .resizable()
                        .frame(width: 17.99, height: 14.86)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 17.99, height: 14.86)
                .position(x: (UIScreen.main.bounds.width / 5.1), y: (UIScreen.main.bounds.height / 1.86))
                
            }
            
            //  Left Knee
            Group {
                Button {
                    self.isChildFrontLeftThigh.toggle()
                    if isChildFrontLeftThigh {
                        score += 3.0
                        bodyArr.append("CF - Left Thigh")
                    } else {
                        score -= 3.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isChildFrontLeftThigh ? "SCF - Left Thigh" : "CF - Left Thigh")
                        .resizable()
                        .frame(width: 25.78, height: 37.61)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 25.78, height: 37.61)
                .position(x: (UIScreen.main.bounds.width / 3.74), y: (UIScreen.main.bounds.height / 2.25))
                
                Button {
                    self.isChildFrontLeftKnee.toggle()
                    if isChildFrontLeftKnee {
                        score += 3.0
                        bodyArr.append("CF - Left Knee")
                    } else {
                        score -= 3.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isChildFrontLeftKnee ? "SCF - Left Knee" : "CF - Left Knee")
                        .resizable()
                        .frame(width: 17.48, height: 17.85)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 17.48, height: 17.85)
                .position(x: (UIScreen.main.bounds.width / 3.85), y: (UIScreen.main.bounds.height / 2.12))
                
                Button {
                    self.isChildFrontLeftLeg.toggle()
                    if isChildFrontLeftLeg {
                        score += 3.0
                        bodyArr.append("CF - Left Leg")
                    } else {
                        score -= 3.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isChildFrontLeftLeg ? "SCF - Left Leg" : "CF - Left Leg")
                        .resizable()
                        .frame(width: 18.71, height: 42.46)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 18.71, height: 42.46)
                .position(x: (UIScreen.main.bounds.width / 3.85), y: (UIScreen.main.bounds.height / 1.99))
                
                Button {
                    self.isChildFrontLeftFoot.toggle()
                    if isChildFrontLeftFoot {
                        score += 3.0
                        bodyArr.append("CF - Left Foot")
                    } else {
                        score -= 3.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isChildFrontLeftFoot ? "SCF - Left Foot" : "CF - Left Foot")
                        .resizable()
                        .frame(width: 17.99, height: 14.86)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 17.99, height: 14.86)
                .position(x: (UIScreen.main.bounds.width / 3.8), y: (UIScreen.main.bounds.height / 1.86))
            }
        }
    }
}

struct ChildFrontView_Previews: PreviewProvider {
    static var previews: some View {
        ChildFrontView(score: Binding.constant(0), bodyArr: Binding.constant([""]))
    }
}
