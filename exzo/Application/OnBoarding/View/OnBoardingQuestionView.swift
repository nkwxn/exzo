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
    @State var bodyScore: Float = 0
    @State var bodyArr = [String]()
    @State var isFinish: Bool = false
    @State var poScore: Int = 8
    let userDefault = UserDefaults.standard
    
    var body: some View {
        
        VStack(alignment: .leading) {
            if isFinish {
                NavigationLink(destination: InsightOnboardingView(), isActive: $isFinish) {
                    EmptyView()
                }
            }
            Button {
                if currentPage > 0 {
                    currentPage -= 1
                    self.percent -= 0.11
                    self.step += 1
                }
            } label: {
                Image(systemName: "chevron.left")
                Text("Back")
            }.padding()
            
            VStack {
                Text("\(self.step) questions left")
                    .scaledFont(name: "Avenir", size: 12)
                CustomProgressView(percent: self.$percent)
                    .padding(.horizontal)
                Text("Not affected by eczema")
                    .scaledFont(name: "Avenir", size: 12)
                Text("BodyScore : \(bodyScore), BodyIntense: \(dryNess + red + swell + crust + scratch + thicken), BodyItch: \(itch + sleep)")
            }
            
            ZStack {
                if currentPage == 1 {
                    QuestionPageView(score: $dryNess, index: $currentPage, bodyScore: $bodyScore, bodyArr: $bodyArr)
                } else if currentPage == 2 {
                    QuestionPageView(score: $red, index: $currentPage, bodyScore: $bodyScore, bodyArr: $bodyArr)
                } else if currentPage == 3 {
                    QuestionPageView(score: $swell, index: $currentPage, bodyScore: $bodyScore, bodyArr: $bodyArr)
                } else if currentPage == 4 {
                    QuestionPageView(score: $crust, index: $currentPage, bodyScore: $bodyScore, bodyArr: $bodyArr)
                } else if currentPage == 5 {
                    QuestionPageView(score: $scratch, index: $currentPage, bodyScore: $bodyScore, bodyArr: $bodyArr)
                } else if currentPage == 6 {
                    QuestionPageView(score: $thicken, index: $currentPage, bodyScore: $bodyScore, bodyArr: $bodyArr)
                } else if currentPage == 7 {
                    QuestionPageView(score: $itch, index: $currentPage, bodyScore: $bodyScore, bodyArr: $bodyArr)
                } else if currentPage == 8 {
                    QuestionPageView(score: $sleep, index: $currentPage, bodyScore: $bodyScore, bodyArr: $bodyArr)
                } else {
                    QuestionPageView(score: $sleep, index: $currentPage, bodyScore: $bodyScore, bodyArr: $bodyArr)
                }
                
            }
            if currentPage > 0 {
                Spacer()
            }
            PageControl(current: currentPage)
            
            HStack {
                Button {
                    //                    withAnimation {
                    if currentPage < 9 {
                        currentPage += 1
                        self.percent += 0.11
                        self.step -= 1
                    }
                    if currentPage >= 9 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            let surface = Float(bodyScore/103)
                            let intense = Float((dryNess + red + swell + crust + scratch + thicken) / 18)
                            let symptom = Float((itch + sleep) / 20)
                            let total = Float((surface / 5) + ((7 * intense) / 2) + symptom)
                            self.poScore = Int(total / 100)
                            userDefault.set(bodyArr, forKey: "bodyArray")
                            userDefault.set(poScore, forKey: "poScore")
                        }
                        self.isFinish = true
                    }
                    //                    }
                } label: {
                    Spacer()
                    Text(currentPage >= 8 ? "Finish" : "Next")
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                }
                .disabled(bodyScore != 0 ? false :true)
                .background(bodyScore != 0 ? Color.brandy : Color.gray)
            }
            .cornerRadius(10)
            .padding()
            
        }
        .navigationBarHidden(true)
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
