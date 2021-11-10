//
//  BodyPartsView.swift
//  exzo
//
//  Created by Difa N Pratama on 08/11/21.
//

import SwiftUI

struct BodyPartsView: View {
//    @Binding var selected: Bool = true
    var body: some View {
        
        ZStack {
            BackBodyView()
            FrontBodyView()
        }
    }
}


struct BodyPartsView_Previews: PreviewProvider {
    static var previews: some View {
        BodyPartsView()
    }
}
