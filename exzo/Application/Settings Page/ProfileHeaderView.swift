//
//  ProfileHeaderView.swift
//  exzo
//
//  Created by Deven Nathanael on 11/11/21.
//

import SwiftUI

struct ProfileHeaderView: View {
    var profileImage: String = "pp_004"
    var profileName: String = "Regina George"
    
    var body: some View {
        VStack {
            HStack {
                Image(profileImage)
                    .resizable()
                    .frame(width: 104, height: 104)
                    .clipShape(Circle())
                Text(profileName)
                    .font(Font.custom("lexend", size: 24))
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
        ProfileHeaderView()
    }
}
