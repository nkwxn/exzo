//
//  ChildBackView.swift
//  exzo
//
//  Created by Difa N Pratama on 23/11/21.
//

import SwiftUI

struct ChildBackView: View {
    // Back Body
    @State var isBackHead: Bool = false
    @State var isBackShoulder: Bool = false
    @State var isBackChest: Bool = false
    @State var isBackBottom: Bool = false
    @State var isBackBelly: Bool = false
    @State var isBackRightBottom: Bool = false
    @State var isBackLeftBottom: Bool = false
    // Back Arm
    @State var isBackRightBisep: Bool = false
    @State var isBackRightArm: Bool = false
    @State var isBackRightFinger: Bool = false
    @State var isBackRightShoulder: Bool = false
    @State var isBackLeftShoulder: Bool = false
    @State var isBackLeftBisep: Bool = false
    @State var isBackLeftArm: Bool = false
    @State var isBackLeftFinger: Bool = false
    // Back Knee
    @State var isBackRightKnee: Bool = false
    @State var isBackRightFoot: Bool = false
    @State var isBackLeftKnee: Bool = false
    @State var isBackLeftFoot: Bool = false
    
    @State var score: Float = 0
    @State var bodyArr: [String] = []
    var body: some View {
        ZStack {
            // Back Body
            Group {
                //MARK: - Body
                Group {
                    Button {
                        self.isBackHead.toggle()
                        print("Head Press")
                        if (isBackHead){
                            score += 4.5
                            bodyArr.append("BB - Head")
                        } else {
                            score -= 4.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackHead ? "SBB - Head" : "BB - Head")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45, height: 52)
                        
                    }.frame(width: 45, height: 52)
                        .position(x: (UIScreen.main.bounds.width / 1.32), y: (UIScreen.main.bounds.height / 3.95))
                }
                Button {
                    self.isBackShoulder.toggle()
                    if (isBackShoulder){
                        score += 6.0
                        bodyArr.append("BB - Shoulder")
                    } else {
                        score -= 6.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isBackShoulder ? "SBB - Shoulder" : "BB - Shoulder")
                        .resizable()
                        .frame(width: 72, height: 40)
                        .aspectRatio(contentMode: .fit)
                    
                }
                .frame(width: 72, height: 40)
                .position(x: (UIScreen.main.bounds.width / 1.32), y: (UIScreen.main.bounds.height / 3.25))
                
                Button {
                    self.isBackChest.toggle()
                    if (isBackChest){
                        score += 6.0
                        bodyArr.append("BB - Chest")
                    } else {
                        score -= 6.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isBackChest ? "SBB - Chest" : "BB - Chest")
                        .resizable()
                        .frame(width: 76, height: 42)
                        .aspectRatio(contentMode: .fit)
                    
                }.frame(width: 76, height: 42)
                    .position(x: (UIScreen.main.bounds.width / 1.32), y: (UIScreen.main.bounds.height / 2.80))
                
                Button {
                    self.isBackBelly.toggle()
                    if (isBackBelly){
                        score += 6.0
                        bodyArr.append("BB - Belly")
                    } else {
                        score -= 6.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isBackBelly ? "SBB - Belly" : "BB - Belly")
                        .resizable()
                        .frame(width: 72, height: 37)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 72, height: 37)
                .position(x: (UIScreen.main.bounds.width / 1.32), y: (UIScreen.main.bounds.height / 2.46))
                
                Button {
                    self.isBackRightBottom.toggle()
                    if (isBackRightBottom){
                        score += 3.0
                        bodyArr.append("BB - Right Bottom")
                    } else {
                        score -= 3.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isBackRightBottom ? "SBB - Right Bottom" : "BB - Right Bottom")
                        .resizable()
                        .frame(width: 40, height: 79)
                        .aspectRatio(contentMode: .fit)
                    
                }.frame(width: 40, height: 79)
                    .position(x: (UIScreen.main.bounds.width / 1.25), y: (UIScreen.main.bounds.height / 2.11))
                
                Button {
                    self.isBackLeftBottom.toggle()
                    if (isBackLeftBottom){
                        score += 3.0
                        bodyArr.append("BB - Left Bottom")
                    } else {
                        score -= 3.0
                        bodyArr.removeLast()
                    }
                } label: {
                    Image(isBackLeftBottom ? "SBB - Left Bottom" : "BB - Left Bottom")
                        .resizable()
                        .frame(width: 40, height: 79)
                        .aspectRatio(contentMode: .fit)
                    
                } .frame(width: 40, height: 79)
                    .position(x: (UIScreen.main.bounds.width / 1.42), y: (UIScreen.main.bounds.height / 2.11))
                //MARK: - Right Hand
                Group {
                    Button {
                        self.isBackRightShoulder.toggle()
                        if (isBackRightShoulder){
                            score += 1.5
                            bodyArr.append("BB - Right Shoulder")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackRightShoulder ? "SBB - Right Shoulder" : "BB - Right Shoulder")
                            .resizable()
                            .frame(width: 28, height: 42)
                            .aspectRatio(contentMode: .fit)
                        
                    }
                    .frame(width: 28, height: 42)
                    .position(x: (UIScreen.main.bounds.width / 1.13), y: (UIScreen.main.bounds.height / 3.08))
                    
                    Button {
                        self.isBackRightBisep.toggle()
                        if (isBackRightBisep){
                            score += 1.5
                            bodyArr.append("BB - Right Elbow")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackRightBisep ? "SBB - Right Elbow" :"BB - Right Elbow")
                            .resizable()
                            .frame(width: 31, height: 43)
                            .aspectRatio(contentMode: .fit)
                        
                    }
                    .frame(width: 31, height: 43)
                    .position(x: (UIScreen.main.bounds.width / 1.12), y: (UIScreen.main.bounds.height / 2.7))
                    
                    Button {
                        self.isBackRightArm.toggle()
                        if (isBackRightArm){
                            score += 1.5
                            bodyArr.append("BB - Right Arm")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackRightArm ? "SBB - Right Arm" : "BB - Right Arm")
                            .resizable()
                            .frame(width: 29, height: 53)
                            .aspectRatio(contentMode: .fit)
                        
                    }
                    .frame(width: 29, height: 53)
                    .position(x: (UIScreen.main.bounds.width / 1.094), y: (UIScreen.main.bounds.height / 2.38))
                    
                    Button {
                        self.isBackRightFinger.toggle()
                        if (isBackRightFinger){
                            score += 1.5
                            bodyArr.append("BB - Right Finger")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackRightFinger ? "SBB - Right Finger" : "BB - Right Finger")
                            .resizable()
                            .frame(width: 24, height: 39)
                            .aspectRatio(contentMode: .fit)
                        
                    }
                    .frame(width: 24, height: 39)
                    .position(x: (UIScreen.main.bounds.width / 1.084), y: (UIScreen.main.bounds.height / 2.11))
                    
                }
                
                // MARK: - Left Hand
                Group {
                    Button {
                        self.isBackLeftShoulder.toggle()
                        if (isBackLeftShoulder){
                            score += 1.5
                            bodyArr.append("BB - Left Shoulder")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackLeftShoulder ? "SBB - Left Shoulder" : "BB - Left Shoulder")
                            .resizable()
                            .frame(width: 28, height: 42)
                            .aspectRatio(contentMode: .fit)
                        
                    }
                    .frame(width: 28, height: 42)
                    .position(x: (UIScreen.main.bounds.width / 1.59), y: (UIScreen.main.bounds.height / 3.08))
                    
                    Button {
                        self.isBackLeftBisep.toggle()
                        if (isBackLeftBisep){
                            score += 1.5
                            bodyArr.append("BB - Left Elbow")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackLeftBisep ? "SBB - Left Elbow" : "BB - Left Elbow")
                            .resizable()
                            .frame(width: 31, height: 43)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 31, height: 43)
                    .position(x: (UIScreen.main.bounds.width / 1.62), y: (UIScreen.main.bounds.height / 2.7))
                    
                    Button {
                        self.isBackLeftArm.toggle()
                        if (isBackLeftArm){
                            score += 1.5
                            bodyArr.append("BB - Left Arm")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackLeftArm ? "SBB - Left Arm" : "BB - Left Arm")
                            .resizable()
                            .frame(width: 29, height: 53)
                            .aspectRatio(contentMode: .fit)
                            
                    }
                    .frame(width: 29, height: 53)
                    .position(x: (UIScreen.main.bounds.width / 1.67), y: (UIScreen.main.bounds.height / 2.38))

                    Button {
                        self.isBackLeftFinger.toggle()
                        if (isBackLeftFinger){
                            score += 1.5
                            bodyArr.append("BB - Left Finger")
                        } else {
                            score -= 1.5
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackLeftFinger ? "SBB - Left Finger" : "BB - Left Finger")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            
                    }
                    .frame(width: 24, height: 39)
                    .position(x: (UIScreen.main.bounds.width / 1.684), y: (UIScreen.main.bounds.height / 2.11))
                    
                }
                
                // MARK: - Right Knee
                Group {
                    Button {
                        self.isBackRightKnee.toggle()
                        if (isBackRightKnee){
                            score += 3.0
                            bodyArr.append("BB - Right Leg")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackRightKnee ? "SBB - Right Leg" : "BB - Right Leg")
                            .resizable()
                            .frame(width: 35, height: 69)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 35, height: 69)
                    .position(x: (UIScreen.main.bounds.width / 1.25), y: (UIScreen.main.bounds.height / 1.78))

                    Button {
                        self.isBackRightFoot.toggle()
                        if (isBackRightFoot){
                            score += 3.0
                            bodyArr.append("BB - Right Foot")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackRightFoot ? "SBB - Right Foot" : "BB - Right Foot")
                            .resizable()
                            .frame(width: 34, height: 65)
                            .aspectRatio(contentMode: .fit)
                            
                    }
                    .frame(width: 34, height: 65)
                    .position(x: (UIScreen.main.bounds.width / 1.25), y: (UIScreen.main.bounds.height / 1.555))
                    
                }
                
                //MARK: - Left Knee
                Group {
                    Button {
                        self.isBackLeftKnee.toggle()
                        if (isBackLeftKnee){
                            score += 3.0
                            bodyArr.append("BB - Left Knee")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackLeftKnee ? "SBB - Left Knee" : "BB - Left Knee")
                            .resizable()
                            .frame(width: 35, height: 69)
                            .aspectRatio(contentMode: .fit)
                            
                    }
                    .frame(width: 35, height: 69)
                    .position(x: (UIScreen.main.bounds.width / 1.42), y: (UIScreen.main.bounds.height / 1.78))
                    
                    Button {
                        self.isBackLeftFoot.toggle()
                        if (isBackLeftFoot){
                            score += 3.0
                            bodyArr.append("BB - Left Foot")
                        } else {
                            score -= 3.0
                            bodyArr.removeLast()
                        }
                    } label: {
                        Image(isBackLeftFoot ? "SBB - Left Foot" : "BB - Left Foot")
                            .resizable()
                            .frame(width: 34, height: 65)
                            .aspectRatio(contentMode: .fit)
                            
                    }
                    .frame(width: 34, height: 65)
                    .position(x: (UIScreen.main.bounds.width / 1.42), y: (UIScreen.main.bounds.height / 1.555))

                }
            }
        }
    }
}

struct ChildBackView_Previews: PreviewProvider {
    static var previews: some View {
        ChildBackView()
    }
}
