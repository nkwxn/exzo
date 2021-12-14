//
//   FrontBodyView.swift
//   exzo
//
//   Created by Difa N Pratama on 09/11/21.
//

import SwiftUI

// swiftlint:disable all
struct FrontBodyView: View {
    //  Front Body
    @State var isFrontHead: Bool = false
    @State var isFrontBelly: Bool = false
    @State var isFrontChest: Bool = false
    @State var isFrontShoulder: Bool = false
    @State var isFrontNeck: Bool = false
    @State var isFrontVital: Bool = false
    //  Front Arm
    @State var isFrontRightMuscle: Bool = false
    @State var isFrontRightElbow: Bool = false
    @State var isFrontRightArm: Bool = false
    @State var isFrontRightFinger: Bool = false
    @State var isFrontLeftMuscle: Bool = false
    @State var isFrontLeftElbow: Bool = false
    @State var isFrontLeftArm: Bool = false
    @State var isFrontLeftFinger: Bool = false
    //  Front Knee
    @State var isFrontRightHip: Bool = false
    @State var isFrontRightThigh: Bool = false
    @State var isFrontRightKnee: Bool = false
    @State var isFrontRightLeg: Bool = false
    @State var isFrontRightFoot: Bool = false
    @State var isFrontLeftHip: Bool = false
    @State var isFrontLeftThigh: Bool = false
    @State var isFrontLeftKnee: Bool = false
    @State var isFrontLeftLeg: Bool = false
    @State var isFrontLeftFoot: Bool = false
    
    @Binding var score: Float
    @Binding var bodyArr: [String]
    var body: some View {
        ZStack {
            // MARK: - Body
            Group {
                Button {
                    self.isFrontHead.toggle()
                    if isFrontHead {
                        score += 4.5
                        bodyArr.append("F - Head")
                    } else {
                        score -= 4.5
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isFrontHead ? "SF - Head" : "F - Head")
                        .resizable()
                        .frame(width: 34.78, height: 37.5)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 45, height: 52)
                .position(x: (UIScreen.main.bounds.width / 4.32), y: (UIScreen.main.bounds.height / 3.95))
                
                Button {
                    self.isFrontNeck.toggle()
                    if isFrontNeck {
                        score += 6.0
                        bodyArr.append("F - Neck")
                    } else {
                        score -= 6.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isFrontNeck ? "SF - Neck" : "F - Neck")
                        .resizable()
                        .frame(width: 26.51, height: 5.95)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 26.51, height: 5.95)
                .position(x: (UIScreen.main.bounds.width / 4.32), y: (UIScreen.main.bounds.height / 3.57))
                
                Button {
                    self.isFrontShoulder.toggle()
                    if isFrontShoulder {
                        score += 6.0
                        bodyArr.append("F - Shoulder")
                    } else {
                        score -= 6.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isFrontShoulder ? "SF - Shoulder" : "B - Shoulder")
                        .resizable()
                        .frame(width: 56.64, height: 25.89)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 56.64, height: 25.89)
                .position(x: (UIScreen.main.bounds.width / 4.35), y: (UIScreen.main.bounds.height / 3.33))
                
                Button {
                    self.isFrontChest.toggle()
                    if isFrontChest {
                        score += 6.0
                        bodyArr.append("F - Chest")
                    } else {
                        score -= 6.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isFrontChest ? "SF - Chest" : "F - Chest")
                        .resizable()
                        .frame(width: 58, height: 36.4)
                        .aspectRatio(contentMode: .fill)
                }
                .frame(width: 58, height: 36.4)
                .position(x: (UIScreen.main.bounds.width / 4.33), y: (UIScreen.main.bounds.height / 2.96))
                
                Button {
                    self.isFrontBelly.toggle()
                    if isFrontBelly {
                        score += 6.0
                        bodyArr.append("F - Belly")
                    } else {
                        score -= 6.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isFrontBelly ? "SF - Belly" : "F - Belly")
                        .resizable()
                        .frame(width: 56.39, height: 50.87)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 56.39, height: 50.87)
                .position(x: (UIScreen.main.bounds.width / 4.32), y: (UIScreen.main.bounds.height / 2.56))
                
                Button {
                    self.isFrontVital.toggle()
                    if (isFrontVital) {
                        bodyArr.append("F - Vital")
                        score += 1.0
                    } else {
                        score -= 1.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isFrontVital ? "SF - Vital" : "F - Vital")
                        .resizable()
                        .frame(width: 13.02, height: 13.02)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 13.02, height: 13.02)
                .position(x: (UIScreen.main.bounds.width / 4.33), y: (UIScreen.main.bounds.height / 2.375))
                
                Button {
                    self.isFrontRightHip.toggle()
                    if isFrontRightHip {
                        score += 3.0
                        bodyArr.append("F - Right Hip")
                    } else {
                        score -= 3.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isFrontRightHip ? "SF - Right Hip" : "F - Right Hip")
                        .resizable()
                        .frame(width: 30.49, height: 45.62)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 30.49, height: 45.62)
                .position(x: (UIScreen.main.bounds.width / 5.24), y: (UIScreen.main.bounds.height / 2.3))
                Button {
                    self.isFrontLeftHip.toggle()
                    if isFrontLeftHip {
                        score += 3.0
                        bodyArr.append("F - Left Hip")
                    } else {
                        score -= 3.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isFrontLeftHip ? "SF - Left Hip" : "F - Left Hip")
                        .resizable()
                        .frame(width: 30.02, height: 44.87)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 30.02, height: 44.87)
                .position(x: (UIScreen.main.bounds.width / 3.72), y: (UIScreen.main.bounds.height / 2.3))
            }
            
            // MARK: - Left Hand
            Group {
                Button {
                    self.isFrontLeftMuscle.toggle()
                    if isFrontLeftMuscle {
                        score += 1.5
                        bodyArr.append("F - Left Muscle")
                    } else {
                        score -= 1.5
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isFrontLeftMuscle ? "SF - Left Muscle" : "F - Left Muscle")
                        .resizable()
                        .frame(width: 21.13, height: 54.14)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 21.13, height: 54.14)
                .position(x: (UIScreen.main.bounds.width / 3), y: (UIScreen.main.bounds.height / 3.07))
                
                Button {
                    self.isFrontLeftElbow.toggle()
                    if isFrontLeftElbow {
                        score += 1.5
                        bodyArr.append("F - Left Elbow")
                    } else {
                        score -= 1.5
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isFrontLeftElbow ? "SF - Left Elbow" : "F - Left Elbow")
                        .resizable()
                        .frame(width: 16.17, height: 16.83)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 16.17, height: 16.83)
                .position(x: (UIScreen.main.bounds.width / 2.91), y: (UIScreen.main.bounds.height / 2.74))
                
                Button {
                    self.isFrontLeftArm.toggle()
                    if isFrontLeftArm {
                        score += 1.5
                        bodyArr.append("F - Left Arm")
                    } else {
                        score -= 1.5
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isFrontLeftArm ? "SF - Left Arm" : "F - Left Arm")
                        .resizable()
                        .frame(width: 18.67, height: 38.54)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 18.67, height: 38.54)
                .position(x: (UIScreen.main.bounds.width / 2.852), y: (UIScreen.main.bounds.height / 2.53))
                
                Button {
                    self.isFrontLeftFinger.toggle()
                    if isFrontLeftFinger {
                        score += 1.5
                        bodyArr.append("F - Left Finger")
                    } else {
                        score -= 1.5
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isFrontLeftFinger ? "SF - Left Finger" : "F - Left Finger")
                        .resizable()
                        .frame(width: 13.42, height: 28.09)
                        .aspectRatio(contentMode: .fit)
                    
                }
                .frame(width: 13.42, height: 28.09)
                .position(x: (UIScreen.main.bounds.width / 2.8), y: (UIScreen.main.bounds.height / 2.305))
                
            }
            
            // MARK: - Right Hand
            Group {
                Button {
                    self.isFrontRightMuscle.toggle()
                    if isFrontRightMuscle {
                        score += 1.5
                        bodyArr.append("F - Right Muscle")
                    } else {
                        score -= 1.5
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isFrontRightMuscle ? "SF - Right Muscle" : "F - Right Muscle")
                        .resizable()
                        .frame(width: 21.13, height: 54.14)
                        .aspectRatio(contentMode: .fit)
                    
                }
                .frame(width: 21.13, height: 54.14)
                .position(x: (UIScreen.main.bounds.width / 7.8), y: (UIScreen.main.bounds.height / 3.07))
                
                Button {
                    self.isFrontRightElbow.toggle()
                    if isFrontRightElbow {
                        score += 1.5
                        bodyArr.append("F - Right Elbow")
                    } else {
                        score -= 1.5
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isFrontRightElbow ? "SF - Right Elbow" : "F - Right Elbow")
                        .resizable()
                        .frame(width: 16.17, height: 16.83)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 16.17, height: 16.83)
                .position(x: (UIScreen.main.bounds.width / 8.45), y: (UIScreen.main.bounds.height / 2.74))
                
                Button {
                    self.isFrontRightArm.toggle()
                    if isFrontRightArm {
                        score += 1.5
                        bodyArr.append("F - Right Arm")
                    } else {
                        score -= 1.5
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isFrontRightArm ? "SF - Right Arm" : "F - Right Arm")
                        .resizable()
                        .frame(width: 18.67, height: 38.54)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 18.67, height: 38.54)
                .position(x: (UIScreen.main.bounds.width / 9), y: (UIScreen.main.bounds.height / 2.53))
                
                Button {
                    self.isFrontRightFinger.toggle()
                    if (isFrontRightFinger) {
                        score += 1.5
                        bodyArr.append("F - Right Finger")
                    } else {
                        score -= 1.5
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isFrontRightFinger ? "SF - Right Finger" : "F - Right Finger")
                        .resizable()
                        .frame(width: 13.42, height: 28.09)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 13.42, height: 28.09)
                .position(x: (UIScreen.main.bounds.width / 9.6), y: (UIScreen.main.bounds.height / 2.305))
                
            }
            
            //  MARK: - Right Knee
            Group {
                Button {
                    self.isFrontRightThigh.toggle()
                    if isFrontRightThigh {
                        score += 3.0
                        bodyArr.append("F - Right Thigh")
                    } else {
                        score -= 3.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isFrontRightThigh ? "SF - Right Thigh" : "F - Right Thigh")
                        .resizable()
                        .frame(width: 26.44, height: 34.05)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 26.44, height: 34.05)
                .position(x: (UIScreen.main.bounds.width / 5.24), y: (UIScreen.main.bounds.height / 2.07))
                
                Button {
                    self.isFrontRightKnee.toggle()
                    if isFrontRightKnee {
                        score += 3.0
                        bodyArr.append("F - Right Knee")
                    } else {
                        score -= 3.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isFrontRightKnee ? "SF - Right Knee" : "F - Right Knee")
                        .resizable()
                        .frame(width: 16.72, height: 17.07)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 16.72, height: 17.07)
                .position(x: (UIScreen.main.bounds.width / 5.26), y: (UIScreen.main.bounds.height / 1.97))
                
                Button {
                    self.isFrontRightLeg.toggle()
                    if isFrontRightLeg {
                        score += 3.0
                        bodyArr.append("F - Right Leg")
                    } else {
                        score -= 3.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isFrontRightLeg ? "SF - Right Leg" : "F - Right Leg")
                        .resizable()
                        .frame(width: 22.56, height: 60.19)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 22.56, height: 60.19)
                .position(x: (UIScreen.main.bounds.width / 5.3), y: (UIScreen.main.bounds.height / 1.83))
                
                Button {
                    self.isFrontRightFoot.toggle()
                    if isFrontRightFoot {
                        score += 3.0
                        bodyArr.append("F - Right Foot")
                    } else {
                        score -= 3.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isFrontRightFoot ? "SF - Right Foot" : "F - Right Foot")
                        .resizable()
                        .frame(width: 22.75, height: 20.18)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 22.75, height: 20.18)
                .position(x: (UIScreen.main.bounds.width / 5.2), y: (UIScreen.main.bounds.height / 1.68))
                
            }
            
            //  Left Knee
            Group {
                Button {
                    self.isFrontLeftThigh.toggle()
                    if isFrontLeftThigh {
                        score += 3.0
                        bodyArr.append("F - Left Thigh")
                    } else {
                        score -= 3.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isFrontLeftThigh ? "SF - Left Thigh" : "F - Left Thigh")
                        .resizable()
                        .frame(width: 26.44, height: 34.05)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 26.44, height: 34.05)
                .position(x: (UIScreen.main.bounds.width / 3.74), y: (UIScreen.main.bounds.height / 2.07))
                
                Button {
                    self.isFrontLeftKnee.toggle()
                    if isFrontLeftKnee {
                        score += 3.0
                        bodyArr.append("F - Left Knee")
                    } else {
                        score -= 3.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isFrontLeftKnee ? "SF - Left Knee" : "F - Left Knee")
                        .resizable()
                        .frame(width: 16.72, height: 17.07)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 16.72, height: 17.07)
                .position(x: (UIScreen.main.bounds.width / 3.7), y: (UIScreen.main.bounds.height / 1.97))
                
                Button {
                    self.isFrontLeftLeg.toggle()
                    if isFrontLeftLeg {
                        score += 3.0
                        bodyArr.append("F - Left Leg")
                    } else {
                        score -= 3.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isFrontLeftLeg ? "SF - Left Leg" : "F - Left Leg")
                        .resizable()
                        .frame(width: 22.56, height: 60.19)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 22.56, height: 60.19)
                .position(x: (UIScreen.main.bounds.width / 3.715), y: (UIScreen.main.bounds.height / 1.83))
                
                Button {
                    self.isFrontLeftFoot.toggle()
                    if isFrontLeftFoot {
                        score += 3.0
                        bodyArr.append("F - Left Foot")
                    } else {
                        score -= 3.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isFrontLeftFoot ? "SF - Left Foot" : "F - Left Foot")
                        .resizable()
                        .frame(width: 22.75, height: 20.18)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 22.75, height: 20.18)
                .position(x: (UIScreen.main.bounds.width / 3.75), y: (UIScreen.main.bounds.height / 1.68))
            }
        }
    }
}


struct FrontBodyView_Previews: PreviewProvider {
    static var previews: some View {
        FrontBodyView(score: Binding.constant(0), bodyArr: Binding.constant([""]))
    }
}
