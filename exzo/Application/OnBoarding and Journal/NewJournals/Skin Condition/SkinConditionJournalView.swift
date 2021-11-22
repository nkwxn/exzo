//
//  SkinConditionJournalView.swift
//  exzo
//
//  Created by Nicholas on 22/11/21.
//

import SwiftUI

enum JournalMode {
    case onboarding
    case create
    case update
}

struct SkinConditionJournalView: View {
    var mode: JournalMode
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 15) {
                CustomProgressView(percent: .constant(0.2))
                HStack {
                    Text("Redness")
                        .font(Lexend(.title2).getFont().bold())
                    Button {
                        // show info
                    } label: {
                        // label contains img
                        Image(systemName: "info.circle")
                    }
                }
                Text("Which part of your chid's body that gets inflamed the most?")
                Spacer()
                Button("Next") {
                    // action to go next
                }
                .buttonStyle(ExzoButtonStyle(type: .primary))
            }
            .padding()
            .navigationTitle("Skin Condition")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SkinConditionJournaView_Previews: PreviewProvider {
    static var previews: some View {
        SkinConditionJournalView(mode: .onboarding)
    }
}
