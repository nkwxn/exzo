//
//  ChildBackView.swift
//  exzo
//
//  Created by Difa N Pratama on 23/11/21.
//

import SwiftUI

// swiftlint:disable all
struct ChildBackView: View {
    //  Back Body
    @State var isChildBackHead: Bool = false
    @State var isChildBackLowerBack: Bool = false
    @State var isChildBackUpperBack: Bool = false
    @State var isChildBackShoulder: Bool = false
    @State var isChildBackNeck: Bool = false
    @State var isChildBackVital: Bool = false
    //  Back Arm
    @State var isChildBackRightShoulder: Bool = false
    @State var isChildBackRightElbow: Bool = false
    @State var isChildBackRightArm: Bool = false
    @State var isChildBackRightFinger: Bool = false
    @State var isChildBackLeftShoulder: Bool = false
    @State var isChildBackLeftElbow: Bool = false
    @State var isChildBackLeftArm: Bool = false
    @State var isChildBackLeftFinger: Bool = false
    //  Back Knee
    @State var isChildBackRightBottom: Bool = false
    @State var isChildBackRightThigh: Bool = false
    @State var isChildBackRightKnee: Bool = false
    @State var isChildBackRightLeg: Bool = false
    @State var isChildBackRightFoot: Bool = false
    @State var isChildBackLeftBottom: Bool = false
    @State var isChildBackLeftThigh: Bool = false
    @State var isChildBackLeftKnee: Bool = false
    @State var isChildBackLeftLeg: Bool = false
    @State var isChildBackLeftFoot: Bool = false
    
    @Binding var score: Float
    @Binding var bodyArr: [String]
    var body: some View {
        ZStack {
            // MARK: - Back Body
            Group {
                // MARK: - Body
                Group {
                    Button {
                        self.isChildBackHead.toggle()
                        if isChildBackHead {
                            score += 4.5
                            bodyArr.append("B - Head")
                        } else {
                            score -= 4.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isChildBackHead ? "SCB - Head" : "CB - Head")
                            .resizable()
                            .frame(width: 44.93, height: 54.81)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 44.93, height: 54.81)
                    .position(x: (UIScreen.main.bounds.width / 1.32), y: (UIScreen.main.bounds.height / 3.95))
                    
                    Button {
                        self.isChildBackNeck.toggle()
                        if isChildBackNeck {
                            score += 6.0
                            bodyArr.append("B - Neck")
                        } else {
                            score -= 6.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isChildBackNeck ? "SCB - Neck" : "CB - Neck")
                            .resizable()
                            .frame(width: 20.31, height: 6.26)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 20.31, height: 6.26)
                    .position(x: (UIScreen.main.bounds.width / 1.32), y: (UIScreen.main.bounds.height / 3.45))
                    
                    Button {
                        self.isChildBackShoulder.toggle()
                        if isChildBackShoulder {
                            score += 6.0
                            bodyArr.append("B - Shoulder")
                        } else {
                            score -= 6.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isChildBackShoulder ? "SCB - Shoulder" : "CB - Shoulder")
                            .resizable()
                            .frame(width: 52.22, height: 21.11)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 52.22, height: 21.11)
                    .position(x: (UIScreen.main.bounds.width / 1.32), y: (UIScreen.main.bounds.height / 3.26))

                    Button {
                        self.isChildBackUpperBack.toggle()
                        if isChildBackUpperBack {
                            score += 6.0
                            bodyArr.append("B - Upper Back")
                        } else {
                            score -= 6.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isChildBackUpperBack ? "SCB - Upper Back" : "CB - Upper Back")
                            .resizable()
                            .frame(width: 50.42, height: 29.5)
                            .aspectRatio(contentMode: .fill)
                    }
                    .frame(width: 50.42, height: 29.5)
                    .position(x: (UIScreen.main.bounds.width / 1.32), y: (UIScreen.main.bounds.height / 2.97))
                    
                    Button {
                        self.isChildBackLowerBack.toggle()
                        if isChildBackLowerBack {
                            score += 6.0
                            bodyArr.append("B - Lower Back")
                        } else {
                            score -= 6.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isChildBackLowerBack ? "SCB - Lower Back" : "CB - Lower Back")
                            .resizable()
                            .frame(width: 54.53, height: 35.11)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 54.53, height: 35.11)
                    .position(x: (UIScreen.main.bounds.width / 1.322), y: (UIScreen.main.bounds.height / 2.7))
                }
                
                // MARK: - Right Hand
                Group {
                    Button {
                        self.isChildBackRightShoulder.toggle()
                        if isChildBackRightShoulder {
                            score += 1.5
                            bodyArr.append("B - Right Shoulder")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isChildBackLeftShoulder ? "SCB - Right Shoulder" : "CB - Right Shoulder")
                            .resizable()
                            .frame(width: 16.13, height: 44.03)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 16.13, height: 44.03)
                    .position(x: (UIScreen.main.bounds.width / 1.182), y: (UIScreen.main.bounds.height / 3.05))
                    
                    Button {
                        self.isChildBackRightElbow.toggle()
                        if isChildBackRightElbow {
                            score += 1.5
                            bodyArr.append("B - Right Elbow")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isChildBackRightElbow ? "SCB - Right Elbow" : "CB - Right Elbow")
                            .resizable()
                            .frame(width: 12.7, height: 13.21)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 12.7, height: 13.21)
                    .position(x: (UIScreen.main.bounds.width / 1.167), y: (UIScreen.main.bounds.height / 2.79))

                    Button {
                        self.isChildBackRightArm.toggle()
                        if isChildBackRightArm {
                            score += 1.5
                            bodyArr.append("B - Right Arm")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isChildBackRightArm ? "SCB - Right Arm" : "CB - Right Arm")
                            .resizable()
                            .frame(width: 18.55, height: 29.46)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 18.55, height: 29.46)
                    .position(x: (UIScreen.main.bounds.width / 1.152), y: (UIScreen.main.bounds.height / 2.63))
                    
                    Button {
                        self.isChildBackRightFinger.toggle()
                        if isChildBackRightFinger {
                            score += 1.5
                            bodyArr.append("B - Right Finger")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isChildBackRightFinger ? "SCB - Right Finger" : "CB - Right Finger")
                            .resizable()
                            .frame(width: 20.88, height: 34.1)
                            .aspectRatio(contentMode: .fit)
                            
                    }
                    .frame(width: 20.88, height: 34.1)
                    .position(x: (UIScreen.main.bounds.width / 1.137), y: (UIScreen.main.bounds.height / 2.4))
                    
                }
                
                // MARK: - Left Hand
                Group {
                    Button {
                        self.isChildBackLeftShoulder.toggle()
                        if isChildBackLeftShoulder {
                            score += 1.5
                            bodyArr.append("B - Left Shoulder")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isChildBackLeftShoulder ? "SCB - Left Shoulder" : "CB - Left Shoulder")
                            .resizable()
                            .frame(width: 16.13, height: 44.03)
                            .aspectRatio(contentMode: .fit)
                            
                    }
                    .frame(width: 16.13, height: 44.03)
                    .position(x: (UIScreen.main.bounds.width / 1.49), y: (UIScreen.main.bounds.height / 3.05))

                    Button {
                        self.isChildBackLeftElbow.toggle()
                        if isChildBackLeftElbow {
                            score += 1.5
                            bodyArr.append("B - Left Elbow")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isChildBackLeftElbow ? "SCB - Left Elbow" : "CB - Left Elbow")
                            .resizable()
                            .frame(width: 12.7, height: 13.21)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 12.7, height: 13.21)
                    .position(x: (UIScreen.main.bounds.width / 1.52), y: (UIScreen.main.bounds.height / 2.79))
                    
                    Button {
                        self.isChildBackLeftArm.toggle()
                        if isChildBackLeftArm {
                            score += 1.5
                            bodyArr.append("B - Left Arm")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isChildBackLeftArm ? "SCB - Left Arm" : "CB - Left Arm")
                            .resizable()
                            .frame(width: 18.55, height: 29.46)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 18.55, height: 29.46)
                    .position(x: (UIScreen.main.bounds.width / 1.545), y: (UIScreen.main.bounds.height / 2.63))
                    
                    Button {
                        self.isChildBackLeftFinger.toggle()
                        if (isChildBackLeftFinger) {
                            score += 1.5
                            bodyArr.append("B - Left Finger")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isChildBackLeftFinger ? "SCB - Left Finger" : "CB - Left Finger")
                            .resizable()
                            .frame(width: 20.88, height: 34.1)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 20.88, height: 34.1)
                    .position(x: (UIScreen.main.bounds.width / 1.575), y: (UIScreen.main.bounds.height / 2.4))

                }
                
                //  MARK: - Left Knee
                Group {
                    Button {
                        self.isChildBackLeftBottom.toggle()
                        if isChildBackLeftBottom {
                            score += 3.0
                            bodyArr.append("B - Left Bottom")
                        } else {
                            score -= 3.0
                            bodyArr.removeAll { items in
                                items == "B - Left Bottom"
                            }
                        }
                    } label: {
                        Image(isChildBackLeftBottom ? "SCB - Left Bottom" : "CB - Left Bottom")
                            .resizable()
                            .frame(width: 27.34, height: 26.86)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 27.34, height: 26.86)
                    .position(x: (UIScreen.main.bounds.width / 1.39), y: (UIScreen.main.bounds.height / 2.47))
                    
                    Button {
                        self.isChildBackLeftThigh.toggle()
                        if isChildBackLeftThigh {
                            score += 3.0
                            bodyArr.append("B - Left Thigh")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isChildBackLeftThigh ? "SCB - Left Thigh" : "CB - Left Thigh")
                            .resizable()
                            .frame(width: 25.78, height: 37.61)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 25.78, height: 37.61)
                    .position(x: (UIScreen.main.bounds.width / 1.385), y: (UIScreen.main.bounds.height / 2.25))
                    
                    Button {
                        self.isChildBackLeftKnee.toggle()
                        if isChildBackLeftKnee {
                            score += 3.0
                            bodyArr.append("B - Left Knee")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isChildBackLeftKnee ? "SCB - Left Knee" : "CB - Left Knee")
                            .resizable()
                            .frame(width: 17.48, height: 17.85)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 17.48, height: 17.85)
                    .position(x: (UIScreen.main.bounds.width / 1.372), y: (UIScreen.main.bounds.height / 2.12))
                    
                    Button {
                        self.isChildBackLeftLeg.toggle()
                        if isChildBackLeftLeg {
                            score += 3.0
                            bodyArr.append("B - Left Leg")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isChildBackLeftLeg ? "SCB - Left Leg" : "CB - Left Leg")
                            .resizable()
                            .frame(width: 18.71, height: 42.46)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 18.71, height: 42.46)
                    .position(x: (UIScreen.main.bounds.width / 1.37), y: (UIScreen.main.bounds.height / 1.99))
                    
                    Button {
                        self.isChildBackLeftFoot.toggle()
                        if isChildBackLeftFoot {
                            score += 3.0
                            bodyArr.append("B - Left Foot")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isChildBackLeftFoot ? "SCB - Left Foot" : "CB - Left Foot")
                            .resizable()
                            .frame(width: 17.99, height: 14.86)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 17.99, height: 14.86)
                    .position(x: (UIScreen.main.bounds.width / 1.38), y: (UIScreen.main.bounds.height / 1.86))

                }
                
                //  Right Knee
                Group {
                    Button {
                        self.isChildBackRightBottom.toggle()
                        if isChildBackRightBottom {
                            score += 3.0
                            bodyArr.append("B - Right Bottom")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isChildBackRightBottom ? "SCB - Right Bottom" : "CB - Right Bottom")
                            .resizable()
                            .frame(width: 27.47, height: 26.14)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 27.47, height: 26.14)
                    .position(x: (UIScreen.main.bounds.width / 1.26), y: (UIScreen.main.bounds.height / 2.47))
                    
                    Button {
                        self.isChildBackRightThigh.toggle()
                        if isChildBackRightThigh {
                            score += 3.0
                            bodyArr.append("B - Right Thigh")
                        } else {
                            score -= 3.0
                            bodyArr.removeAll { partName in
                                partName == "B - Right Thigh"
                            }
                        }
                    } label: {
                        Image(isChildBackRightThigh ? "SCB - Right Thigh" : "CB - Right Thigh")
                            .resizable()
                            .frame(width: 25.78, height: 37.61)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 25.78, height: 37.61)
                    .position(x: (UIScreen.main.bounds.width / 1.26), y: (UIScreen.main.bounds.height / 2.25))
                    
                    Button {
                        self.isChildBackRightKnee.toggle()
                        if isChildBackRightKnee {
                            score += 3.0
                            bodyArr.append("B - Right Knee")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isChildBackRightKnee ? "SCB - Right Knee" : "CB - Right Knee")
                            .resizable()
                            .frame(width: 17.48, height: 17.85)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 17.48, height: 17.85)
                    .position(x: (UIScreen.main.bounds.width / 1.27), y: (UIScreen.main.bounds.height / 2.12))
                    
                    Button {
                        self.isChildBackRightLeg.toggle()
                        if isChildBackRightLeg {
                            score += 3.0
                            bodyArr.append("B - Right Leg")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isChildBackRightLeg ? "SCB - Right Leg" : "CB - Right Leg")
                            .resizable()
                            .frame(width: 18.71, height: 42.46)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 18.71, height: 42.46)
                    .position(x: (UIScreen.main.bounds.width / 1.27), y: (UIScreen.main.bounds.height / 1.99))
                    
                    Button {
                        self.isChildBackRightFoot.toggle()
                        if isChildBackRightFoot {
                            score += 3.0
                            bodyArr.append("B - Right Foot")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isChildBackRightFoot ? "SCB - Right Foot" : "CB - Right Foot")
                            .resizable()
                            .frame(width: 17.99, height: 14.86)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 17.99, height: 14.86)
                    .position(x: (UIScreen.main.bounds.width / 1.265), y: (UIScreen.main.bounds.height / 1.86))
                }
            }
        }
    }
}

struct ChildBackView_Previews: PreviewProvider {
    static var previews: some View {
        ChildBackView(score: Binding.constant(0), bodyArr: Binding.constant([""]))
    }
}
