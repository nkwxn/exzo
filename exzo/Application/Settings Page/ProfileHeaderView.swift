//
//  ProfileHeaderView.swift
//  exzo
//
//  Created by Deven Nathanael on 11/11/21.
//

import SwiftUI

struct ProfileHeaderView: View {
    @Binding var profileImage: String
    @Binding var profileName: String
    @Binding var profileAge: String
    
    var body: some View {
        VStack {
            HStack {
               Image("L0 - \(profileImage)")
                    .resizable()
                    .frame(width: 104, height: 104)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(profileName)
                        .font(Lexend(.title2).getFont())
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    Text("\(profileAge) tahun")
                        .font(Lexend.shared.getFont())
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                }
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
        ProfileHeaderView(profileImage: .constant("pp_004"), profileName: .constant("Regina George"), profileAge: .constant("21"))
    }
}
