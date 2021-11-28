//
//  OnboardingSetTimerView.swift
//  exzo
//
//  Created by Nicholas on 25/11/21.
//

import SwiftUI

struct OnboardingSetTimerView: View {
    @Environment(\.modalMode) var modalMode
    @State var selectedTime = Date()
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("Atur pengingat")
                .font(Lexend(.title2)
                        .getFont()
                        .bold())
            Text("Kami akan mengingatkan Anda untuk memasukkan jurnal (sekali sehari) pada saat **anak Anda merasa gatal**. Jangan khawatir, Anda dapat mengubahnya kapan saja melalui **Pengaturan.**")
            HStack {
                Spacer()
                DatePicker("Pilih waktu:", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(CompactDatePickerStyle())
                Spacer()
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
            }
            .shadow(radius: 2)
            Spacer()
            Button("Atur pengingat") {
                // Dismiss modal + user defaults
                dismissModal()
            }
            .buttonStyle(ExzoButtonStyle(type: .primary))
            HStack {
                Spacer()
                Button("Atur nanti") {
                    // just dismiss modal
                    dismissModal()
                }
                Spacer()
            }
        }
        .padding()
        .navigationBarHidden(true)
    }
    
    func dismissModal() {
        UDHelper.sharedUD.setNewUser()
        modalMode.wrappedValue.toggle()
    }
}

struct OnboardingSetTimerView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSetTimerView()
    }
}
