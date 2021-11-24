//
//  OnBoardingView.swift
//  exzo
//
//  Created by Difa N Pratama on 03/11/21.
//

import SwiftUI

struct OnBoardingView: View {
    @ObservedObject var viewModel: JournalInputViewModel
    
    init(category: ProfileCategory) {
        viewModel = JournalInputViewModel(category, mode: .onboarding)
    }
    
    // Show Modal or not tho
    @State var showInputModal = false
    @State var showInfoModal = false
    
    @State var nextPage = false
    
    var body: some View {
        VStack {
            Image("onBoarding")
                .edgesIgnoringSafeArea(.top)
            Text("We want to know more about \(viewModel.category == .child ? "your child" : "you")!")
                .fontWeight(.bold)
                .padding()
                .font(.custom("Avenir", size: 34))
                .multilineTextAlignment(.center)
            
            // swiftlint:disable line_length
            Text("Please answer 3 questions about your\(viewModel.category == .child ? " child's " : " ")current skin conditions and several questions about your concern to understand you\(viewModel.category == .child ? "r kid " : " ")and get personalization better.")
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
                SkinConditionJournalView(jourVM: viewModel)
            }
            .buttonStyle(ExzoButtonStyle(type: .primary))
            .padding()
            Button("Find out more about the test") {
                self.showInfoModal.toggle()
            }
            NavigationLink("Should be hidden", isActive: $nextPage) {
                Text("Halaman insight dr onboarding")
            }
            .hidden()
        }
        .navigationBarHidden(true)
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView(category: .adult)
        OnBoardingView(category: .child)
    }
}
