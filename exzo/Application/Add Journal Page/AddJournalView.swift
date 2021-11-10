//
//  AddJournalView.swift
//  exzo
//
//  Created by Nicholas on 04/11/21.
//

import SwiftUI

// MARK: - Cuma buat nyoba. Hapus ketika sudah di integrate dengan core data nya stef
struct ModalPlaceholder: View {
    @State var showModal = false
    
    var body: some View {
        Button {
            showModal.toggle()
        } label: {
            Image(systemName: "plus")
            Text("Add a Journal Entry")
        }.padding()
            .buttonStyle(ExzoButtonStyle(type: .primary))
            .sheet(isPresented: $showModal, onDismiss: nil) {
                AddJournalView()
            }
    }
}

struct AddJournalView: View {
    @Environment(\.dismiss) private var dismiss
    
    // Viewmodel akan ada 2, untuk add dan edit
    @StateObject var viewModel = AddJournalViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    JournalSection(type: .foodIntake) {
                        CategoryGrid($viewModel.foodIntake, color: .accentYellow)
                    } openPage: {
                        // TODO: Edit hingga bisa buka intake editor
                        print("Open Food Intake Editor")
                    }
                    JournalSection(type: .stressLevel) {
                        ExzoSlider(value: $viewModel.stressLevelSlider, range: viewModel.sliderRange1)
                    }
                    JournalSection(type: .exposure) {
                        CategoryGrid($viewModel.exposure, color: .copper)
                    } openPage: {
                        // TODO: Edit hingga bisa buka exposure editor
                        print("Open Exposure Editor")
                    }
                    JournalSection(type: .activities) {
                        CategoryGrid($viewModel.activities, color: .brandy)
                    } openPage: {
                        // TODO: Edit hingga bisa buka activity editor
                        print("Open Activity Editor")
                    }
                    JournalSection(type: .skinConditions) {
                        VStack(spacing: 20) {
                            ExzoSlider(title: "Dryness", value: $viewModel.dryness, range: viewModel.sliderRange2)
                            ExzoSlider(title: "Redness", value: $viewModel.redness, range: viewModel.sliderRange2)
                            ExzoSlider(title: "Swelling", value: $viewModel.swelling, range: viewModel.sliderRange2)
                            ExzoSlider(title: "Crust/Oozing", value: $viewModel.crust, range: viewModel.sliderRange2)
                            ExzoSlider(title: "Scratch traces", value: $viewModel.scratchTraces, range: viewModel.sliderRange2)
                            ExzoSlider(title: "Thickened skin", value: $viewModel.thickSkin, range: viewModel.sliderRange2)
                            ExzoSlider(title: "Itchiness", value: $viewModel.itchiness, range: viewModel.sliderRange1)
                            ExzoSlider(title: "Sleep Loss", value: $viewModel.sleepLoss, range: viewModel.sliderRange1)
                        }
                    }
                    JournalSection(type: .triggerAreas) {
                        TriggerAreaHScroll(items: $viewModel.triggerAreas)
                    } openPage: {
                        // TODO: Edit hingga bisa buka trigger area editor
                        print("Open Trigger Area Editor")
                    }
                }
                .padding()
            }
            .navigationTitle("Add Journal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", action: dismiss.callAsFunction)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        viewModel.doneBtnPressed {
                            if $0 {
                                dismiss()
                            }
                        }
                    }
                    .disabled(viewModel.doneDisabled)
                }
            }
        }
    }
}

struct AddJournalView_Previews: PreviewProvider {
    static var previews: some View {
        AddJournalView()
        AddJournalView()
            .preferredColorScheme(.dark)
    }
}
