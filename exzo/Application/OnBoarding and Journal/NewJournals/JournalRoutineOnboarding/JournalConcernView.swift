//
//  JournalChoiceQuestionView.swift
//  exzo
//
//  Created by Nicholas on 24/11/21.
//

import SwiftUI
import Combine

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
    @State var chosen: Bool
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

class ConcernVM: ObservableObject {
    @Published var chosenTrigger: [String] = [String]()
    
    var subs = Set<AnyCancellable>()
    
    init() {
        UDHelper.sharedUD.subsConcern { triggers in
            self.chosenTrigger = triggers
        }.store(in: &subs)
    }
}

struct JournalConcernView: View {
    @Environment(\.presentationMode) var isPresented
    
    @ObservedObject var viewModel: JournalInputViewModel
    @StateObject var concVM: ConcernVM = ConcernVM()
    
    var triggers = EczemaTriggers.allCases
    
    @State var goToNextPage = false
    @State var nextBtnDisabled = true
    
    var forUpdate: Bool = false
    
    init() {
        viewModel = JournalInputViewModel(ProfileCategory(
            rawValue: UDHelper.sharedUD
                .defaults.string(
                    forKey: UDKey.userType.rawValue
                ) ?? "userProf"
        ) ?? .adult, mode: .onboarding)
        forUpdate = true
    }
    
    init(viewModel: JournalInputViewModel) {
        self.viewModel = viewModel
        forUpdate = false
    }
    
    var body: some View {
        VStack {
            VStack {
                if !forUpdate {
                    CustomProgressView(percent: $viewModel.percentageDone)
                }
                Text("Apa pemicu eczema yang ingin Anda ketahui?")
                    .font(Lexend(.title2).getFont().bold())
                Text("Kami akan membuat personalisasi berdasarkan pilihan Anda dalam pengisian jurnal dan hasil analisisnya.")
            }
            .padding(.horizontal)
            .padding(.top)
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(EczemaTriggers.allCases, id: \.self) {
                    EczemaTriggersRow(trigger: $0, chosen: concVM.chosenTrigger.contains($0.rawValue)) { trigger, chosen in
                        if chosen {
                            concVM.chosenTrigger.append(trigger.rawValue)
                        } else {
                            concVM.chosenTrigger.removeAll { trig in
                                trigger.rawValue == trig
                            }
                        }
                    }
                }
            }
            Spacer()
            Button(forUpdate ? "Simpan" : "Lanjut") {
                // Action untuk save ke user defaults
                UDHelper.sharedUD.setConcern(concVM.chosenTrigger)
                viewModel.chosenTriggerCategory = concVM.chosenTrigger
                // ke halaman berikutnya
                
                if concVM.chosenTrigger.isEmpty || self.forUpdate {
                    self.isPresented.wrappedValue.dismiss()
                } else {
                    goToNextPage.toggle()
                }
            }
            .buttonStyle(ExzoButtonStyle(type: .primary))
            .padding()
            .onChange(of: concVM.chosenTrigger) { newValue in
                nextBtnDisabled = newValue.isEmpty
            }
            .disabled(nextBtnDisabled)
            NavigationLink("Lanjut", isActive: $goToNextPage, destination: {
                // Masuk ke halaman yg itu loh, tp get data dl dr user defaults
                if concVM.chosenTrigger.contains(EczemaTriggers.stress.rawValue) {
                    StressLevelSliderView(viewModel)
                } else if concVM.chosenTrigger.contains(EczemaTriggers.foodIntake.rawValue) {
                    NewJournalIEPView(.foodIntake, viewModel: viewModel)
                } else if concVM.chosenTrigger.contains(EczemaTriggers.exposure.rawValue) {
                    NewJournalIEPView(.exposure, viewModel: viewModel)
                } else if concVM.chosenTrigger.contains(EczemaTriggers.medProd.rawValue) {
                    NewJournalIEPView(.medProd, viewModel: viewModel)
                } else {
                    Text("DISMISS THIS VIEW")
                }
            })
            .hidden()
        }
        .navigationTitle("Lacak rutin")
        .onAppear {
            self.nextBtnDisabled = concVM.chosenTrigger.isEmpty
        }
    }
}

struct JournalChoiceQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        JournalConcernView(viewModel: JournalInputViewModel(.adult, mode: .create))
    }
}
