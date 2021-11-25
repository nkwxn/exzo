//
//  UserProfileView.swift
//  exzo
//
//  Created by Nicholas on 22/11/21.
//

import SwiftUI

struct UserProfileView: View {
    @ObservedObject var viewModel: UserProfileViewModel
    
    init(category: ProfileCategory) {
        viewModel = UserProfileViewModel(category)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Atur profil \(viewModel.category == .child ? "anak " : " ")Anda")
                        .font(Lexend(.title2).getFont().bold())
                Text(viewModel.category.getProfileDesc())
                HStack {
                    Spacer()
                    ZStack(alignment: .bottomTrailing) {
                        Image("L0 - \(viewModel.selectedPic)")
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
                ExzoTextField("Siapa nama \(viewModel.category == .child ? "anak Anda" : "Anda")?", input: $viewModel.profileName)
                ExzoTextField("Berapa umur \(viewModel.category == .child ? "anak Anda" : "Anda")?", input: .constant("9 tahun"))
                Spacer()
                NavigationLink("Lanjut") {
                    OnBoardingView(category: self.viewModel.category)
                }
                .simultaneousGesture(TapGesture().onEnded { xxx in
                    viewModel.saveData(viewModel.category)
                })
                .buttonStyle(ExzoButtonStyle(type: .primary))
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Atur Profil")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(category: .adult)
        UserProfileView(category: .child)
    }
}
