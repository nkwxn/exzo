//
//  JournalChoiceQuestionView.swift
//  exzo
//
//  Created by Nicholas on 24/11/21.
//

import SwiftUI

struct JournalConcernView: View {
    @ObservedObject var viewModel: JournalInputViewModel
    
    let foodIntake = ["Gluten", "Seafood", "Poultry", "Egg", "Nut", "Dairy", "Grain"]
    let exposure = ["Pollen", "Dust", "Extreme temperature", "Indoor mold", "Pet fur", "Airborne pollution"]
    
    var arrOfContent: [JournalQuestions] {
        return [
            // Info buat onboarding, imageName buat input journal
            JournalQuestions(
                name: "Food Intake",
                info: "\(viewModel.category == .adult ? "Do you" : "Does your child") consume these food that are listed below today?",
                imageName: "What were foods that \(viewModel.category == .adult ? "you" : "your child") consume today?"
            ),
            JournalQuestions(name: "Exposure", info: "", imageName: "What kind of exposure that \(viewModel.category == .adult ? "you" : "your child") got exposed to today?")
        ]
    }
    
    @State var isNextPage = false
    
    @State var questionSect = 0
    @State var isDoneButtonDisabled = true
    @State var showNextPage = false
    
    @State var percentageDone: CGFloat = 0.2
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            CustomProgressView(percent: .constant(0.6))
            Text("Food Intake")
                .font(Lexend(.title2).getFont().bold())
            Text("Does your child consume these food that are listed below today?")
            if viewModel.journalMode == .onboarding {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(foodIntake, id: \.self) { item in
                        Text(item)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.white)
                            }
                    }
                }
                Spacer()
                HStack {
                    Button("Yes") {
                        
                    }
                    .buttonStyle(ExzoButtonStyle(type: .primary))
                    Button("No") {
                        
                    }
                    .buttonStyle(ExzoButtonStyle(type: .secondary))
                }
            } else {
                ScrollView {
//                    LazyVGrid(columns: <#T##[GridItem]#>, content: <#T##() -> _#>)
                }
            }
            NavigationLink("Must be active", isActive: $isNextPage) {
                Text("Halaman utama produk")
            }
            .hidden()
        }
        .padding()
        .background {
            Color(red: 240, green: 240, blue: 240)
                .ignoresSafeArea()
        }
        .navigationTitle("Concern")
    }
}

struct JournalChoiceQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        JournalConcernView(viewModel: JournalInputViewModel(.adult, mode: .create))
    }
}
