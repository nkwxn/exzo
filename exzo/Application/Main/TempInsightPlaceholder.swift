//
//  TempInsightPlaceholder.swift
//  exzo
//
//  Created by Nicholas on 15/11/21.
//

import SwiftUI

struct TempInsightPlaceholder: View {
    var body: some View {
        ZStack {
            Image("Header")
                .resizable(resizingMode: .tile)
                .ignoresSafeArea(edges: .top)
                .ignoresSafeArea(edges: .horizontal)
            VStack {
                Text("Insight not available")
                    .font(Lexend(.title).getFont().weight(.bold))
                Text("Insights will be available a week after appending journal entries for a week.")
            }
            .multilineTextAlignment(.center)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 19)
                    .foregroundColor(Color.white)
                    .frame(width: 309, alignment: .center)
                    .shadow(color: Color.init(uiColor: UIColor.init(red: 0.45, green: 0.29, blue: 0.22, alpha: 0.2)), radius: 10, x: 2, y: 5)
            }
            .padding()
        }
    }
}

struct TempInsightPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        TempInsightPlaceholder()
    }
}
