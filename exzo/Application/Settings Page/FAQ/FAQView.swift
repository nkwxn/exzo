//
//  FAQView.swift
//  exzo
//
//  Created by Difa N Pratama on 21/01/22.
//

import SwiftUI

struct Collapsible<Content: View>: View {
    @State var label: () -> Text
    @State var content: () -> Content
    
    @State private var collapsed: Bool = true
    
    var body: some View {
        VStack {
            Button(
                action: { self.collapsed.toggle() },
                label: {
                    HStack {
                        self.label()
                        Spacer()
                        Image(systemName: self.collapsed ? "chevron.down" : "chevron.up")
                    }
                    .padding(.bottom, 1)
                    .background(Color.white.opacity(0.01))
                }
            )
                
            
            VStack {
                self.content()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .none)
            .clipped()
            .animation(.easeOut)
            .transition(.slide)
        }
    }
}

struct FaqRow: View {
    var question: String
    var answer: String
    var body: some View {
        Collapsible(
            label: { Text("\(question)") },
            content: {
                HStack {
                    Text("\(answer)")
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.white)
            }
        )
            .frame(maxWidth: .infinity)
    }
}

struct FAQView: View {
    var question = ["Apa itu Eczema?", "Apakah Exzo menjual data, dikarenakan aplikasi ini gratis?", "Berapa lama untuk mendapatkan analisis?"]
    var answer = [
        "Eczema adalah penyakit kulit yang menyebabkan gatal, memar, kemerahan.",
                  "Tidak aplikasi kami tidak akan menjual data user. Dan semua data yang dimasukan akan kami jaga rahasianya",
                  "Diperlukan waktu selama 30 hari, untuk mendapatkan hasil analisis yang sempurna"]
    var body: some View {
        VStack {
//            CustomNavBarView(twoColumnsNavBar: false, title: "FAQs", subtitle: nil, showButton: .none) {
//                // Action untuk buka settings
//            }
            HStack{
                Spacer()
                Text("FAQS")
                    .font(.title)
                Spacer()
            }
            
            ScrollView{
                ForEach(0..<question.count) {
                    index in
                    FaqRow(question: question[index], answer: "Eczema adalah penyakit kulit")
                        .padding()
                        
                }
            }
        }
    }
}

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView()
    }
}
