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

struct SkinConditionJournalView: View {
    @Environment(\.dismiss) var dismiss
    
    init() {
        self.viewModel = JournalInputViewModel(.adult, mode: .create)
    }
    
    init(jourVM: JournalInputViewModel) {
        self.viewModel = jourVM
    }
    
    @ObservedObject var viewModel: JournalInputViewModel
    
    var journalQuestions = [
        JournalQuestions(name: "Peradangan", info: "", imageName: "redness_"),
        JournalQuestions(name: "Pembengkakan", info: "", imageName: "Swelling"),
        JournalQuestions(name: "Bekas ga", info: "", imageName: "Scratch")
    ]
    
    @State var questionSect = 0
    @State var isBodyPart = true
    
    @State var isDoneButtonDisabled = true
    @State var showTrackRoutine = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 15) {
                CustomProgressView(percent: $viewModel.percentageDone)
                switch questionSect {
                case 0:
                    // Redness
                    JournalQuestionView(conditionCategory: journalQuestions[0], isBodyPart: $isBodyPart, bodyPart: $viewModel.rednessPart, slider: $viewModel.rednessValue)
                case 1:
                    // Swelling
                    JournalQuestionView(conditionCategory: journalQuestions[1], isBodyPart: $isBodyPart, bodyPart: $viewModel.swellingPart, slider: $viewModel.swellingValue)
                case 2:
                    // Scratch Mark
                    JournalQuestionView(conditionCategory: journalQuestions[2], isBodyPart: $isBodyPart, bodyPart: $viewModel.scratchPart, slider: $viewModel.scratchValue)
                default:
                    Text("Should be going to the next journal")
                }
                Button("Next") {
                    if isBodyPart {
                        viewModel.percentageDone += 0.05
                        isBodyPart.toggle()
                    } else if questionSect == 2 {
                        if viewModel.journalMode == .onboarding {
                            showTrackRoutine.toggle()
                        } else {
                        }
                    } else {
                        isBodyPart.toggle()
                        questionSect += 1
                        viewModel.percentageDone += 0.05
                        isDoneButtonDisabled = true
                    }
                }
                .disabled(isDoneButtonDisabled)
                .buttonStyle(ExzoButtonStyle(type: .primary))
                .onChange(of: viewModel.rednessPart) { newValue in
                    isDoneButtonDisabled = newValue.isEmpty
                }
                .onChange(of: viewModel.scratchPart) { newValue in
                    isDoneButtonDisabled = newValue.isEmpty
                }
                .onChange(of: viewModel.swellingPart) { newValue in
                    isDoneButtonDisabled = newValue.isEmpty
                }
                NavigationLink(isActive: $showTrackRoutine) {
                    JournalConcernView(viewModel: viewModel)
                } label: {
                    
                }
                .hidden()
            }
            .padding()
            .navigationTitle("Kondisi Kulit")
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
                                viewModel.percentageDone -= 0.05
                            } else {
                                isBodyPart.toggle()
                                viewModel.percentageDone -= 0.05
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
        SkinConditionJournalView(jourVM: JournalInputViewModel(.adult, mode: .onboarding))
    }
}
