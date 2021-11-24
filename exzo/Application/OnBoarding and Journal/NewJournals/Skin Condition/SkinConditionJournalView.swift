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

//class SkinConditionJournalViewModel: ObservableObject {
//    var mode: JournalMode
//}

struct SkinConditionJournalView: View {
    @Environment(\.dismiss) var dismiss
    
    //    init() {
    //        viewModel.mode = .create
    //    }
    //
    //    init(entry: ) {}
    //
    //    @Binding var entryForInsight
    
    var mode: JournalMode
    var journalQuestions = [
        JournalQuestions(name: "Redness", info: "", imageName: "redness_"),
        JournalQuestions(name: "Swelling", info: "", imageName: "Swelling"),
        JournalQuestions(name: "Scratch marks", info: "", imageName: "Scratch"),
        JournalQuestions(name: "Food Intake", info: "Do your child consume these food that are listed below today?", imageName: "")
    ]
    
    @State var questionSect = 0
    @State var isBodyPart = true
    
    // Redness
    @State var rednessPart = [String]()
    @State var rednessValue = 2.0
    
    // Swelling
    @State var swellingPart = [String]()
    @State var swellingValue = 2.0
    
    // Scratch Mark
    @State var scratchPart = [String]()
    @State var scratchValue = 2.0
    
    @State var isDoneButtonDisabled = true
    @State var showNextPage = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 15) {
                CustomProgressView(percent: .constant(0.2))
                switch questionSect {
                case 0:
                    // Redness
                    JournalQuestionView(conditionCategory: journalQuestions[0], isBodyPart: $isBodyPart, bodyPart: $rednessPart, slider: $rednessValue)
                case 1:
                    // Swelling
                    JournalQuestionView(conditionCategory: journalQuestions[1], isBodyPart: $isBodyPart, bodyPart: $swellingPart, slider: $swellingValue)
                case 2:
                    // Scratch Mark
                    JournalQuestionView(conditionCategory: journalQuestions[2], isBodyPart: $isBodyPart, bodyPart: $scratchPart, slider: $scratchValue)
                default:
                    Text("Should be going to the next journal")
                }
                Button("Next") {
                    if isBodyPart {
                        isBodyPart.toggle()
                    } else if questionSect == 2 {
                        showNextPage.toggle()
                    } else {
                        isBodyPart.toggle()
                        questionSect += 1
                        isDoneButtonDisabled = true
                    }
                }
                .disabled(isDoneButtonDisabled)
                .buttonStyle(ExzoButtonStyle(type: .primary))
                .onChange(of: rednessPart) { newValue in
                    isDoneButtonDisabled = newValue.isEmpty
                }
                .onChange(of: scratchPart) { newValue in
                    isDoneButtonDisabled = newValue.isEmpty
                }
                .onChange(of: swellingPart) { newValue in
                    isDoneButtonDisabled = newValue.isEmpty
                }
                NavigationLink(isActive: $showNextPage) {
                    JournalChoiceQuestionView(inputMode: mode)
                } label: {
                    
                }
                .hidden()
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
        }
    }
}

struct JournalQuestionView: View {
    var conditionCategory: JournalQuestions
    @Binding var isBodyPart: Bool
    @Binding var bodyPart: [String]
    @Binding var slider: Double
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
                Image("\(conditionCategory.imageName)\(String(format: "%.0f", slider))")
                    .resizable()
                    .frame(width: 220, height: 220)
                    .clipShape(Circle())
                
                Slider(value: $slider, in: range, step: 1)
                Text(String(format: "%.0f", slider))
                    .font(Lexend(.title3).getFont().bold())
                Text("Dull red color, borders are clearly defined")
            }
            Spacer()
        }
    }
}

struct JournalStressLevelView: View {
    var body: some View {
        VStack {
            Text("")
        }
    }
}

struct SkinConditionJournaView_Previews: PreviewProvider {
    static var previews: some View {
        SkinConditionJournalView(mode: .onboarding)
    }
}
