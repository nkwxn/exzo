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
                AddFEARowView(title: "Category", chooseImage: false, icon: nil, name: category.rawValue, color: accent)
                NavigationLink {
                    SelectIconView(iconSelection: $imageChoice, accentColor: accent)
                } label: {
                    AddFEARowView(title: "Icon", chooseImage: true, icon: imageChoice.isEmpty ? Image(systemName: "circle.righthalf.filled") : Image(imageChoice), name: "...", color: accent)
                }
                Button {
                    alertNameShown.toggle()
                } label: {
                    AddFEARowView(title: "Name", chooseImage: false, icon: nil, name: name, color: accent)
                }
                .foregroundColor(Color.primary)
                .alert(isPresented: $alertNameShown, TextAlert(title: "Name", message: "Please fill it with your own \(category.rawValue)") { result in
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
        .navigationTitle("Add \(category.rawValue)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
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
