//
//  IconRowView.swift
//  exzo
//
//  Created by Deven Nathanael on 09/11/21.
//

import SwiftUI
//struct DefaultIcon: View {
//    var body: some View {
//        ZStack {
//            if isToogle {
//                Circle()
//                    .strokeBorder(Color("accent_brandy"), lineWidth: 2.4)
//                    .background(Circle().fill(Color("accent_brandy")))
//                    .frame(width: 54, height: 54)
//                Image(systemName: "circle.righthalf.filled")
//                .font(.system(size: 24))
//                .foregroundColor(Color.white)
//            } else {
//                Circle()
//                    .strokeBorder(Color("accent_brandy"), lineWidth: 2.4)
//                    .background(Circle().fill(Color.white))
//                    .frame(width: 54, height: 54)
//                Image(systemName: "circle.righthalf.filled")
//                .font(.system(size: 24))
//                .foregroundColor(Color("accent_brandy"))
//            }
//        }
//    }
//}

struct IconRowView: View {
    @State private var toogleIcon1: Bool = false
    @State private var toogleIcon2: Bool = false
    @State private var toogleIcon3: Bool = false
    @State private var toogleIcon4: Bool = false
    @State private var toogleIcon5: Bool = false
    var body: some View {
        HStack {
            Toggle(isOn: $toogleIcon1) {
                
            }
                .toggleStyle(IconToggleStyle())
            Toggle(isOn: $toogleIcon2) {
                
            }
                .toggleStyle(IconToggleStyle())
            Toggle(isOn: $toogleIcon3) {
                
            }
                .toggleStyle(IconToggleStyle())
            Toggle(isOn: $toogleIcon4) {
                
            }
                .toggleStyle(IconToggleStyle())
            Toggle(isOn: $toogleIcon5) {
                
            }
                .toggleStyle(IconToggleStyle())
        }
//        HStack {
//            Group {
//                Spacer()
//                DefaultIcon(isToogle: false)
//            }
//            Group {
//                Spacer()
//                DefaultIcon(isToogle: false)
//            }
//            Group {
//                Spacer()
//                DefaultIcon(isToogle: false)
//            }
//            Group {
//                Spacer()
//                DefaultIcon(isToogle: false)
//            }
//            Group {
//                Spacer()
//                DefaultIcon(isToogle: false)
//            }
//            Spacer()
//        }
    }
}

struct IconToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        Button {
            configuration.isOn.toggle()
        } label: {
            ZStack {
                if configuration.isOn {
                    Circle()
                        .strokeBorder(Color("accent_brandy"), lineWidth: 2.4)
                        .background(Circle().fill(Color("accent_brandy")))
                        .frame(width: 54, height: 54)
                    Image(systemName: "circle.righthalf.filled")
                    .font(.system(size: 24))
                    .foregroundColor(Color.white)
                } else {
                    Circle()
                        .strokeBorder(Color("accent_brandy"), lineWidth: 2.4)
                        .background(Circle().fill(Color.white))
                        .frame(width: 54, height: 54)
                    Image(systemName: "circle.righthalf.filled")
                    .font(.system(size: 24))
                    .foregroundColor(Color("accent_brandy"))
                }
            }
        }
        
    }
}
struct IconRowView_Previews: PreviewProvider {
    static var previews: some View {
        IconRowView()
    }
}
