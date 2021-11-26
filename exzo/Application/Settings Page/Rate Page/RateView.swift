//
//  RateView.swift
//  exzo
//
//  Created by Deven Nathanael on 23/11/21.
//

import SwiftUI

struct RateView: View {
    @State var titleRate: String = ""
    @State var reviewRate: String = ""
    
    var body: some View {
        Text("RATE APP")
//        List {
//            VStack {
//
//            }
//            TextField("Title", text: $titleRate)
//            TextField("Review (Optional)", text: $reviewRate)
//        }
//
//        .navigationTitle("Write a Review")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button("Done") {
//
//                }
//            }
//        }
    }
}

struct RateView_Previews: PreviewProvider {
    static var previews: some View {
        RateView()
    }
}
