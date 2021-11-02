//
//  PreOnboardingView.swift
//  Atemis
//
//  Created by Nicholas on 01/11/21.
//

import SwiftUI

struct PreOnboardingView: View {
    @ObservedObject var viewModel = PreOnboardingViewModel()
    
    var body: some View {
        NavigationView {
            // TODO: Convert ini ke custom button style, Buat style guide juga woi
            VStack {
                Image("login_image")
                    .clipShape(QuarterArc())
                VStack(alignment: .leading, spacing: 14) {
                    Text("Hello!")
                    Text("Welcome to Atemis, an app that helps you to track your triggers")
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("Sign up")
                    }
                    NavigationLink {
                        LoginView()
                    } label: {
                        Text("Login")
                    }
                    Button("Maybe later") {
                        print("Skip ke onboarding first page")
                    }
                }
                .padding()
                .background(in: RoundedRectangle(cornerRadius: 10))
                .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
                .padding()
                Spacer()
            }
            .ignoresSafeArea()
        }
    }
}

struct QuarterArc: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * 0.65))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.minY * 0.3),
                radius: rect.height * 0.87,
                startAngle: Angle(degrees: 50),
                endAngle: Angle(degrees: 130),
                clockwise: false
            )
            path.addLine(to: CGPoint(x: rect.minY, y: rect.maxY * 0.65))
        }
    }
}

struct PreOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        PreOnboardingView()
    }
}
