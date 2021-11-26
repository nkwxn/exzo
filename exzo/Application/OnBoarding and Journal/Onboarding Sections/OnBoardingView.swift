//
//  OnBoardingView.swift
//  exzo
//
//  Created by Difa N Pratama on 03/11/21.
//

import SwiftUI

struct OnBoardingView: View {
    @ObservedObject var viewModel: JournalInputViewModel
    
    init(category: ProfileCategory) {
        viewModel = JournalInputViewModel(category, mode: .onboarding)
    }
    
    // Show Modal or not tho
    @State var showInputModal = false
    @State var showInfoModal = false
    
    @State var nextPage = false
    
    var body: some View {
        VStack {
            Image("onBoarding")
                .edgesIgnoringSafeArea(.top)
            Text("Kami akan menanyakan 3 pertanyaan mengenai kondisi kulit \(viewModel.category == .child ? "anak " : "")Anda!")
                .font(Lexend(.title).getFont().bold())
                .padding()
                .multilineTextAlignment(.center)
            
            // swiftlint:disable line_length
            Text("Pertanyaan terkait seberapa parah kondisi kulit \(viewModel.category == .child ? "anak " : "")Anda sekarang dan memulai untuk mengisi jurnal pertama berdasarkan yang Anda khawatirkan.")
                .padding()
                .multilineTextAlignment(.center)
            Spacer()
            Button("Mulai") {
                self.showInputModal.toggle()
            }
            .sheet(isPresented: $showInputModal, onDismiss: {}) {
                // Go to the page
                SkinConditionJournalView(jourVM: viewModel)
//                    .environment(.modalMode, self.$showInputModal)
                    .interactiveDismissDisabled(true)
            }
            .buttonStyle(ExzoButtonStyle(type: .primary))
            .padding()
            NavigationLink("Show set timer", isActive: $nextPage) {
                OnboardingSetTimerView()
            }
//            .hidden()
        }
        .navigationBarHidden(true)
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView(category: .adult)
        OnBoardingView(category: .child)
    }
}

// Buat dismiss modal parent di navigation view
struct ModalModeKey: EnvironmentKey {
    static let defaultValue = Binding<Bool>.constant(false) // < required
}

// define modalMode value
extension EnvironmentValues {
    var modalMode: Binding<Bool> {
        get {
            return self[ModalModeKey.self]
        }
        set {
            self[ModalModeKey.self] = newValue
        }
    }
}
