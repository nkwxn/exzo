//
//  UserProfileView.swift
//  exzo
//
//  Created by Nicholas on 22/11/21.
//

import SwiftUI

struct UserProfileView: View {
    var category: ProfileCategory
    @StateObject var viewModel = UserProfileViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                    Text("Set your\(category == .child ? " child's " : " ")profile")
                        .font(Lexend(.title2).getFont().bold())
                    Text(category.getProfileDesc())
                HStack {
                    Spacer()
                    ZStack(alignment: .bottomTrailing) {
                        Image(viewModel.selectedPic)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                        Button(action: viewModel.shuffleImage) {
                            Image(systemName: "arrow.2.circlepath")
                        }
                        .buttonStyle(ExzoButtonStyle(type: .smallIconPrimary))
                        .padding(.horizontal)
                    }
                    Spacer()
                }
                ExzoTextField("What's your\(category == .child ? " child's " : " ")name", input: $viewModel.profileName)
                if category == .child {
                    ExzoTextField("How old is your child?", input: .constant("9 years old"))
                }
                Spacer()
                NavigationLink("Done") {
                    OnBoardingView(category: self.category)
                }
                .simultaneousGesture(TapGesture().onEnded { xxx in
                    viewModel.saveData(category)
                })
                .buttonStyle(ExzoButtonStyle(type: .primary))
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Set Name")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(category: .adult)
        UserProfileView(category: .child)
    }
}
