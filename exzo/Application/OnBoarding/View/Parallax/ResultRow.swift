//
//  ResultRow.swift
//  ParallaxScrolling_StickyHeader
//
//  Created by Difa N Pratama on 10/11/21.
//

import SwiftUI

struct ResultRow: View {
    var results: ResultInsights
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Image(results.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 43, height: 29)
                Text(results.title)
                Spacer()
            }
            Text(results.description)
        }.padding()
    }
}
