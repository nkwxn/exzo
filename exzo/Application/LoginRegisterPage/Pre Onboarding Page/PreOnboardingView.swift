//
//  PreOnboardingView.swift
//  Atemis
//
//  Created by Nicholas on 01/11/21.
//

import SwiftUI

struct PreOnboardingView: View {
    @StateObject var viewModel = PreOnboardingViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Image("login_image")
                    .clipShape(QuarterArc())
                    .offset(x: 0, y: -30)
                VStack(alignment: .leading, spacing: 14) {
                    Text("Hello!")
                        .font(.title)
                    Text("Welcome to Atemis, an app that helps you to track your triggers")
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("Sign up")
                    }
                    .buttonStyle(ExzoButtonStyle(type: .primary))
                    NavigationLink {
                        LoginView()
                    } label: {
                        Text("Login")
                    }
                    .buttonStyle(ExzoButtonStyle(type: .secondary))
                    ZStack {
                        Color.clear
                            .frame(width: nil, height: 30)
                        Button("Maybe later", action: viewModel.maybeLaterPressed)
                        .foregroundColor(.primary)
                    }
                }
                .padding()
                .background(
                    in: RoundedRectangle(cornerRadius: 10)
                )
                .shadow(color: .clear, radius: 50, x: 0, y: 0)
                .padding()
                .offset(x: 0, y: -60)
                .shadow(color: .gray, radius: 5, x: 0, y: 0)
                Spacer()
            }
            .ignoresSafeArea(edges: .top)
        }
    }
}

struct PreOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        PreOnboardingView()
            .preferredColorScheme(.light)
        PreOnboardingView()
            .preferredColorScheme(.dark)
    }
}
