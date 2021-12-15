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
    let sliderValues: [String]
}

struct SkinConditionJournalView: View {
    @Environment(\.dismiss) var dismiss
    
    // Init for create
    init() {
        self.viewModel = JournalInputViewModel(
            ProfileCategory(
                rawValue: UDHelper.sharedUD.defaults.string(forKey: UDKey.userType.rawValue) ?? "userProf"
            ) ?? .adult,
            mode: .create
        )
    }
    
    init(jourVM: JournalInputViewModel) {
        self.viewModel = jourVM
    }
    
    // For update
    init(journalContent: NewJournal) {
        let category = ProfileCategory(rawValue: UDHelper.sharedUD.defaults.string(forKey: UDKey.userType.rawValue) ?? "userProf") ?? .adult
        self.viewModel = JournalInputViewModel(
            category,
            item: journalContent
        )
    }
    
    @ObservedObject var viewModel: JournalInputViewModel
    
    var journalQuestions: [JournalQuestions] {
        return [
            JournalQuestions(
                name: "Peradangan",
                info: "kemerahan",
                imageName: "redness_",
                sliderValues: [
                    "Tidak ada kemerahan dan warna kulit yang sama dengan kulit normal \(self.viewModel.category == .child ? "anak " : "")Anda pada umumnya",
                    "Kulit \(self.viewModel.category == .child ? "anak " : "")anda memiliki warna merah muda yang terang dan pudar",
                    "Kulit \(self.viewModel.category == .child ? "anak " : "")Anda memiliki warna merah kusam dan terlihat dengan jelas",
                    "Kulit \(self.viewModel.category == .child ? "anak " : "") Anda memiliki warna merah tua serta cenderung gelap, pembuluh kapiler dan memar mungkin terlihat"
                ]
            ),
            JournalQuestions(
                name: "Pembengkakan",
                info: "pembengkakan",
                imageName: "Swelling",
                sliderValues: [
                    "Tidak ada pembengkakan",
                    "Setelah menekan area pembengkakan, kulit langsung kembali membengkak, proses kembali membengkak hampir tidak terlihat.",
                    "Setelah menekan area pembengkakan, kulit perlahan kembali membengkak dalam waktu 10-15 detik.",
                    "Kulit terlihat berkerak dan setelah menekan area pembengkakan, kulit kembali membengkak dalam waktu lebih dari 60 detik."
                ]
            ),
            JournalQuestions(
                name: "Bekas garukan",
                info: "bekas garuk",
                imageName: "Scratch",
                sliderValues: [
                    "Tidak ada tanda bekas garuk",
                    "Kemunculan tanda bekas garuk yang sedikit, tidak ada erosi atau kerak di area sekitar bekas garukan",
                    "Terdapat beberapa tanda garis lurus dari bekas garuk yang jelas dan kulit menunjukkan erosi atau kerak yang terlihat",
                    "Terdapat banyak garis lurus dan dalam yang terlihat sangat jelas dan kulit menujukkan banyak erosi atau kerak"
                ]
            )
        ]
    }
    
    @State var questionSect = 0
    @State var isBodyPart = true
    
    @State var isDoneButtonDisabled = true
    @State var showTrackRoutine = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 15) {
                CustomProgressView(percent: $viewModel.percentageDone)
                HStack {
                    Text(journalQuestions[questionSect].name)
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
                    // swiftlint:disable line_length
                    Text(
                        isBodyPart ? "Bagian mana dari tubuh \(viewModel.category == .child ? "anak " : "")Anda yang paling sering mengalami \(journalQuestions[questionSect].info)?" : "Berdasarkan bagian tubuh yang Anda pilih, seberapa parah \(journalQuestions[questionSect].info) kulit Anda saat ini?"
                    )
                    Spacer()
                }
                switch questionSect {
                case 0:
                    // Redness
                    JournalQuestionView(
                        userCategory: viewModel.category,
                        conditionCategory: journalQuestions[0],
                        isBodyPart: $isBodyPart,
                        bodyPart: $viewModel.rednessPart,
                        slider: $viewModel.rednessValue
                    )
                case 1:
                    // Swelling
                    JournalQuestionView(
                        userCategory: viewModel.category,
                        conditionCategory: journalQuestions[1],
                        isBodyPart: $isBodyPart,
                        bodyPart: $viewModel.swellingPart,
                        slider: $viewModel.swellingValue
                    )
                case 2:
                    // Scratch Mark
                    JournalQuestionView(
                        userCategory: viewModel.category,
                        conditionCategory: journalQuestions[2],
                        isBodyPart: $isBodyPart,
                        bodyPart: $viewModel.scratchPart,
                        slider: $viewModel.scratchValue
                    )
                default:
                    Text("Should be going to the next journal")
                }
                Button("Next") {
                    if isBodyPart {
                        viewModel.percentageDone += 0.05
                        isBodyPart.toggle()
                    } else if questionSect == 2 {
                        showTrackRoutine.toggle()
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
                    switch viewModel.journalMode {
                    case .onboarding:
                        JournalConcernView(viewModel: viewModel)
                    default:
                        if viewModel.chosenTriggerCategory.contains(EczemaTriggers.stress.rawValue) {
                            StressLevelSliderView(viewModel)
                        } else if viewModel.chosenTriggerCategory.contains(EczemaTriggers.foodIntake.rawValue) {
                            NewJournalIEPView(.foodIntake, viewModel: viewModel)
                        } else if viewModel.chosenTriggerCategory.contains(EczemaTriggers.exposure.rawValue) {
                            NewJournalIEPView(.exposure, viewModel: viewModel)
                        } else if viewModel.chosenTriggerCategory.contains(EczemaTriggers.medProd.rawValue) {
                            NewJournalIEPView(.medProd, viewModel: viewModel)
                        } else {
                            Text("DISMISS THIS VIEW")
                        }
                    }
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
                                viewModel.percentageDone -= 0.05
                            }
                            isBodyPart.toggle()
                        }
                    } label: {
                        // tambahin if
                        if questionSect == 0 && isBodyPart {
                            Text("Batal")
                        } else {
                            Image(systemName: "chevron.backward")
                            Text("Kembali")
                        }
                    }
                }
            }
        }
    }
}

struct JournalQuestionView: View {
    var userCategory: ProfileCategory
    var conditionCategory: JournalQuestions
    
    @Binding var isBodyPart: Bool
    @Binding var bodyPart: [String]
    @Binding var slider: Double
    @State var quote = ""
    var range = 0.0...3.0
    
    var body: some View {
        VStack(spacing: 14) {
            Spacer()
            if isBodyPart {
                HStack {
                    Spacer()
                    Text("Depan")
                        .fixedSize(horizontal: true, vertical: false)
                        .frame(width: 75, height: 30, alignment: .center)
                    Spacer(minLength: 140)
                    Text("Belakang")
                        .fixedSize(horizontal: true, vertical: false)
                        .frame(width: 75, height: 30, alignment: .center)
                    Spacer()
                }
                switch userCategory {
                case .child:
                    ChildBodiesView(score: .constant(0), bodyArr: $bodyPart)
                        .padding(.horizontal)
                        .position(x: (UIScreen.main.bounds.width / 2.5), y: (UIScreen.main.bounds.height / 5) * 0.1)
                        .onChange(of: bodyPart) { newValue in
                            print(newValue)
                        }
                case .adult:
                    BodyPartsView(score: .constant(0), bodyArr: $bodyPart)
                        .padding(.horizontal)
                        .position(x: (UIScreen.main.bounds.width / 2.5), y: (UIScreen.main.bounds.height / 5) * 0.1)
                        .onChange(of: bodyPart) { newValue in
                            print(newValue)
                        }
                }
            } else {
                Image("\(conditionCategory.imageName)\(String(format: "%.0f", slider))")
                    .resizable()
                    .frame(width: 220, height: 220)
                    .clipShape(Circle())
                
                Slider(value: $slider, in: range, step: 1)
                Text(String(format: "%.0f", slider))
                    .font(Lexend(.title3).getFont().bold())
                Text(conditionCategory.sliderValues[Int(slider)])
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
