//
//  BodyPartsView.swift
//  exzo
//
//  Created by Difa N Pratama on 08/11/21.
//

import SwiftUI

struct BodyPartsView: View {
    
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
