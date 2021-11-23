//
//  SkinConditionJournalView.swift
//  exzo
//
//  Created by Nicholas on 22/11/21.
//

import SwiftUI

enum JournalMode {
    case onboarding
    case create
    case update
}

struct JournalQuestions {
    let name: String
    let desc: String? = nil
    let desc1: String? = nil
    let info: String
}

var journalQuestions = [
    JournalQuestions(name: "Redness", info: ""),
    JournalQuestions(name: "Swelling", info: ""),
    JournalQuestions(name: "Scratch marks", info: "")
]

struct SkinConditionJournalView: View {
    var mode: JournalMode
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 15) {
                CustomProgressView(percent: .constant(0.2))
                JournalQuestionView()
                Spacer()
                Button("Next") {
                    // action to go next
                }
                .disabled(true)
                .buttonStyle(ExzoButtonStyle(type: .primary))
            }
            .padding()
            .navigationTitle("Skin Condition")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        // To cancel (close modal) or go back to previous page
                    } label: {
                        
                    }
                }
            }
        }
    }
}

struct JournalQuestionView: View {
    @State var value = 2.0
    var range = 0.0...3.0
    
    var body: some View {
        VStack {
            HStack {
                Text("Redness")
                    .font(Lexend(.title2).getFont().bold())
                Button {
                    // show info
                } label: {
                    // label contains img
                    Image(systemName: "info.circle")
                }
            }
            Text("Based on the chosen body part, how do you rate your inflamation now?")
            Image("redness_0")
            
            Slider(value: $value, in: range, step: 1)
        }
    }
}

struct SkinConditionJournaView_Previews: PreviewProvider {
    static var previews: some View {
        SkinConditionJournalView(mode: .onboarding)
    }
}
