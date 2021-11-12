//
//  FrontBodyView.swift
//  exzo
//
//  Created by Difa N Pratama on 09/11/21.
//

import SwiftUI

struct FrontBodyView: View {
    // Front Body
    @State var isFrontHead: Bool = false
    @State var isFrontShoulder: Bool = false
    @State var isFrontChest: Bool = false
    @State var isFrontRightThigh: Bool = false
    @State var isFrontLeftThigh: Bool = false
    @State var isFrontBelly: Bool = false
    @State var isFrontX: Bool = false
    // Front Arm
    @State var isFrontRightShoulder: Bool = false
    @State var isFrontRightBisep: Bool = false
    @State var isFrontRightArm: Bool = false
    @State var isFrontRightFinger: Bool = false
    @State var isFrontLeftShoulder: Bool = false
    @State var isFrontLeftBisep: Bool = false
    @State var isFrontLeftArm: Bool = false
    @State var isFrontLeftFinger: Bool = false
    // Front Knee
    @State var isFrontRightKnee: Bool = false
    @State var isFrontRightFoot: Bool = false
    @State var isFrontLeftKnee: Bool = false
    @State var isFrontLeftFoot: Bool = false
    
    var body: some View {
        ZStack {
            //Front Body
            Group {
                // Body
                Group {
                    Button {
                        self.isFrontHead.toggle()
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
                    } label: {
                        Circle()
                            .fill(isFrontX ? Color.copper : .gray)
                            .frame(width: 20, height: 20)
                    }
                    .frame(width: 20, height: 20)
                    .position(x: (UIScreen.main.bounds.width / 4.25), y: (UIScreen.main.bounds.height / 2.22))

                }
                
                // Right Hand
                Group {
                    Button {
                        self.isFrontRightShoulder.toggle()
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
                    } label: {
                        Image(isFrontRightFinger ? "SF - Right Finger" : "B - Right Finger")
                            .resizable()
                            .frame(width: 24, height: 39)
                            .aspectRatio(contentMode: .fit)
                            
                    }
                    .frame(width: 24, height: 39)
                    .position(x: (UIScreen.main.bounds.width / 2.5), y: (UIScreen.main.bounds.height / 2.11))
                    
                }
                
                // Left Hand
                Group {
                    Button {
                        self.isFrontLeftShoulder.toggle()
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
                    } label: {
                        Image(isFrontLeftFinger ? "SF - Left Finger" : "B - Left Finger")
                            .resizable()
                            .frame(width: 24, height: 39)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 24, height: 39)
                    .position(x: (UIScreen.main.bounds.width / 13.684), y: (UIScreen.main.bounds.height / 2.11))

                }
                
                // Right Knee
                Group {
                    Button {
                        self.isFrontRightKnee.toggle()
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
                    } label: {
                        Image(isFrontRightFoot ? "SF - Right Foot" : "B - Right Foot")
                            .resizable()
                            .frame(width: 34, height: 65)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 34, height: 65)
                    .position(x: (UIScreen.main.bounds.width / 3.55), y: (UIScreen.main.bounds.height / 1.555))

                }
                
                // Left Knee
                Group {
                    Button {
                        self.isFrontLeftKnee.toggle()
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

struct FrontBodyView_Previews: PreviewProvider {
    static var previews: some View {
        FrontBodyView()
    }
}