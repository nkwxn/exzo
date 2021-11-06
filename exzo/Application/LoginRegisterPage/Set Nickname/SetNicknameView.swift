//
//  SetNicknameView.swift
//  Atemis
//
//  Created by Nicholas on 01/11/21.
//

import SwiftUI

struct SetNicknameView: View {
    @StateObject var viewModel = SetNicknameViewModel()
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                // FIXME: Ganti image sesuai dengan profile picture yang dibuatkan tim design
                Image(viewModel.selectedPic)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                Button(action: viewModel.shuffleImage) {
                    Image(systemName: "arrow.2.squarepath")
                }
                .buttonStyle(ExzoButtonStyle(type: .smallIconPrimary))
                .padding(.horizontal)
            }
            ExzoTextField("What's your name", input: $viewModel.myNickName, alignment: .center)
            Button("Continue", action: viewModel.doneButtonPressed)
                .buttonStyle(ExzoButtonStyle(type: .primary))
        }
        .padding()
        .navigationTitle("Your Profile")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: viewModel.viewOnAppear)
        .fullScreenCover(isPresented: $viewModel.showOnboarding) {
            OnBoardingView()
        }
    }
}

struct SetNicknameView_Previews: PreviewProvider {
    static var previews: some View {
        SetNicknameView()
    }
}
