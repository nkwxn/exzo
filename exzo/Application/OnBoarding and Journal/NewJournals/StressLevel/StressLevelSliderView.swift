//
//  StressLevelSliderView.swift
//  exzo
//
//  Created by Nicholas on 25/11/21.
//

import SwiftUI

struct StressLevelSliderView: View {
    @Environment(\.modalMode) var modalMode
    @ObservedObject var viewModel: JournalInputViewModel
    
    init(_ vm: JournalInputViewModel) {
        self.viewModel = vm
    }
    
    var userPFP = UDHelper.sharedUD.getPFP()
    
    @State var buttonText = "Lanjut"
    var captionText: [String] {
        return [
            "\(viewModel.category == .child ? "Anak " : "")Anda merasa sangat bahagia dan penuh senyum, tidak menunjukkan kesedihan, kecemasan, atau gejala mental negatif apa pun",
            "Ekspresi wajahnya menunjukkan keadaan normal (tidak merasa senang tetapi tidak sedih)",
            "\(viewModel.category == .child ? "Anak " : "")Anda menunjukkan sedikit ketidaknyamanan atau gangguan saat ada sesuatu yang mengganggunya",
            "\(viewModel.category == .child ? "Anak " : "")Anda menunjukkan frustrasi dan sangat kesal dengan situasi sensitif, mulai berbicara dengan nada dan volume tinggi",
            "\(viewModel.category == .child ? "Anak " : "")Anda menunjukkan kemarahan, memiliki kecenderungan untuk menendang atau memukul sesuatu, berteriak, dan tidak mendengarkan dengan baik"
        ]
    }
    
    @State var goToNextPage = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            CustomProgressView(percent: .constant(0.6))
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Stres")
                        .font(Lexend(.title2).getFont().bold())
                    Text("Bagaimana suasana hati\(viewModel.category == .adult ? " " : " anak ")Anda sekarang?")
                }
                Spacer()
            }
            Image("L\(String(format: "%.0f", viewModel.stressLevel)) - \(userPFP)")
                .resizable()
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .padding()
            Slider(value: $viewModel.stressLevel, in: 0...4, step: 1) { changed in
                print(changed)
                if changed {
                    print("Changed")
                    HFHelper.selectionChanged()
                }
            }
            VStack(alignment: .center, spacing: 4) {
                Text(String(format: "%.0f", viewModel.stressLevel))
                    .font(Lexend(.title3).getFont().bold())
                Text(captionText[Int(viewModel.stressLevel)])
            }
            .multilineTextAlignment(.center)
            Spacer()
            Button(buttonText) {
                if viewModel.chosenTriggerCategory.contains(where: { cate in
                    let isIntake = cate == EczemaTriggers.foodIntake.rawValue
                    let isExposure = cate == EczemaTriggers.exposure.rawValue
                    let isProd = cate == EczemaTriggers.medProd.rawValue
                    
                    return isIntake || isExposure || isProd
                }) {
                    goToNextPage.toggle()
                } else {
                    // Save to Core Data
                    viewModel.finishInput {
                        // Completion
                        self.modalMode.wrappedValue.toggle()
                        viewModel.pushNavToTimer()
                    }
                }
            }
            .buttonStyle(ExzoButtonStyle(type: .primary))
            .onAppear {
                if viewModel.chosenTriggerCategory.contains(where: { cate in
                    let isIntake = cate == EczemaTriggers.foodIntake.rawValue
                    let isExposure = cate == EczemaTriggers.exposure.rawValue
                    let isProd = cate == EczemaTriggers.medProd.rawValue
                    
                    return isIntake || isExposure || isProd
                }) {
                    self.buttonText = "Lanjut"
                } else {
                    self.buttonText = "Selesai"
                }
            }
            NavigationLink("Lanjut", isActive: $goToNextPage) {
                if viewModel.chosenTriggerCategory.contains(EczemaTriggers.foodIntake.rawValue) {
                    NewJournalIEPView(.foodIntake, viewModel: viewModel)
                } else if viewModel.chosenTriggerCategory.contains(EczemaTriggers.exposure.rawValue) {
                    NewJournalIEPView(.exposure, viewModel: viewModel)
                } else if viewModel.chosenTriggerCategory.contains(EczemaTriggers.medProd.rawValue) {
                    NewJournalIEPView(.medProd, viewModel: viewModel)
                } else {
                    // view should be dismiss
                    Text("DISMISS THIS MODAL")
                }
            }
            .hidden()
        }
        .padding()
        .navigationTitle("Stres")
    }
}

struct StressLevelSliderView_Previews: PreviewProvider {
    static var previews: some View {
        StressLevelSliderView(JournalInputViewModel(.adult, mode: .create))
    }
}
