//
//  PageControlView.swift
//  exzo
//
//  Created by Difa N Pratama on 04/11/21.
// Resource : https://www.youtube.com/watch?v=nSx1VVfEsHU

import SwiftUI

struct PageControlView: View {
    //MARK: - slider value
    @State var dry: Int = 2
    @State var red: Int = 2
    @State var swell: Int = 2
    @State var crust: Int = 2
    @State var scratch: Int = 2
    @State var thicken: Int = 2
    @State var itch: Int = 2
    @State var sleep: Int = 2
    
    @State var percent: CGFloat = 0
    @State var step = 9
    @State var currentPage = 0
    var body: some View {
        VStack {
            VStack {
                Text("\(self.step) questions left")
                    .scaledFont(name: "Avenir", size: 12)
                CustomProgressView(percent: self.$percent)
                    .padding(.horizontal)
                Text("Not affected by eczema")
                    .scaledFont(name: "Avenir", size: 12)
            }
            ZStack {
                QuestionPageView(score: $dry, index: $currentPage)
            }
            PageControl(current: currentPage)
            HStack {
                Button {
//                    withAnimation {
                        if currentPage < 7 {
                            currentPage += 1
                            self.percent += 0.11
                            self.step -= 1
                        }
//                    }
                } label: {
                    Spacer()
                    Text("Next")
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                }
                .background(Color.brandy)
            }
            .cornerRadius(10)
            .padding()
            
        }
        
    }
}

struct PageControlView_Previews: PreviewProvider {
    static var previews: some View {
        PageControlView()
    }
}

struct PageControl : UIViewRepresentable {
    
    var current = 0
    
    func makeUIView(context: UIViewRepresentableContext<PageControl>) -> UIPageControl {
        let page = UIPageControl()
        page.currentPageIndicatorTintColor = .clear
        page.numberOfPages = 8
        page.pageIndicatorTintColor = .clear
        return page
    }
    
    func updateUIView(_ uiView: PageControl.UIViewType, context: UIViewRepresentableContext<PageControl>) {
        uiView.currentPage = current
    }
}
