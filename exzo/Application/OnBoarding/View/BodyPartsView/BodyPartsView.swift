//
//  BodyPartsView.swift
//  exzo
//
//  Created by Difa N Pratama on 08/11/21.
//

import SwiftUI

struct BodyPartsView: View {
    @Binding var score: Float
    @Binding var bodyArr: [String]
    var body: some View {
        
        ZStack {
            BackBodyView(score: $score, bodyArr: $bodyArr)
            FrontBodyView(score: $score, bodyArr: $bodyArr)
        }
    }
}
//
//
//struct BodyPartsView_Previews: PreviewProvider {
//    static var previews: some View {
//        BodyPartsView(score: Binding.constant(0))
//    }
//}
