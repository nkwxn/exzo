//
//   FrontBodyView.swift
//   exzo
//
//   Created by Difa N Pratama on 09/11/21.
//

import SwiftUI

struct FrontBodyView: View {
    //  Front Body
    @State var isFrontHead: Bool = false
    @State var isFrontShoulder: Bool = false
    @State var isFrontChest: Bool = false
    @State var isFrontRightThigh: Bool = false
    @State var isFrontLeftThigh: Bool = false
    @State var isFrontBelly: Bool = false
    @State var isFrontX: Bool = false
    //  Front Arm
    @State var isFrontRightShoulder: Bool = false
    @State var isFrontRightBisep: Bool = false
    @State var isFrontRightArm: Bool = false
    @State var isFrontRightFinger: Bool = false
    @State var isFrontLeftShoulder: Bool = false
    @State var isFrontLeftBisep: Bool = false
    @State var isFrontLeftArm: Bool = false
    @State var isFrontLeftFinger: Bool = false
    //  Front Knee
    @State var isFrontRightKnee: Bool = false
    @State var isFrontRightFoot: Bool = false
    @State var isFrontLeftKnee: Bool = false
    @State var isFrontLeftFoot: Bool = false
    
    @Binding var score: Float
    @Binding var bodyArr: [String]
    var body: some View {
        ZStack {
            // MARK: - Front Body
            Group {
                // MARK: - Body
                Group {
                    Button {
                        self.isFrontHead.toggle()
                        if(isFrontHead) {
                            score += 4.5
                            bodyArr.append("F - Head")
                        } else {
                            score -= 4.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isFrontHead ? "SF - Head" : "F - Head")
                            .resizable()
                            .frame(width: 45, height: 52)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 45, height: 52)
                    .position(x: (UIScreen.main.bounds.width / 4.32), y: (UIScreen.main.bounds.height / 3.95))

                    Button {
                        self.isFrontShoulder.toggle()
                        if (isFrontShoulder) {
                            score += 6.0
                            bodyArr.append("F - Shoulder")
                        } else {
                            score -= 6.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isFrontShoulder ? "SF - Shoulder" : "B - Shoulder")
                            .resizable()
                            .frame(width: 72, height: 40)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 72, height: 40)
                    .position(x: (UIScreen.main.bounds.width / 4.32), y: (UIScreen.main.bounds.height / 3.25))

                    Button {
                        self.isFrontChest.toggle()
                        if (isFrontChest) {
                            score += 6.0
                            bodyArr.append("F - Chest")
                        } else {
                            score -= 6.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isFrontChest ? "SF - Chest" : "B - Chest")
                            .resizable()
                            .frame(width: 76, height: 42)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 76, height: 42)
                    .position(x: (UIScreen.main.bounds.width / 4.32), y: (UIScreen.main.bounds.height / 2.80))
                    
                    Button {
                        self.isFrontRightThigh.toggle()
                        if (isFrontRightThigh) {
                            score += 3.0
                            bodyArr.append("F - Right Thigh")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isFrontRightThigh ? "SF - Right Thigh" : "F- Right Thigh")
                            .resizable()
                            .frame(width: 40, height: 79)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 40, height: 79)
                    .position(x: (UIScreen.main.bounds.width / 3.45), y: (UIScreen.main.bounds.height / 2.11))
                    
                    Button {
                        self.isFrontLeftThigh.toggle()
                        if (isFrontLeftThigh) {
                            score += 3.0
                            bodyArr.append("F - Left Thigh")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isFrontLeftThigh ? "SF - Left Thigh" : "F - Left Thigh")
                            .resizable()
                            .frame(width: 40, height: 79)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 40, height: 79)
                    .position(x: (UIScreen.main.bounds.width / 5.35), y: (UIScreen.main.bounds.height / 2.11))
                    
                    Button {
                        self.isFrontBelly.toggle()
                        if (isFrontBelly) {
                            score += 6.0
                            bodyArr.append("F - Belly")
                        } else {
                            score -= 6.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isFrontBelly ? "SF - Belly" : "F - Belly")
                            .resizable()
                            .frame(width: 76, height: 53)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 76, height: 53)
                    .position(x: (UIScreen.main.bounds.width / 4.24), y: (UIScreen.main.bounds.height / 2.405))
                    
                    Button {
                        self.isFrontX.toggle()
                        if (isFrontX) {
                            bodyArr.append("F - XXX")
                            score += 1.0
                        } else {
                            score -= 1.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Circle()
                            .fill(isFrontX ? Color.copper : .gray)
                            .frame(width: 20, height: 20)
                    }
                    .frame(width: 20, height: 20)
                    .position(x: (UIScreen.main.bounds.width / 4.25), y: (UIScreen.main.bounds.height / 2.22))

                }
                
                // MARK: - Right Hand
                Group {
                    Button {
                        self.isFrontRightShoulder.toggle()
                        if (isFrontRightShoulder) {
                            score += 1.5
                            bodyArr.append("F - Right Shoulder")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isFrontRightShoulder ? "SF - Right Shoulder" : "B - Right Shoulder")
                            .resizable()
                            .frame(width: 28, height: 42)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 28, height: 42)
                    .position(x: (UIScreen.main.bounds.width / 2.76), y: (UIScreen.main.bounds.height / 3.08))
                    
                    Button {
                        self.isFrontRightBisep.toggle()
                        if (isFrontRightBisep) {
                            score += 1.5
                            bodyArr.append("F - Right Bisep")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isFrontRightBisep ? "SF - Right Bisep" : "B - Right Bisep")
                            .resizable()
                            .frame(width: 31, height: 43)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 31, height: 43)
                    .position(x: (UIScreen.main.bounds.width / 2.67), y: (UIScreen.main.bounds.height / 2.7))

                    Button {
                        self.isFrontRightArm.toggle()
                        if (isFrontRightArm) {
                            score += 1.5
                            bodyArr.append("F - Right Arm")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isFrontRightArm ? "SF - Right Arm" : "B - Right Arm")
                            .resizable()
                            .frame(width: 29, height: 53)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 29, height: 53)
                    .position(x: (UIScreen.main.bounds.width / 2.54), y: (UIScreen.main.bounds.height / 2.38))
                    
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
                        Image(isFrontRightFinger ? "SF - Right Finger" : "B - Right Finger")
                            .resizable()
                            .frame(width: 24, height: 39)
                            .aspectRatio(contentMode: .fit)
                            
                    }
                    .frame(width: 24, height: 39)
                    .position(x: (UIScreen.main.bounds.width / 2.5), y: (UIScreen.main.bounds.height / 2.11))
                    
                }
                
                // MARK: - Left Hand
                Group {
                    Button {
                        self.isFrontLeftShoulder.toggle()
                        if (isFrontLeftShoulder) {
                            score += 1.5
                            bodyArr.append("F - Left Shoulder")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isFrontLeftShoulder ? "SF - Left Shoulder" : "B - Left Shoulder")
                            .resizable()
                            .frame(width: 28, height: 42)
                            .aspectRatio(contentMode: .fit)
                            
                    }
                    .frame(width: 28, height: 42)
                    .position(x: (UIScreen.main.bounds.width / 9.59), y: (UIScreen.main.bounds.height / 3.08))

                    Button {
                        self.isFrontLeftBisep.toggle()
                        if (isFrontLeftBisep) {
                            score += 1.5
                            bodyArr.append("F - Left Bisep")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isFrontLeftBisep ? "SF - Left Bisep" : "B - Left Bisep")
                            .resizable()
                            .frame(width: 31, height: 43)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 31, height: 43)
                    .position(x: (UIScreen.main.bounds.width / 10.62), y: (UIScreen.main.bounds.height / 2.7))
                    
                    Button {
                        self.isFrontLeftArm.toggle()
                        if (isFrontLeftArm) {
                            score += 1.5
                            bodyArr.append("F - Left Arm")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isFrontLeftArm ? "SF - Left Arm" : "B - Left Arm")
                            .resizable()
                            .frame(width: 29, height: 53)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 29, height: 53)
                    .position(x: (UIScreen.main.bounds.width / 13), y: (UIScreen.main.bounds.height / 2.38))
                    
                    Button {
                        self.isFrontLeftFinger.toggle()
                        if (isFrontLeftFinger) {
                            score += 1.5
                            bodyArr.append("F - Left Finger")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isFrontLeftFinger ? "SF - Left Finger" : "B - Left Finger")
                            .resizable()
                            .frame(width: 24, height: 39)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 24, height: 39)
                    .position(x: (UIScreen.main.bounds.width / 13.684), y: (UIScreen.main.bounds.height / 2.11))

                }
                
                //  MARK: - Right Knee
                Group {
                    Button {
                        self.isFrontRightKnee.toggle()
                        if (isFrontRightKnee) {
                            score += 3.0
                            bodyArr.append("F - Right Knee")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isFrontRightKnee ? "SF - Right Knee" : "B - Right Knee")
                            .resizable()
                            .frame(width: 35, height: 69)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 35, height: 69)
                    .position(x: (UIScreen.main.bounds.width / 3.5), y: (UIScreen.main.bounds.height / 1.78))

                    Button {
                        self.isFrontRightFoot.toggle()
                        if (isFrontRightFoot) {
                            score += 3.0
                            bodyArr.append("F - Right Foot")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isFrontRightFoot ? "SF - Right Foot" : "B - Right Foot")
                            .resizable()
                            .frame(width: 34, height: 65)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 34, height: 65)
                    .position(x: (UIScreen.main.bounds.width / 3.55), y: (UIScreen.main.bounds.height / 1.555))

                }
                
                //  Left Knee
                Group {
                    Button {
                        self.isFrontLeftKnee.toggle()
                        if (isFrontLeftKnee) {
                            score += 3.0
                            bodyArr.append("F - Left Knee")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isFrontLeftKnee ? "SF - Left Knee" : "B - Left Knee")
                            .resizable()
                            .frame(width: 35, height: 69)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 35, height: 69)
                    .position(x: (UIScreen.main.bounds.width / 5.32), y: (UIScreen.main.bounds.height / 1.78))
                    
                    Button {
                        self.isFrontLeftFoot.toggle()
                        if (isFrontLeftFoot) {
                            score += 3.0
                            bodyArr.append("F - Left Foot")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isFrontLeftFoot ? "SF - Left Foot" : "B - Left Foot")
                            .resizable()
                            .frame(width: 34, height: 65)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 34, height: 65)
                    .position(x: (UIScreen.main.bounds.width / 5.32), y: (UIScreen.main.bounds.height / 1.555))
                    
                }
            }
        }
    }
}

// struct FrontBodyView_Previews: PreviewProvider {
//     static var previews: some View {
//         FrontBodyView(score: Binding.constant(0))
//     }
// }
