//
//  ProfileHeaderView.swift
//  exzo
//
//  Created by Deven Nathanael on 11/11/21.
//

import SwiftUI

struct ProfileHeaderView: View {
    var profileImage: String
    var profileName: String
    
    var body: some View {
        VStack {
            HStack {
               Image(profileImage)
                    .resizable()
                    .frame(width: 104, height: 104)
                    .clipShape(Circle())
                Text(profileName)
                    .font(Lexend(.title2).getFont())
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding()
                Spacer()
            }
            .padding()
        }
        .background(
            Image("Header")
                
        )
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(profileImage: "pp_004", profileName: "Regina George")
    }
}
