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
}

struct EczemaTriggersRow: View {
    var trigger: EczemaTriggers
    @State var chosen = true
    var action: (EczemaTriggers, Bool) -> Void
    
    var body: some View {
        Button {
            chosen.toggle()
            action(trigger, chosen)
        } label: {
            HStack {
                Text(trigger.rawValue)
                Spacer()
                Image(systemName: chosen ? "checkmark.circle" : "circle")
                    .foregroundColor(Color.copper)
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 2, x: 0, y: 0)
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct JournalConcernView: View {
    @ObservedObject var viewModel: JournalInputViewModel
    
    var triggers = EczemaTriggers.allCases
    @State var chosenTrigger = EczemaTriggers.allCases
    
    @State var goToNextPage = false
    
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
                            chosenTrigger.append(trigger)
                        } else {
                            chosenTrigger.removeAll { trig in
                                trigger == trig
                            }
                        }
                        print(chosenTrigger)
                    }
                }
            }
            Spacer()
            Button("Lanjut") {
                // Action untuk save ke user defaults
                goToNextPage.toggle()
            }
            .buttonStyle(ExzoButtonStyle(type: .primary))
            .padding()
            NavigationLink("Lanjut", isActive: $goToNextPage) {
                // Masuk ke halaman yg itu loh, tp get data dl dr user defaults
                List {
                    Section {
                        ForEach(chosenTrigger, id: \.self) {
                            Text($0.rawValue)
                        }
                    } header: {
                        Text("The chosen triggers")
                    }

                }
            }
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
