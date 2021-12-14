//
//   BackBodyView.swift
//   exzo
//
//   Created by Difa N Pratama on 09/11/21.
//

import SwiftUI

// swiftlint:disable all
struct BackBodyView: View {
    //  Back Body
    @State var isBackHead: Bool = false
    @State var isBackLowerBack: Bool = false
    @State var isBackUpperBack: Bool = false
    @State var isBackShoulder: Bool = false
    @State var isBackNeck: Bool = false
    @State var isBackVital: Bool = false
    //  Back Arm
    @State var isBackRightShoulder: Bool = false
    @State var isBackRightElbow: Bool = false
    @State var isBackRightArm: Bool = false
    @State var isBackRightFinger: Bool = false
    @State var isBackLeftShoulder: Bool = false
    @State var isBackLeftElbow: Bool = false
    @State var isBackLeftArm: Bool = false
    @State var isBackLeftFinger: Bool = false
    //  Back Knee
    @State var isBackRightBottom: Bool = false
    @State var isBackRightThigh: Bool = false
    @State var isBackRightKnee: Bool = false
    @State var isBackRightLeg: Bool = false
    @State var isBackRightFoot: Bool = false
    @State var isBackLeftBottom: Bool = false
    @State var isBackLeftThigh: Bool = false
    @State var isBackLeftKnee: Bool = false
    @State var isBackLeftLeg: Bool = false
    @State var isBackLeftFoot: Bool = false
    
    @Binding var score: Float
    @Binding var bodyArr: [String]
    var body: some View {
        ZStack {
            // MARK: - Back Body
            Group {
                // MARK: - Body
                Group {
                    Button {
                        self.isBackHead.toggle()
                        if isBackHead {
                            score += 4.5
                            bodyArr.append("B - Head")
                        } else {
                            score -= 4.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackHead ? "SB - Head" : "B - Head")
                            .resizable()
                            .frame(width: 34.78, height: 37.5)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 45, height: 52)
                    .position(x: (UIScreen.main.bounds.width / 1.32), y: (UIScreen.main.bounds.height / 3.95))
                    
                    Button {
                        self.isBackNeck.toggle()
                        if isBackNeck {
                            score += 6.0
                            bodyArr.append("B - Neck")
                        } else {
                            score -= 6.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackNeck ? "SB - Neck" : "B - Neck")
                            .resizable()
                            .frame(width: 26.51, height: 5.95)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 26.51, height: 5.95)
                    .position(x: (UIScreen.main.bounds.width / 1.32), y: (UIScreen.main.bounds.height / 3.57))
                    
                    Button {
                        self.isBackShoulder.toggle()
                        if isBackShoulder {
                            score += 6.0
                            bodyArr.append("B - Shoulder")
                        } else {
                            score -= 6.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackShoulder ? "SB - Shoulder" : "B - Shoulder")
                            .resizable()
                            .frame(width: 56.64, height: 25.89)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 56.64, height: 25.89)
                    .position(x: (UIScreen.main.bounds.width / 1.32), y: (UIScreen.main.bounds.height / 3.33))

                    Button {
                        self.isBackUpperBack.toggle()
                        if isBackUpperBack {
                            score += 6.0
                            bodyArr.append("B - Upper Back")
                        } else {
                            score -= 6.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackUpperBack ? "SB - Upper Back" : "B - Upper Back")
                            .resizable()
                            .frame(width: 58, height: 36.4)
                            .aspectRatio(contentMode: .fill)
                    }
                    .frame(width: 58, height: 36.4)
                    .position(x: (UIScreen.main.bounds.width / 1.32), y: (UIScreen.main.bounds.height / 2.97))
                    
                    Button {
                        self.isBackLowerBack.toggle()
                        if isBackLowerBack {
                            score += 6.0
                            bodyArr.append("B - Lower Back")
                        } else {
                            score -= 6.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackLowerBack ? "SB - Lower Back" : "B - Lower Back")
                            .resizable()
                            .frame(width: 56.39, height: 50.87)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 56.39, height: 50.87)
                    .position(x: (UIScreen.main.bounds.width / 1.322), y: (UIScreen.main.bounds.height / 2.58))
                }
                
                // MARK: - Right Hand
                Group {
                    Button {
                        self.isBackRightShoulder.toggle()
                        if isBackRightShoulder {
                            score += 1.5
                            bodyArr.append("B - Right Shoulder")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackLeftShoulder ? "SB - Right Shoulder" : "B - Right Shoulder")
                            .resizable()
                            .frame(width: 21.13, height: 54.14)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 21.13, height: 54.14)
                    .position(x: (UIScreen.main.bounds.width / 1.165), y: (UIScreen.main.bounds.height / 3.07))
                    
                    Button {
                        self.isBackRightElbow.toggle()
                        if isBackRightElbow {
                            score += 1.5
                            bodyArr.append("B - Right Elbow")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackRightElbow ? "SB - Right Elbow" : "B - Right Elbow")
                            .resizable()
                            .frame(width: 16.17, height: 16.83)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 16.17, height: 16.83)
                    .position(x: (UIScreen.main.bounds.width / 1.15), y: (UIScreen.main.bounds.height / 2.74))

                    Button {
                        self.isBackRightArm.toggle()
                        if isBackRightArm {
                            score += 1.5
                            bodyArr.append("B - Right Arm")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackRightArm ? "SB - Right Arm" : "B - Right Arm")
                            .resizable()
                            .frame(width: 18.67, height: 38.54)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 18.67, height: 38.54)
                    .position(x: (UIScreen.main.bounds.width / 1.14), y: (UIScreen.main.bounds.height / 2.53))
                    
                    Button {
                        self.isBackRightFinger.toggle()
                        if isBackRightFinger {
                            score += 1.5
                            bodyArr.append("B - Right Finger")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackRightFinger ? "SB - Right Finger" : "B - Right Finger")
                            .resizable()
                            .frame(width: 13.42, height: 28.09)
                            .aspectRatio(contentMode: .fit)
                            
                    }
                    .frame(width: 13.42, height: 28.09)
                    .position(x: (UIScreen.main.bounds.width / 1.13), y: (UIScreen.main.bounds.height / 2.305))
                    
                }
                
                // MARK: - Left Hand
                Group {
                    Button {
                        self.isBackLeftShoulder.toggle()
                        if isBackLeftShoulder {
                            score += 1.5
                            bodyArr.append("B - Left Shoulder")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackLeftShoulder ? "SB - Left Shoulder" : "B - Left Shoulder")
                            .resizable()
                            .frame(width: 21.13, height: 54.14)
                            .aspectRatio(contentMode: .fit)
                            
                    }
                    .frame(width: 21.13, height: 54.14)
                    .position(x: (UIScreen.main.bounds.width / 1.52), y: (UIScreen.main.bounds.height / 3.07))

                    Button {
                        self.isBackLeftElbow.toggle()
                        if isBackLeftElbow {
                            score += 1.5
                            bodyArr.append("B - Left Elbow")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackLeftElbow ? "SB - Left Elbow" : "B - Left Elbow")
                            .resizable()
                            .frame(width: 16.17, height: 16.83)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 16.17, height: 16.83)
                    .position(x: (UIScreen.main.bounds.width / 1.54), y: (UIScreen.main.bounds.height / 2.74))
                    
                    Button {
                        self.isBackLeftArm.toggle()
                        if isBackLeftArm {
                            score += 1.5
                            bodyArr.append("B - Left Arm")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackLeftArm ? "SB - Left Arm" : "B - Left Arm")
                            .resizable()
                            .frame(width: 18.67, height: 38.54)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 18.67, height: 38.54)
                    .position(x: (UIScreen.main.bounds.width / 1.56), y: (UIScreen.main.bounds.height / 2.53))
                    
                    Button {
                        self.isBackLeftFinger.toggle()
                        if (isBackLeftFinger) {
                            score += 1.5
                            bodyArr.append("B - Left Finger")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackLeftFinger ? "SB - Left Finger" : "B - Left Finger")
                            .resizable()
                            .frame(width: 13.42, height: 28.09)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 13.42, height: 28.09)
                    .position(x: (UIScreen.main.bounds.width / 1.58), y: (UIScreen.main.bounds.height / 2.305))

                }
                
                //  MARK: - Left Knee
                Group {
                    Button {
                        self.isBackLeftBottom.toggle()
                        if isBackLeftBottom {
                            score += 3.0
                            bodyArr.append("B - Left Bottom")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackLeftBottom ? "SB - Left Bottom" : "B - Left Bottom")
                            .resizable()
                            .frame(width: 30.49, height: 45.62)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 29.36, height: 43.5)
                    .position(x: (UIScreen.main.bounds.width / 1.39), y: (UIScreen.main.bounds.height / 2.245))
                    
                    Button {
                        self.isBackLeftThigh.toggle()
                        if isBackLeftThigh {
                            score += 3.0
                            bodyArr.append("B - Left Thigh")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackLeftThigh ? "SB - Left Thigh" : "B - Left Thigh")
                            .resizable()
                            .frame(width: 26.44, height: 34.05)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 26.44, height: 34.05)
                    .position(x: (UIScreen.main.bounds.width / 1.385), y: (UIScreen.main.bounds.height / 2.025))
                    
                    Button {
                        self.isBackLeftKnee.toggle()
                        if isBackLeftKnee {
                            score += 3.0
                            bodyArr.append("B - Left Knee")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackLeftKnee ? "SB - Left Knee" : "B - Left Knee")
                            .resizable()
                            .frame(width: 16.72, height: 17.07)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 16.72, height: 17.07)
                    .position(x: (UIScreen.main.bounds.width / 1.389), y: (UIScreen.main.bounds.height / 1.932))
                    
                    Button {
                        self.isBackLeftLeg.toggle()
                        if isBackLeftLeg {
                            score += 3.0
                            bodyArr.append("B - Left Leg")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackLeftLeg ? "SB - Left Leg" : "B - Left Leg")
                            .resizable()
                            .frame(width: 22.56, height: 60.19)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 22.56, height: 60.19)
                    .position(x: (UIScreen.main.bounds.width / 1.388), y: (UIScreen.main.bounds.height / 1.8))
                    
                    Button {
                        self.isBackLeftFoot.toggle()
                        if isBackLeftFoot {
                            score += 3.0
                            bodyArr.append("B - Left Foot")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackLeftFoot ? "SB - Left Foot" : "B - Left Foot")
                            .resizable()
                            .frame(width: 22.75, height: 20.18)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 22.75, height: 20.18)
                    .position(x: (UIScreen.main.bounds.width / 1.38), y: (UIScreen.main.bounds.height / 1.656))

                }
                
                //  Right Knee
                Group {
                    Button {
                        self.isBackRightBottom.toggle()
                        if isBackRightBottom {
                            score += 3.0
                            bodyArr.append("B - Right Bottom")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackRightBottom ? "SB - Right Bottom" : "B - Right Bottom")
                            .resizable()
                            .frame(width: 30.02, height: 44.87)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 30.6, height: 43.48)
                    .position(x: (UIScreen.main.bounds.width / 1.25), y: (UIScreen.main.bounds.height / 2.245))
                    
                    Button {
                        self.isBackRightThigh.toggle()
                        if isBackRightThigh {
                            score += 3.0
                            bodyArr.append("B - Right Thigh")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackRightThigh ? "SB - Right Thigh" : "B - Right Thigh")
                            .resizable()
                            .frame(width: 26.44, height: 34.05)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 26.44, height: 34.05)
                    .position(x: (UIScreen.main.bounds.width / 1.25), y: (UIScreen.main.bounds.height / 2.025))
                    
                    Button {
                        self.isBackRightKnee.toggle()
                        if isBackRightKnee {
                            score += 3.0
                            bodyArr.append("B - Right Knee")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackRightKnee ? "SB - Right Knee" : "B - Right Knee")
                            .resizable()
                            .frame(width: 16.72, height: 17.07)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 16.72, height: 17.07)
                    .position(x: (UIScreen.main.bounds.width / 1.247), y: (UIScreen.main.bounds.height / 1.932))
                    
                    Button {
                        self.isBackRightLeg.toggle()
                        if isBackRightLeg {
                            score += 3.0
                            bodyArr.append("B - Right Leg")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackRightLeg ? "SB - Right Leg" : "B - Right Leg")
                            .resizable()
                            .frame(width: 22.56, height: 60.19)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 22.56, height: 60.19)
                    .position(x: (UIScreen.main.bounds.width / 1.248), y: (UIScreen.main.bounds.height / 1.8))
                    
                    Button {
                        self.isBackRightFoot.toggle()
                        if isBackRightFoot {
                            score += 3.0
                            bodyArr.append("B - Right Foot")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackRightFoot ? "SB - Right Foot" : "B - Right Foot")
                            .resizable()
                            .frame(width: 22.75, height: 20.18)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 22.75, height: 20.18)
                    .position(x: (UIScreen.main.bounds.width / 1.25), y: (UIScreen.main.bounds.height / 1.656))
                }
            }
        }
    }
}

 struct BackBodyView_Previews: PreviewProvider {
     static var previews: some View {
         BackBodyView(score: Binding.constant(0), bodyArr: Binding.constant([""]))
     }
 }
