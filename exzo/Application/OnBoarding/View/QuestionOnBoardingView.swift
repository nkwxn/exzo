//
//  QuestionOnBoardingView.swift
//  exzo
//
//  Created by Difa N Pratama on 03/11/21.
//

import SwiftUI

struct QuestionOnBoardingView: View {
    @State private var tabSelection = 1
        
        var body: some View {
            TabView(selection: $tabSelection) {
                FirstView(tabSelection: $tabSelection)
                    .tabItem {
                        Text("Tab 1")
                    }
                    .tag(1)
                Text("tab 2")
                    .tabItem {
                        Text("Tab 2")
                    }
                    .tag(2)
            }
        }
}

struct QuestionOnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionOnBoardingView()
    }
}

struct FirstView: View {
    @Binding var tabSelection: Int
    var body: some View {
        Button(action: {
            self.tabSelection = 2
        }) {
            Text("Change to tab 2")
        }
    }
}
