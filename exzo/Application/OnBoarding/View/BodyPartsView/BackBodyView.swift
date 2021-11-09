//
//  FrontBodyView.swift
//  exzo
//
//  Created by Difa N Pratama on 09/11/21.
//

import SwiftUI

struct BackBodyView: View {
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
    
    var body: some View {
        ZStack {
            // Back Body
            Group {
                // Body
                Group {
                    Button {
                        self.isBackHead.toggle()
                        print("Head Press")
                    } label: {
                        Image(isBackHead ? "SB - Head" : "B - Head")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45, height: 52)
                        
                    }.frame(width: 45, height: 52)
                        .position(x: (UIScreen.main.bounds.width / 1.32), y: (UIScreen.main.bounds.height / 3.95))
                }
                Button {
                    self.isBackShoulder.toggle()
                } label: {
                    Image(isBackShoulder ? "SB - Shoulder" : "B - Shoulder")
                        .resizable()
                        .frame(width: 72, height: 40)
                        .aspectRatio(contentMode: .fit)
                    
                }
                .frame(width: 72, height: 40)
                .position(x: (UIScreen.main.bounds.width / 1.32), y: (UIScreen.main.bounds.height / 3.25))
                
                Button {
                    self.isBackChest.toggle()
                } label: {
                    Image(isBackChest ? "SB - Chest" : "B - Chest")
                        .resizable()
                        .frame(width: 76, height: 42)
                        .aspectRatio(contentMode: .fit)
                    
                }.frame(width: 76, height: 42)
                    .position(x: (UIScreen.main.bounds.width / 1.32), y: (UIScreen.main.bounds.height / 2.80))
                
                Button {
                    self.isBackBelly.toggle()
                } label: {
                    Image(isBackBelly ? "SB - Belly" : "B - Belly")
                        .resizable()
                        .frame(width: 72, height: 37)
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 72, height: 37)
                .position(x: (UIScreen.main.bounds.width / 1.32), y: (UIScreen.main.bounds.height / 2.46))
                
                Button {
                    self.isBackRightBottom.toggle()
                } label: {
                    Image(isBackRightBottom ? "SB - Right Bottom" : "B - Right Bottom")
                        .resizable()
                        .frame(width: 40, height: 79)
                        .aspectRatio(contentMode: .fit)
                    
                }.frame(width: 40, height: 79)
                    .position(x: (UIScreen.main.bounds.width / 1.25), y: (UIScreen.main.bounds.height / 2.11))
                
                Button {
                    self.isBackLeftBottom.toggle()
                } label: {
                    Image(isBackLeftBottom ? "SB - Left Bottom" : "B - Left Bottom")
                        .resizable()
                        .frame(width: 40, height: 79)
                        .aspectRatio(contentMode: .fit)
                    
                } .frame(width: 40, height: 79)
                    .position(x: (UIScreen.main.bounds.width / 1.42), y: (UIScreen.main.bounds.height / 2.11))
                // Right Hand
                Group {
                    Button {
                        self.isBackRightShoulder.toggle()
                    } label: {
                        Image(isBackRightShoulder ? "SB - Right Shoulder" : "B - Right Shoulder")
                            .resizable()
                            .frame(width: 28, height: 42)
                            .aspectRatio(contentMode: .fit)
                        
                    }
                    .frame(width: 28, height: 42)
                    .position(x: (UIScreen.main.bounds.width / 1.13), y: (UIScreen.main.bounds.height / 3.08))
                    
                    Button {
                        self.isBackRightBisep.toggle()
                    } label: {
                        Image(isBackRightBisep ? "SB - Right Bisep" :"B - Right Bisep")
                            .resizable()
                            .frame(width: 31, height: 43)
                            .aspectRatio(contentMode: .fit)
                        
                    }
                    .frame(width: 31, height: 43)
                    .position(x: (UIScreen.main.bounds.width / 1.12), y: (UIScreen.main.bounds.height / 2.7))
                    
                    Button {
                        self.isBackRightArm.toggle()
                    } label: {
                        Image(isBackRightArm ? "SB - Right Arm" : "B - Right Arm")
                            .resizable()
                            .frame(width: 29, height: 53)
                            .aspectRatio(contentMode: .fit)
                        
                    }
                    .frame(width: 29, height: 53)
                    .position(x: (UIScreen.main.bounds.width / 1.094), y: (UIScreen.main.bounds.height / 2.38))
                    
                    Button {
                        self.isBackRightFinger.toggle()
                    } label: {
                        Image(isBackRightFinger ? "SB - Right Finger" : "B - Right Finger")
                            .resizable()
                            .frame(width: 24, height: 39)
                            .aspectRatio(contentMode: .fit)
                        
                    }
                    .frame(width: 24, height: 39)
                    .position(x: (UIScreen.main.bounds.width / 1.084), y: (UIScreen.main.bounds.height / 2.11))
                    
                }
                
                // Left Hand
                Group {
                    Button {
                        self.isBackLeftShoulder.toggle()
                    } label: {
                        Image(isBackLeftShoulder ? "SB - Left Shoulder" : "B - Left Shoulder")
                            .resizable()
                            .frame(width: 28, height: 42)
                            .aspectRatio(contentMode: .fit)
                        
                    }
                    .frame(width: 28, height: 42)
                    .position(x: (UIScreen.main.bounds.width / 1.59), y: (UIScreen.main.bounds.height / 3.08))
                    
                    Button {
                        self.isBackLeftBisep.toggle()
                    } label: {
                        Image(isBackLeftBisep ? "SB - Left Bisep" : "B - Left Bisep")
                            .resizable()
                            .frame(width: 31, height: 43)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 31, height: 43)
                    .position(x: (UIScreen.main.bounds.width / 1.62), y: (UIScreen.main.bounds.height / 2.7))
                    
                    Button {
                        self.isBackLeftArm.toggle()
                    } label: {
                        Image(isBackLeftArm ? "SB - Left Arm" : "B - Left Arm")
                            .resizable()
                            .frame(width: 29, height: 53)
                            .aspectRatio(contentMode: .fit)
                            
                    }
                    .frame(width: 29, height: 53)
                    .position(x: (UIScreen.main.bounds.width / 1.67), y: (UIScreen.main.bounds.height / 2.38))

                    Button {
                        self.isBackLeftFinger.toggle()
                    } label: {
                        Image(isBackLeftFinger ? "SB - Left Finger" : "B - Left Finger")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            
                    }
                    .frame(width: 24, height: 39)
                    .position(x: (UIScreen.main.bounds.width / 1.684), y: (UIScreen.main.bounds.height / 2.11))
                    
                }
                
                // Right Knee
                Group {
                    Button {
                        self.isBackRightKnee.toggle()
                    } label: {
                        Image(isBackRightKnee ? "SB - Right Knee" : "B - Right Knee")
                            .resizable()
                            .frame(width: 35, height: 69)
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 35, height: 69)
                    .position(x: (UIScreen.main.bounds.width / 1.25), y: (UIScreen.main.bounds.height / 1.78))

                    Button {
                        self.isBackRightFoot.toggle()
                    } label: {
                        Image(isBackRightFoot ? "SB - Right Foot" : "B - Right Foot")
                            .resizable()
                            .frame(width: 34, height: 65)
                            .aspectRatio(contentMode: .fit)
                            
                    }
                    .frame(width: 34, height: 65)
                    .position(x: (UIScreen.main.bounds.width / 1.25), y: (UIScreen.main.bounds.height / 1.555))
                    
                }
                
                // Left Knee
                Group {
                    Button {
                        self.isBackLeftKnee.toggle()
                    } label: {
                        Image(isBackLeftKnee ? "SB - Left Knee" : "B - Left Knee")
                            .resizable()
                            .frame(width: 35, height: 69)
                            .aspectRatio(contentMode: .fit)
                            
                    }
                    .frame(width: 35, height: 69)
                    .position(x: (UIScreen.main.bounds.width / 1.42), y: (UIScreen.main.bounds.height / 1.78))
                    
                    Button {
                        self.isBackLeftFoot.toggle()
                    } label: {
                        Image(isBackLeftFoot ? "SB - Left Foot" : "B - Left Foot")
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

struct BackBodyView_Previews: PreviewProvider {
    static var previews: some View {
        BackBodyView()
    }
}
