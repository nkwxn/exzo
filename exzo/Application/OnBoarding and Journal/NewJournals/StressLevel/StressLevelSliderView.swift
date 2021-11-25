//
//  StressLevelSliderView.swift
//  exzo
//
//  Created by Nicholas on 25/11/21.
//

import SwiftUI

struct StressLevelSliderView: View {
    var body: some View {
        VStack {
            CustomProgressView(percent: .constant(0.7))
            Text("Stres")
            Text("Bagaimana suasana hati anak Anda sekarang?")
            Image("L4 - Boy")
                .resizable()
                .frame(width: 200, height: 200)
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
