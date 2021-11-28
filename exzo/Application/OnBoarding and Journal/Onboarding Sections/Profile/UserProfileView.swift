//
//  UserProfileView.swift
//  exzo
//
//  Created by Nicholas on 22/11/21.
//

import SwiftUI

struct UserProfileView: View {
    @ObservedObject var viewModel: UserProfileViewModel
    @State var pushToNextPage = false
    
    init(category: ProfileCategory) {
        viewModel = UserProfileViewModel(category)
    }
    
    var body: some View {
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
            ExzoTextField("Berapa umur \(viewModel.category == .child ? "anak Anda" : "Anda")? (Tahun)", input: $viewModel.ageInt, style: .numberTextField)
            Spacer()
            Button("Lanjut") {
                viewModel.saveData()
                pushToNextPage.toggle()
            }
            .buttonStyle(ExzoButtonStyle(type: .primary))
            NavigationLink("Lanjut", isActive: $pushToNextPage) {
                OnBoardingView(category: self.viewModel.category)
            }
            .hidden()
        }
        .padding()
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
