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
                category.getImageName()
                    .resizable()
                    .frame(width: 160, height: 160)
                    .offset(x: 0, y: category == .adult ? 5 : 0)
                Spacer()
                Text(category.rawValue)
                    .font(Lexend(.title).getFont().bold())
                    .padding()
                    .padding()
            }
            .frame(width: nil, height: 130)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.antique)
                    .shadow(radius: 2)
                    .padding(.vertical, 10)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ChildAdultView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Spacer()
                Text("Siapa yang akan menggunakan exzo?")
                    .font(Lexend(.title2).getFont().bold())
                Text("Untuk siapakah exzo akan digunakan:\napakah untuk diri Anda sendiri atau untuk anak Anda?")
                ChildAdultButton(category: .adult)
                ChildAdultButton(category: .child)
                Spacer()
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            .multilineTextAlignment(.center)
        }
    }
}

struct ChildAdultView_Previews: PreviewProvider {
    static var previews: some View {
        ChildAdultView()
            .font(Avenir.shared.getFont())
    }
}
