//
//  JournalChoiceQuestionView.swift
//  exzo
//
//  Created by Nicholas on 24/11/21.
//

import SwiftUI

enum EczemaTriggers: String, CaseIterable {
    case foodIntake = "Asupan makanan"
    case exposure = "Paparan"
    case stress = "Stres"
    case medProd = "Produk atau Pengobatan"
    
    func getDescOne() -> String {
        switch self {
        case .foodIntake:
            return "Makanan"
        case .exposure:
            return "Paparan"
        case .stress:
            return ""
        case .medProd:
            return "Produk"
        }
    }
    
    func getDescTwo() -> String {
        switch self {
        case .foodIntake:
            return "konsumsi"
        case .exposure:
            return "terpapar"
        case .stress:
            return ""
        case .medProd:
            return "gunakan"
        }
    }
}

struct EczemaTriggersRow: View {
    var trigger: EczemaTriggers
    @State var chosen = false
    var action: (EczemaTriggers, Bool) -> Void
    
    var body: some View {
        Button {
            chosen.toggle()
            action(trigger, chosen)
        } label: {
            HStack {
                Text(trigger.rawValue)
                    .foregroundColor(chosen ? .white : .black)
                Spacer()
                Image(systemName: chosen ? "checkmark.circle" : "circle")
                    .foregroundColor(chosen ? .white : .copper)
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(chosen ? .copper : .white)
                    .shadow(color: .gray, radius: 2, x: 0, y: 0)
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct JournalConcernView: View {
    @Environment(\.presentationMode) var isPresented
    
    @ObservedObject var viewModel: JournalInputViewModel
    
    var triggers = EczemaTriggers.allCases
    @State var chosenTrigger = [String]()
    
    @State var goToNextPage = false
    @State var nextBtnDisabled = true
    
    var body: some View {
        VStack {
            VStack {
                CustomProgressView(percent: $viewModel.percentageDone)
                Text("Apa pemicu eczema yang ingin Anda ketahui?")
                    .font(Lexend(.title2).getFont().bold())
                Text("Kami akan membuat personalisasi berdasarkan pilihan Anda dalam pengisian jurnal dan hasil analisisnya.")
            }
            .padding(.horizontal)
            .padding(.top)
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(EczemaTriggers.allCases, id: \.self) {
                    EczemaTriggersRow(trigger: $0) { trigger, chosen in
                        if chosen {
                            chosenTrigger.append(trigger.rawValue)
                        } else {
                            chosenTrigger.removeAll { trig in
                                trigger.rawValue == trig
                            }
                        }
                    }
                }
            }
            Spacer()
            Button("Lanjut") {
                // Action untuk save ke user defaults
                UDHelper.sharedUD.createUD(key: UDKey.userSkinPart.rawValue, value: chosenTrigger)
                viewModel.chosenTriggerCategory = chosenTrigger
                // ke halaman berikutnya
                if chosenTrigger.isEmpty {
                    self.isPresented.wrappedValue.dismiss()
                } else {
                    goToNextPage.toggle()
                }
            }
            .buttonStyle(ExzoButtonStyle(type: .primary))
            .padding()
            .onChange(of: chosenTrigger) { newValue in
                nextBtnDisabled = newValue.isEmpty
            }
            .disabled(nextBtnDisabled)
            NavigationLink("Lanjut", isActive: $goToNextPage, destination: {
                // Masuk ke halaman yg itu loh, tp get data dl dr user defaults
                if chosenTrigger.contains(EczemaTriggers.stress.rawValue) {
                    StressLevelSliderView(viewModel)
                } else if chosenTrigger.contains(EczemaTriggers.foodIntake.rawValue) {
                    NewJournalIEPView(.foodIntake, viewModel: viewModel)
                } else if chosenTrigger.contains(EczemaTriggers.exposure.rawValue) {
                    NewJournalIEPView(.exposure, viewModel: viewModel)
                } else if chosenTrigger.contains(EczemaTriggers.medProd.rawValue) {
                    NewJournalIEPView(.medProd, viewModel: viewModel)
                } else {
                    Text("DISMISS THIS VIEW")
                }
            })
            .hidden()
        }
        .navigationTitle("Lacak rutin")
    }
}

struct JournalChoiceQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        JournalConcernView(viewModel: JournalInputViewModel(.adult, mode: .create))
    }
}
