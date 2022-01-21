//
//  PopUpWindow.swift
//  exzo
//
//  Created by Difa N Pratama on 21/01/22.
//

import SwiftUI

struct PopUpWindow: View {
    @Environment(\.openURL) var openURL
    @State private var dataMail = ComposeMailData(subject: "Exzo Feedback", recipients: ["exzocompanion@gmail.com"], message: "Hi, I wanted to tell you that...")
    //    var insta: String
    //    var email: String
    //    var buttonText: String
    @State var showMail: Bool = false
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            if show {
                // PopUp background color
                Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)
                
                // PopUp Window
                VStack(alignment: .center, spacing: 0) {
                    HStack {
                        Spacer()
                        Button(action: {
                            // Dismiss the PopUp
                            withAnimation(.linear(duration: 0.3)) {
                                show = false
                            }
                        }, label: {
                            Image(systemName: "xmark")
                                .frame(height: 12, alignment: .center)
                        })
                            .buttonStyle(PlainButtonStyle())
                            .padding(.top, 15)
                            .padding(.trailing, 15)
                            .edgesIgnoringSafeArea(.all)
                            
                    }
                    
                    Text("Contact Us")
                        .frame(maxWidth: .infinity)
                        .frame(height: 45, alignment: .center)
                        .font(Font.system(size: 23, weight: .semibold))
                    
                    Divider()
                    
                    Button {
                        openURL(URL(string: "https://www.instagram.com/exzo.companion/")!)
                    } label: {
                        Text("Instagram")
                            .multilineTextAlignment(.center)
                            .font(Font.system(size: 16, weight: .semibold))
                            .padding(EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25))
                    }
                    
                    Divider()
                    Button {
                        self.showMail.toggle()
                    } label: {
                        Text("Send Feedback")
                            .multilineTextAlignment(.center)
                            .font(Font.system(size: 16, weight: .semibold))
                            .padding(EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25))
                    }
                    
                }
                .frame(maxWidth: 300)
                .border(Color.white, width: 2)
                .background(Color.white)
                .cornerRadius(20)
                .sheet(isPresented: $showMail) {
                    MailView(data: $dataMail) { result in
                        print(result)
                    }
                }
            }
        }
    }
}
// struct PopUpWindow_Previews: PreviewProvider {
//    static var previews: some View {
//        PopUpWindow()
//    }
// }
