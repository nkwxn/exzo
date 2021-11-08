//
//  AddJournalView.swift
//  exzo
//
//  Created by Nicholas on 04/11/21.
//

import SwiftUI

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
                        Slider(value: $viewModel.stressLevelSlider, in: 0...10, step: 1.0) {
                            Text("Stress Level")
                        } minimumValueLabel: {
                            Text("0")
                        } maximumValueLabel: {
                            Text("10")
                        }
                    }
                    JournalSection(type: .stressLevel) {
                        Slider(value: $viewModel.stressLevelSlider, in: 0...10, step: 1.0) {
                            Text("Stress Level")
                        } minimumValueLabel: {
                            Text("0")
                        } maximumValueLabel: {
                            Text("10")
                        }
                    }
                    JournalSection(type: .exposure) {
                        Text("A")
                    }
                    JournalSection(type: .activities) {
                        Text("S")
                    }
                    JournalSection(type: .skinConditions) {
                        Text("D")
                    }
                    JournalSection(type: .triggerAreas) {
                        Text("W")
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
                        // close the modal view and back to the screen
                        dismiss()
                    }
                    .disabled(true)
                }
            }
        }
    }
}

struct AddJournalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalPlaceholder()
        AddJournalView()
    }
}
