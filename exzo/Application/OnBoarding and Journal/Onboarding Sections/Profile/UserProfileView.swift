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
    
    // For update from Settings
    let forUpdate: Bool
    @Environment(\.presentationMode) var presentationMode
    
    init(category: ProfileCategory) {
        viewModel = UserProfileViewModel(category)
        self.forUpdate = false
    }
    
    init(category: ProfileCategory, update: Bool) {
        viewModel = UserProfileViewModel(category)
        self.forUpdate = update
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Text("Atur profil\(viewModel.category == .child ? " anak " : " ")Anda")
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
                    ExzoTextField("Siapa nama \(viewModel.category == .child ? "anak Anda" : "Anda")?", input: $viewModel.myNickName)
                    ExzoTextField("Berapa umur \(viewModel.category == .child ? "anak Anda" : "Anda")? (Tahun)", input: $viewModel.ageInt, style: .numberTextField)
                }
                .padding()
            }
            Spacer(minLength: 0)
            Button(forUpdate ? "Simpan" : "Lanjut") {
                viewModel.saveData()
                if forUpdate {
                    presentationMode.wrappedValue.dismiss()
                } else {
                    pushToNextPage.toggle()
                }
            }
            .buttonStyle(ExzoButtonStyle(type: .primary))
            .padding(.horizontal)
            .padding(.bottom)
            NavigationLink("Lanjut", isActive: $pushToNextPage) {
                OnBoardingView(category: self.viewModel.category)
            }
            .hidden()
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
