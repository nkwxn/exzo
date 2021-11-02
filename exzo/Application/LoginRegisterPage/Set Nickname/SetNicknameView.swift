//
//  SetNicknameView.swift
//  Atemis
//
//  Created by Nicholas on 01/11/21.
//

import SwiftUI

struct SetNicknameView: View {
    var body: some View {
        // TODO: Ubah style ke custom text field dan button style
        VStack {
            Spacer()
            TextField("What's your nickname?", text: .constant(""))
            Spacer()
            Button("Done") {
                // TODO: Connect ke Onboarding
                
            }
        }
        .navigationTitle("Your Profile")
    }
}

struct SetNicknameView_Previews: PreviewProvider {
    static var previews: some View {
        SetNicknameView()
    }
}
