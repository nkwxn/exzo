//
//  QuestionPageView.swift
//  exzo
//
//  Created by Difa N Pratama on 05/11/21.
//
/*
 Resource StackOverFlow https://stackoverflow.com/questions/65736518/how-do-i-create-a-slider-in-swiftui-for-an-int-type-property
 */

import SwiftUI

struct QuestionPageView: View {
    @Binding var score: Int
    @Binding var index: Int
    @Binding var bodyScore: Float
    @Binding var bodyArr: [String]
    var intProxy: Binding<Double>{
        Binding<Double>(get: {
            //returns the score as a Double
            return Double(score)
        }, set: {
            // Rounds the double to an Int
            print($0.description)
            score = Int($0)
        })
    }
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("\(dataQuestions[index].title)")
                    .font(.title)
                    .fontWeight(.bold)
                Text("\(dataQuestions[index].description)")
            }
            VStack(alignment: .center) {
                Spacer()
                    .frame(height: 70)
                if index < 7 {
                    Image("\(dataQuestions[index].image)\(score)")
                        .frame(height: 120)
                    Text("\(dataQuestions[index].image)")
                } else {
                    Image("\(dataQuestions[index].image)")
                        .frame(height: 120)
                }
                Spacer()
                    .frame(height: 70)
                if index == 0 {
                    BodyPartsView(score: $bodyScore, bodyArr: $bodyArr)
                        .position(x: (UIScreen.main.bounds.width / 2.5), y: (UIScreen.main.bounds.height / 5) * -2.2)
                } else {
                   
                    Slider(value: intProxy, in: (index < 7 ? 0.0...3.0 : 0.0...10.0), step: 1.0, onEditingChanged: { _ in
                        print(score.description)
                    })
                        .tint(Color.brandy)
                    Text(score.description)
                }
                
            }
            
        }.padding()
    }
}

//struct QuestionPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionPageView(score: Binding.constant(0), index: Binding.constant(0), bodyScore: Binding.constant(0))
//    }
//}
