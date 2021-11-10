//
//  FEAListView.swift
//  exzo
//
//  Created by Deven Nathanael on 10/11/21.
//

import SwiftUI

struct FEAListView: View {
    var body: some View {
        let title: String = "Food Intake"

        NavigationView {
            List {
                Section {
                    Button(action: {
                        
                    }, label: {
                        FEAListRowView()
                    })
                    FEAListRowView()
                    FEAListRowView()
                    
                }
                .listRowBackground(Color.init(red: 242/255, green: 242/255, blue: 242/255))
//                .padding(3)
                Section {
                    HStack {
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            Text("+ Add new food intake")
                                .font(.system(size: 17))
                                .fontWeight(.heavy)
                                .foregroundColor(Color.white)
                                .padding(10)

                        })
                        Spacer()
                    }
                    .listRowBackground(Color("accent_brandy"))
                    .cornerRadius(13.0)
                }
                
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

struct FEAListView_Previews: PreviewProvider {
    static var previews: some View {
        FEAListView()
    }
}
