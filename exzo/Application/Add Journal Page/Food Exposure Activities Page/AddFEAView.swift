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
    @State var showWarning = false
    
    init(category: IEA, accent: Color) {
        self.category = category
        self.accent = accent
    }
    
    var body: some View {
        List {
            Section {
                AddFEARowView(title: "Kategori", chooseImage: false, icon: nil, name: category.getLocalizedName(), color: accent)
                NavigationLink {
                    SelectIconView(iconSelection: $imageChoice, accentColor: accent)
                } label: {
                    AddFEARowView(title: "Ikon", chooseImage: true, icon: imageChoice.isEmpty ? Image(systemName: "xmark.circle") : Image(imageChoice), name: "...", color: accent)
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
        .alert("Periksa kembali isian Anda", isPresented: $showWarning) {
            Button("OK") {
                self.showWarning = false
            }
        } message: {
            if imageChoice.isEmpty {
                Text("Anda masih belum memilih gambar\( name.isEmpty || name == "..." ? " dan mengisi nama" : "" ).")
            } else if name.isEmpty || name == "..." {
                Text("Anda masih belum mengisi nama.")
            }
        }
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
                    if doneDisabled {
                        print("Should show alert")
                        self.showWarning.toggle()
                    } else {
                        CDStorage.shared.createIEA(category, name: self.name, thumb: imageChoice)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct AddFEAView_Previews: PreviewProvider {
    static var previews: some View {
        AddFEAView(category: .activity, accent: Color.brandy)
    }
}
