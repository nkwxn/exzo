//
//  SkinConditionJournalView.swift
//  exzo
//
//  Created by Nicholas on 22/11/21.
//

import SwiftUI
import Combine

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
    let imageName: String
}

class SkinConditionJournalViewModel: ObservableObject {
    
}

struct SkinConditionJournalView: View {
    @Environment(\.dismiss) var dismiss
    
    var mode: JournalMode
    var journalQuestions = [
        JournalQuestions(name: "Redness", info: "", imageName: "redness_"),
        JournalQuestions(name: "Swelling", info: "", imageName: "Swelling"),
        JournalQuestions(name: "Scratch marks", info: "", imageName: "Scratch")
    ]
    
    @State var questionSect = 0
    @State var isBodyPart = true
    
    // Redness
    var rednessPart = [String]()
    var rednessValue = 2.0
    
    // Swelling
    var swellingPart = [String]()
    var swellingValue = 2.0
    
    // Scratch Mark
    var scratchPart = [String]()
    var scratchValue = 2.0
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 15) {
                CustomProgressView(percent: .constant(0.2))
                switch questionSect {
                case 0:
                    JournalQuestionView(conditionCategory: journalQuestions[0], isBodyPart: $isBodyPart)
                case 1:
                    JournalQuestionView(conditionCategory: journalQuestions[1], isBodyPart: $isBodyPart)
                case 2:
                    JournalQuestionView(conditionCategory: journalQuestions[2], isBodyPart: $isBodyPart)
                default:
                    Text("Should be going to the next journal")
                }
                Button("Next") {
                    if isBodyPart {
                        isBodyPart.toggle()
                    } else {
                        isBodyPart.toggle()
                        questionSect += 1
                    }
                }
                .disabled(false)
                .buttonStyle(ExzoButtonStyle(type: .primary))
            }
            .padding()
            .navigationTitle("Skin Condition")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        // To cancel (close modal) or go back to previous page
                        if questionSect == 0 && isBodyPart {
                            dismiss()
                        } else {
                            if questionSect > 0 && isBodyPart {
                                questionSect -= 1
                            } else {
                                isBodyPart.toggle()
                            }
                        }
                    } label: {
                        // tambahin if
                        if questionSect == 0 && isBodyPart {
                            Text("Cancel")
                        } else {
                            Image(systemName: "chevron.backward")
                            Text("Back")
                        }
                    }
                }
            }
            .onReceive(
                Publishers.CombineLatest3(
                    Just(rednessPart.isEmpty),
                    Just(swellingPart.isEmpty),
                    Just(scratchPart.isEmpty)
                )
            ) { output in
                
            }
        }
    }
}

struct JournalQuestionView: View {
    var conditionCategory: JournalQuestions
    @Binding var isBodyPart: Bool
    @State var bodyPart = [""]
    @State var sliderValue = 2.0
    var range = 0.0...3.0
    
    var body: some View {
        VStack(spacing: 14) {
            HStack {
                Text(conditionCategory.name)
                    .font(Lexend(.title2).getFont().bold())
                Button {
                    // show info
                } label: {
                    // label contains img
                    Image(systemName: "info.circle")
                }
                Spacer()
            }
            HStack {
                Text("Based on the chosen body part, how do you rate your inflamation now?")
                Spacer()
            }
            Spacer()
            if isBodyPart {
                BodyPartsView(score: .constant(0), bodyArr: $bodyPart)
                    .padding(.horizontal)
                    .position(x: (UIScreen.main.bounds.width / 2.5), y: (UIScreen.main.bounds.height / 5) * 0.1)
            } else {
                Image("\(conditionCategory.imageName)\(String(format: "%.0f", sliderValue))")
                    .resizable()
                    .frame(width: 220, height: 220)
                    .clipShape(Circle())
                
                Slider(value: $sliderValue, in: range, step: 1)
                Text(String(format: "%.0f", sliderValue))
                    .font(Lexend(.title3).getFont().bold())
                Text("Dull red color, borders are clearly defined")
            }
            Spacer()
        }
    }
}

struct SkinConditionJournaView_Previews: PreviewProvider {
    static var previews: some View {
        SkinConditionJournalView(mode: .onboarding)
    }
}
