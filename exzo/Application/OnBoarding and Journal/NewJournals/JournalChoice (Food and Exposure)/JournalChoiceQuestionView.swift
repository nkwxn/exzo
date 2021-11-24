//
//  JournalChoiceQuestionView.swift
//  exzo
//
//  Created by Nicholas on 24/11/21.
//

import SwiftUI

struct JournalChoiceQuestionView: View {
    var inputMode: JournalMode
    let foodIntake = ["Gluten", "Seafood", "Poultry", "Egg", "Nut", "Dairy", "Grain"]
    let exposure = ["Pollen", "Dust", "Extreme temperature", "Indoor mold", "Pet fur", "Airborne pollution"]
    
    @State var isNextPage = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            CustomProgressView(percent: .constant(0.6))
            Text("Food Intake")
                .font(Lexend(.title2).getFont().bold())
            Text("Do you consume these food that are listed below today?")
            ForEach(foodIntake, id: \.self) { item in
                Text(item)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                    }
                    .shadow(radius: 3)
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
//            NavigationLink(isActive: $isNextPage, "Must be hidden here") {
//
//            }
//            .hidden()
        }
        .padding()
    }
}

struct JournalChoiceQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        JournalChoiceQuestionView(inputMode: .onboarding)
    }
}
