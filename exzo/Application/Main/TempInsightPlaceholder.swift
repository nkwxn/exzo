//
//  TempInsightPlaceholder.swift
//  exzo
//
//  Created by Nicholas on 15/11/21.
//

import SwiftUI

class TempInsightViewModel: ObservableObject {
    var fourWeeksFoodIntake = CDStorage.shared.getFoodIntakesForInsight() // [String: Int]
}

struct TempInsightPlaceholder: View {
    @StateObject var viewModel = TempInsightViewModel()
    
    var body: some View {
        ZStack {
            Image("Header")
                .resizable(resizingMode: .tile)
                .ignoresSafeArea(edges: .top)
                .ignoresSafeArea(edges: .horizontal)
            VStack {
                Text("Analisis belum tersedia!")
                    .font(Lexend(.title).getFont().weight(.bold))
                Text("Nantikan fitur terbaru exzo pada pembaruan mendatang")
                Text("Asupan Makanan terbanyak 30 hari terakhir = \(viewModel.fourWeeksFoodIntake[0].key)")
                Text("Asupan Makanan terbanyak 30 hari terakhir = \(viewModel.fourWeeksFoodIntake[0].key)")
                Text("Asupan Makanan terbanyak 30 hari terakhir = \(viewModel.fourWeeksFoodIntake[0].key)")
            }
            .padding()
            .multilineTextAlignment(.center)
            .background {
                RoundedRectangle(cornerRadius: 19)
                    .foregroundColor(Color.white)
                    .shadow(color: Color.init(uiColor: UIColor.init(red: 0.45, green: 0.29, blue: 0.22, alpha: 0.2)), radius: 10, x: 2, y: 5)
            }
            .padding()
        }
    }
}

struct TempInsightPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        TempInsightPlaceholder()
    }
}
