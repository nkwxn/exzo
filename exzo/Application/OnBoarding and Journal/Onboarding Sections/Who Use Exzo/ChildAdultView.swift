//
//  ChildAdultView.swift
//  exzo
//
//  Created by Nicholas on 22/11/21.
//

import SwiftUI

struct ChildAdultButton: View {
    var category: ProfileCategory
    
    var body: some View {
        
        NavigationLink {
            UserProfileView(category: self.category)
        } label: {
            HStack {
                Text(category.rawValue)
                    .font(
                        Lexend(.title2)
                            .getFont().bold()
                    )
                    .padding()
                Spacer()
                category.getImageName()
            }
            .frame(width: nil, height: 130)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                    .padding(.vertical, 10)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ChildAdultView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Who will be using exzo?")
                    .font(Lexend(.title2).getFont().bold())
                Text("Who are you using exzo for:\nis it for yourself or for your child?")
                Spacer()
                ChildAdultButton(category: .child)
                ChildAdultButton(category: .adult)
                Spacer()
            }
            .navigationTitle("Set Profile")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
    }
}

struct ChildAdultView_Previews: PreviewProvider {
    static var previews: some View {
        ChildAdultView()
            .font(Avenir.shared.getFont())
    }
}
