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
    case stress = "Stress"
    case medProd = "Produk atau Pengobatan"
}

struct JournalConcernView: View {
    @ObservedObject var viewModel: JournalInputViewModel
    
    var body: some View {
        VStack {
            CustomProgressView(percent: $viewModel.percentageDone)
            Text("Apa pemicu eczema yang ingin Anda ketahui?")
                .font(Lexend(.title2).getFont().bold())
            Text("Kami akan membuat personalisasi berdasarkan pilihan Anda dalam pengisian jurnal dan hasil analisisnya.")
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(EczemaTriggers.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            Spacer()
            NavigationLink("Lanjut") {
                // Masuk ke halaman yg itu loh
                
            }
            .buttonStyle(ExzoButtonStyle(type: .primary))
        }
        .padding()
    }
}

struct JournalChoiceQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        JournalConcernView(viewModel: JournalInputViewModel(.adult, mode: .create))
    }
}
