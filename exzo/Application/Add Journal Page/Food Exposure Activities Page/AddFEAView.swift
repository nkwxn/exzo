//
//  AddFEAView.swift
//  exzo
//
//  Created by Deven Nathanael on 09/11/21.
//

import SwiftUI
import Combine

struct AddFEAView: View {
    @Environment(\.dismiss) var dismiss
    let category: IEA
    let accent: Color
    
    @State var selectedCategory: Bool = true
    @State var selectedIcon: Bool = true
    
    @State var imageChoice = ""
    @State var doneDisabled = true
    @State var name = "..."
    @State var alertNameShown = false
    
    init(category: IEA, accent: Color) {
        self.category = category
        self.accent = accent
    }
    
    var body: some View {
        List {
            Section {
                AddFEARowView(title: "Kategori", chooseImage: false, icon: nil, name: category.rawValue, color: accent)
                NavigationLink {
                    SelectIconView(iconSelection: $imageChoice, accentColor: accent)
                } label: {
                    AddFEARowView(title: "Ikon", chooseImage: true, icon: imageChoice.isEmpty ? Image(systemName: "circle.righthalf.filled") : Image(imageChoice), name: "...", color: accent)
                }
                Button {
                    alertNameShown.toggle()
                } label: {
                    AddFEARowView(title: "Nama", chooseImage: false, icon: nil, name: name, color: accent)
                }
                .foregroundColor(Color.primary)
                .alert(isPresented: $alertNameShown, TextAlert(title: "Nama", message: "Silakan isi dengan nama \(category.getLocalizedName())mu sendiri") { result in
                        if let result = result {
                            self.name = result.isEmpty ? "..." : result
                        }
                    })
            }
        }
        .onReceive(Publishers.CombineLatest3(Just(imageChoice.isEmpty), Just(name.isEmpty), Just(name == "...")), perform: { output in
            self.doneDisabled = (output.0 || output.1 || output.2)
        })
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Tambahkan \(category.getLocalizedName())")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Batalkan") {
                    self.dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Selesai") {
                    CDStorage.shared.createIEA(category, name: self.name, thumb: imageChoice)
                    dismiss()
                }
                .disabled(doneDisabled)
            }
        }
    }
}

struct AddFEAView_Previews: PreviewProvider {
    static var previews: some View {
        AddFEAView(category: .activity, accent: Color.brandy)
    }
}
