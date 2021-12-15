//
//  ChildBodiesView.swift
//  exzo
//
//  Created by Difa N Pratama on 23/11/21.
//

import SwiftUI

struct ChildBodiesView: View {
    @Binding var score: Float
    @Binding var bodyArr: [String]
    var body: some View {
        
        ZStack {
            ChildBackView(score: $score, bodyArr: $bodyArr)
            ChildFrontView(score: $score, bodyArr: $bodyArr)
        }
    }
}

struct ChildBodiesView_Previews: PreviewProvider {
    static var previews: some View {
        ChildBodiesView(score: Binding.constant(0), bodyArr: Binding.constant([""]))
    }
}
