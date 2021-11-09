//
//  PageControlView.swift
//  exzo
//
//  Created by Difa N Pratama on 04/11/21.
// Resource : https://www.youtube.com/watch?v=nSx1VVfEsHU

import SwiftUI

struct PageControlView: View {
    //MARK: - slider value
    @AppStorage("dryness") var dryNess: Int = 2
    @AppStorage("redNess") var red: Int = 2
    @AppStorage("swell") var swell: Int = 2
    @AppStorage("crust") var crust: Int = 2
    @AppStorage("scratch") var scratch: Int = 2
    @AppStorage("thicken") var thicken: Int = 2
    @AppStorage("itch") var itch: Int = 2
    @AppStorage("sleep") var sleep: Int = 2
    
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
                if currentPage == 1 {
                    QuestionPageView(score: $dryNess, index: $currentPage)
                } else if currentPage == 2 {
                    QuestionPageView(score: $red, index: $currentPage)
                } else if currentPage == 3 {
                    QuestionPageView(score: $swell, index: $currentPage)
                } else if currentPage == 4 {
                    QuestionPageView(score: $crust, index: $currentPage)
                } else if currentPage == 5 {
                    QuestionPageView(score: $scratch, index: $currentPage)
                } else if currentPage == 6 {
                    QuestionPageView(score: $thicken, index: $currentPage)
                } else if currentPage == 7 {
                    QuestionPageView(score: $itch, index: $currentPage)
                } else if currentPage == 8 {
                    QuestionPageView(score: $sleep, index: $currentPage)
                } else {
                    QuestionPageView(score: $sleep, index: $currentPage)
                }
                
            }
            
            PageControl(current: currentPage)
            
            HStack {
                Button {
//                    withAnimation {
                        if currentPage < 8 {
                            currentPage += 1
                            self.percent += 0.11
                            self.step -= 1
                        }
                    if currentPage >= 8 {
                        print("Navigate to Insight")
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

struct PageControl: UIViewRepresentable {
    
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
