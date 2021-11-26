//
//  StressLevelSliderView.swift
//  exzo
//
//  Created by Nicholas on 25/11/21.
//

import SwiftUI

struct StressLevelSliderView: View {
    @Environment(\.dismiss) var isPresented
    @ObservedObject var viewModel: JournalInputViewModel
    
    init(_ vm: JournalInputViewModel) {
        self.viewModel = vm
    }
    
    var userPFP = UDHelper.sharedUD.getPFP()
    
    @State var stressValue: Double = 2
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
            VStack(alignment: .leading, spacing: 8) {
                Text("Stres")
                    .font(Lexend(.title2).getFont().bold())
                Text("Bagaimana suasana hati anak Anda sekarang?")
            }
            Image("L\(String(format: "%.0f", stressValue)) - \(userPFP)")
                .resizable()
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .padding()
            Slider(value: $stressValue, in: 0...4, step: 1)
            VStack(alignment: .center, spacing: 4) {
                Text(String(format: "%.0f", stressValue))
                    .font(Lexend(.title3).getFont().bold())
                Text(captionText[Int(stressValue)])
            }
            .multilineTextAlignment(.center)
            Spacer()
            Button("Lanjut") {
                if viewModel.chosenTriggerCategory.contains(where: { cate in
                    let isIntake = cate == EczemaTriggers.foodIntake.rawValue
                    let isExposure = cate == EczemaTriggers.exposure.rawValue
                    let isProd = cate == EczemaTriggers.medProd.rawValue
                    
                    return isIntake || isExposure || isProd
                }) {
                    goToNextPage.toggle()
                } else {
                    isPresented()
                    // Save to Core Data
                }
            }
            .buttonStyle(ExzoButtonStyle(type: .primary))
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
