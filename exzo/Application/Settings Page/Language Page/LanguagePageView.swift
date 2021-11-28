//
//  LanguagePageView.swift
//  exzo
//
//  Created by Deven Nathanael on 23/11/21.
//

import SwiftUI

struct LanguagePageView: View {
    var body: some View {
        List {
            Button(action: {
                
            }, label: {
                Text("English")
            })
            Button(action: {
                
            }, label: {
                Text("Bahasa")
            })
        }
        .foregroundColor(.black)
        
        .navigationTitle("Language")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LanguagePageView_Previews: PreviewProvider {
    static var previews: some View {
        LanguagePageView()
    }
}
