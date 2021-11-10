//
//  JournalSection.swift
//  exzo
//
//  Created by Nicholas on 04/11/21.
//

import Foundation
import SwiftUI

struct JournalSection<Content: View>: View {
    let type: JournalSectionType
    let content: () -> Content
    var openPage: () -> Void = {}
    @State var contentHidden = false
    @State var popoverPresent = false
    
    var body: some View {
        VStack {
            HStack {
                Text(type.rawValue)
                    .font(Avenir(.headline).getFont().bold())
                Button {
                    // action to open
                    popoverPresent.toggle()
                } label: {
                    Image(systemName: "info.circle")
                }
                .popover(isPresented: $popoverPresent) {
                    NavigationView {
                        ScrollView {
                            Text(type.getDescriptions())
                                .padding()
                        }
                        .navigationTitle(type.rawValue)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    self.popoverPresent.toggle()
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .symbolRenderingMode(.hierarchical)
                                }
                            }
                        }
                    }
                }
                Spacer()
                if type.getEditable() {
                    Button(action: openPage) {
                        Image(systemName: "list.bullet")
                    }
                }
                Button {
                    withAnimation {
                        self.contentHidden.toggle()
                    }
                } label: {
                    Image(systemName: contentHidden ? "chevron.down" : "chevron.up")
                }
            }
            if !contentHidden {
                content()
                    .transition(.scale(scale: 0, anchor: .top))
            }
            Divider()
        }
    }
}
