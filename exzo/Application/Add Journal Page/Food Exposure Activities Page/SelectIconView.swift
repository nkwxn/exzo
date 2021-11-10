//
//  SelectIconView.swift
//  exzo
//
//  Created by Deven Nathanael on 09/11/21.
//

import SwiftUI

struct SelectIconView: View {
    var body: some View {
        NavigationView {
//            IconRowView()
            VStack(spacing: 20) {
                IconRowView()
                IconRowView()
                IconRowView()
                Spacer()
            }
            .padding(.top)
            .onAppear {
                UITableView.appearance().backgroundColor = .clear
            }
            .onDisappear {
                UITableView.appearance().backgroundColor = .systemGray
            }
//            .background(Color.white)
            .navigationTitle("Select Icon")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                
            }, label: {
                Text("Cancel")
            }))
            .navigationBarItems(trailing: Button(action: {
                
            }, label: {
                Text("Done")
            }).disabled(true))
            Spacer()
        }
    }
}

struct SelectIconView_Previews: PreviewProvider {
    static var previews: some View {
        SelectIconView()
    }
}
