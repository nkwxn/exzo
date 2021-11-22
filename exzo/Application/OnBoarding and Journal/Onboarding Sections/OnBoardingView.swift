//
//  OnBoardingView.swift
//  exzo
//
//  Created by Difa N Pratama on 03/11/21.
//

import SwiftUI

struct OnBoardingView: View {
    var category: ProfileCategory
    @State var showInputModal = false
    @State var showInfoModal = false
    
    var body: some View {
        VStack {
            Image("onBoarding")
                .edgesIgnoringSafeArea(.top)
            Text("We want to know more about \(category == .child ? "your child" : "you")!")
                .fontWeight(.bold)
                .padding()
                .font(.custom("Avenir", size: 34))
                .multilineTextAlignment(.center)
            
            Text("Please answer 3 questions about your child’s current skin conditions and several questions about your concern to understand your kid and get personalization better.")
                .padding()
                .multilineTextAlignment(.center)
            Spacer()
            Button("Start") {
                self.showInputModal.toggle()
            }
            .sheet(isPresented: $showInputModal) {
                // On Dismiss when value is appended
            } content: {
                // Go to the page
                SkinConditionJournalView(mode: .onboarding)
            }
            .buttonStyle(ExzoButtonStyle(type: .primary))
            .padding()
            Button("Find out more about the test") {
                self.showInfoModal.toggle()
            }
            Spacer()
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView(category: .adult)
        OnBoardingView(category: .child)
    }
}
