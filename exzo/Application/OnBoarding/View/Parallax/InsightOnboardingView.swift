//
//  InsightOnboardingView.swift
//  exzo
//
//  Created by Difa N Pratama on 05/11/21.
// Resource : [https://www.youtube.com/watch?v=6XcAXVG1hrs&t=567s]

import SwiftUI

struct InsightOnboardingView: View {
    let maxHeight = UIScreen.main.bounds.height / 2.3
    @State var show = false
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    
                    // Parallax Effect
                    GeometryReader{
                        reader -> AnyView in
                        // Anyview can be used to return Geometry Reader property
                        
                        //Checking if top scroll
                        let geoY = reader.frame(in: .global).minY + maxHeight
                        // Check the bottom to reach top
                        //                    print(y)
                        if geoY < 0 {
                            // Toggling sticky header
                            withAnimation(.linear) { show = true}
                        }
                        else {
                            withAnimation(.linear) { show = false}
                        }
                        
                        return AnyView(
                            ZStack(alignment: .leading) {
                                Image("bgHeader")
                                    .resizable()
                                    .frame(height: maxHeight)
                                //avoiding bottom scroll
                                    .offset(y: -reader.frame(in: .global).minY)
                                VStack(alignment: .leading) {
                                    Text("Your First Insight")
                                        .font(.title)
                                        .fontWeight(.bold)
                                    HStack {
                                        Image("dry3")
                                        Text("You have score of 30 which indicates that you have moderate eczema.")
                                    }
                                }.padding()
                            }
                        )
                    }
                    .frame(height: maxHeight)
                    
                    VStack(spacing: 0){
                        ForEach(dataInsight, id: \.title){
                            index in
                            ResultRow(results: index)
                        }
                        .padding(.horizontal)
                    }.background(Color.white)
                        .cornerRadius(20)
                        .offset(y: -50)
                    Button {
                        print("Finish")
                    } label: {
                        Text("Finish")
                    }.padding(.bottom, 100)
                    
                }
                
            }
            // Sticky Header
            HStack(spacing: 15) {
                Text("Your First Insight!")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .padding(.vertical)
                Spacer()
            }
            .padding([.horizontal, .bottom])
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            .background(
                Image("scroll_bgHeader")
                
            )
            .opacity(show ? 1 : 0 )
        }
        .ignoresSafeArea(.all, edges: .top)
    }
}

struct InsightOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        InsightOnboardingView()
    }
}
