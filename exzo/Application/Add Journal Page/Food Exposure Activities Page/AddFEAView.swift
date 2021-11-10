//
//  AddFEAView.swift
//  exzo
//
//  Created by Deven Nathanael on 09/11/21.
//

import SwiftUI

struct AddFEAView: View {
    let title: String = "Food Intake"
    
    static let defaultFoodCategory: String = "Food Category"
    static let defaultFoodIcon: String = "Food Icon"
    static let defaultFoodName: String = "Food Name"
    
    @State var selectedCategory: Bool = true
    @State var selectedIcon: Bool = true
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    AddFEARowView(title: "Category", chooseImage: false, icon: nil, name: title)
                    AddFEARowView(title: "Icon", chooseImage: false, icon: nil, name: "...")
                    AddFEARowView(title: "Name", chooseImage: false, icon: nil, name: "...")
                }
                .listRowBackground(Color.init(red: 242/255, green: 242/255, blue: 242/255))
                
            }
            .listStyle(InsetGroupedListStyle())
            
//            Form {
//                Section{
//                    Picker(selection: $selectedCategory, label: Text("Category")) {
//                    }
//                    Picker(selection: $selectedIcon, label: Text("Icons")) {
//
//                    }
//                }
//            }
            .onAppear {
                UITableView.appearance().backgroundColor = .clear
            }
            .onDisappear {
                UITableView.appearance().backgroundColor = .systemGray
            }
//            .background(Color.white)
            .navigationTitle("Add \(title)")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                
            }, label: {
                Text("Cancel")
            }))
            .navigationBarItems(trailing: Button(action: {
                
            }, label: {
                Text("Done")
            }).disabled(true))
        }
    }
}

struct AddFEAView_Previews: PreviewProvider {
    static var previews: some View {
        AddFEAView()
    }
}
