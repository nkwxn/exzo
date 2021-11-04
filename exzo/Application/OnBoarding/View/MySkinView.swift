//
//  MySkinView.swift
//  exzo
//
//  Created by Difa N Pratama on 04/11/21.
//

import SwiftUI

struct MySkinView: View {
    var body: some View {
        VStack {
            HStack {
                Text("13.00")
                Spacer()
                Text("See details")
                    .underline()
            }
            Divider()
            VStack(alignment: .leading) {
                Text("Food Intake")
                HStack {
                    ForEach((1...5), id: \.self){
                        index in
                        if index > 1 {
                            Circle()
                                .fill(Color.brandy)
                                .frame(width: 32, height: 32, alignment: .leading)
                                .offset(x: CGFloat((-20 * index)))
                        }
                        else {
                            Circle()
                                .frame(width: 32, height: 32, alignment: .leading)
                                .opacity(0)
                        }
                        
                    }
                }
            }
        }
        
    }
}

struct MySkinView_Previews: PreviewProvider {
    static var previews: some View {
        MySkinView()
    }
}
