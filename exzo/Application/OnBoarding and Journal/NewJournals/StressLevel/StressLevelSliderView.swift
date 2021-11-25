//
//  StressLevelSliderView.swift
//  exzo
//
//  Created by Nicholas on 25/11/21.
//

import SwiftUI

struct StressLevelSliderView: View {
    @State var stressValue: Double = 2
    var captionText: [String] = [
        "Anak Anda merasa sangat bahagia dan penuh senyum, tidak menunjukkan kesedihan, kecemasan, atau gejala mental negatif apa pun",
        "Ekspresi wajahnya menunjukkan keadaan normal (tidak merasa senang tetapi tidak sedih)",
        "Anak Anda menunjukkan sedikit ketidaknyamanan atau gangguan saat ada sesuatu yang mengganggunya",
        "Anak Anda menunjukkan frustrasi dan sangat kesal dengan situasi sensitif, mulai berbicara dengan nada dan volume tinggi",
        "Anak Anda menunjukkan kemarahan, memiliki kecenderungan untuk menendang atau memukul sesuatu, berteriak, dan tidak mendengarkan dengan baik"
    ]
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            CustomProgressView(percent: .constant(0.7))
            VStack(alignment: .leading, spacing: 8) {
                Text("Stres")
                    .font(Lexend(.title2).getFont().bold())
                Text("Bagaimana suasana hati anak Anda sekarang?")
            }
            Image("L\(String(format: "%.0f", stressValue)) - Boy")
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
                print("Lanjut ke halaman yang sesuai UD (mana yg enabled)")
            }
            .buttonStyle(ExzoButtonStyle(type: .primary))
            Spacer()
        }
        .padding()
        .navigationTitle("Stres")
    }
}

struct StressLevelSliderView_Previews: PreviewProvider {
    static var previews: some View {
        StressLevelSliderView()
    }
}
