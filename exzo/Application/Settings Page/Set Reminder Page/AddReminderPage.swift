//
//  AddReminderPage.swift
//  exzo
//
//  Created by Deven Nathanael on 26/11/21.
//

import SwiftUI

struct AddReminderPage: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var setReminderViewModel: SetReminderViewModel

    @State var selectionDate = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker("", selection: $selectionDate, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                Spacer()
            }
            .navigationTitle("Tambah Pengingat")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        setReminderViewModel.addReminder(dateAndTime: selectionDate)
                        dismiss.callAsFunction()
                    }, label: {
                        Text("Simpan")
                            .fontWeight(.bold)
                    })
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(role: .cancel, action: {
                        dismiss.callAsFunction()
                    }, label: {
                        Text("Batal")
                    })
                }
            }
        }
    }
}
