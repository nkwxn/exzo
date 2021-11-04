//
//  JournalSection.swift
//  exzo
//
//  Created by Nicholas on 04/11/21.
//

import SwiftUI

struct JournalSection<Content: View>: View {
    let type: JournalSectionType
    let content: () -> Content
    @State var contentHidden = false
    @State var popoverPresent = false
    
    var body: some View {
        VStack {
            HStack {
                Text(type.rawValue)
                Button {
                    // action to open
                    popoverPresent.toggle()
                } label: {
                    Image(systemName: "info.circle")
                }
                Spacer()
                Button {
                    // action
                } label: {
                    Image(systemName: "highlighter")
                }
                Button {
                    withAnimation {
                        self.contentHidden.toggle()
                    }
                } label: {
                    Image(systemName: "chevron.up")
                }
            }
            if !contentHidden {
                HStack(content: content)
                    .transition(.scale(scale: 0, anchor: .top))
            }
            Divider()
        }
    }
}
