//
//  OnboardingSetTimerView.swift
//  exzo
//
//  Created by Nicholas on 25/11/21.
//

import SwiftUI

struct OnboardingSetTimerView: View {
    @State var selectedTime = Date()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Atur pengingat")
                .font(Lexend(.title2)
                        .getFont()
                        .bold())
            Text("Kami akan mengingatkan Anda untuk memasukkan jurnal (sekali sehari) pada saat **anak Anda merasa gatal**. Jangan khawatir, Anda dapat mengubahnya kapan saja melalui **Pengaturan.**")
            DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(CompactDatePickerStyle())
        }
        .padding()
    }
}

struct OnboardingSetTimerView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSetTimerView()
    }
}
