//
//  OnBoardingView.swift
//  exzo
//
//  Created by Difa N Pratama on 03/11/21.
//

import SwiftUI

struct OnBoardingView: View {
    @State var isOnboard: Bool = false
    var body: some View {
        NavigationView{
            VStack {
                Image("onBoarding")
                    .edgesIgnoringSafeArea(.top)
                Text("We want to know more about you!")
                    .fontWeight(.bold)
                    .padding()
                    .font(.custom("Avenir", size: 34))
                    .multilineTextAlignment(.center)
                
                Text("Before we jump into Atemis, You have to fill **9 questions** about **severity of dry skin**, how intense your **current symptoms**, and problems caused by eczema in order for us to help you.")
                    .padding()
                    .multilineTextAlignment(.center)
                Spacer()
                NavigationLink(destination: PageControlView()) {
                    Text("Start")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.horizontal, (UIScreen.main.bounds.width / 3))
                        .padding()
                        .background(Color.brandy)
                        .cornerRadius(10)
                }
                Spacer()
            }
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
