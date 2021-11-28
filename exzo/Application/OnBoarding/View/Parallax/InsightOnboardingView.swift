//
//  InsightOnboardingView.swift
//  exzo
//
//  Created by Difa N Pratama on 05/11/21.
// Resource : [https://www.youtube.com/watch?v=6XcAXVG1hrs&t=567s]

import SwiftUI

// swiftlint:disable all
struct InsightOnboardingView: View {
    let maxHeight = UIScreen.main.bounds.height / 2.3
    @State var show = false
    let userDefault = UserDefaults.standard
    @State var isFinish: Bool = false
    var poScore: Int {
        return userDefault.integer(forKey: "poScore")
    }
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
                                        ZStack {
                                            Rectangle()
                                                .frame(width: 144, height: 168)
                                                .foregroundColor(.white)
                                                .cornerRadius(10)
                                            Image("ResultOnboarding\(0)")
                                        }
                                        Text("You have score of \(0) which indicates that you have moderate eczema.")
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
                Color.red
            )
            .opacity(show ? 1 : 0 )
        }
        .background(
//            NavigationLink(destination: , isActive: $isFinish) {
//                EmptyView()
//            }
        )
        .ignoresSafeArea(.all, edges: .top)
    }
}

struct InsightOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        InsightOnboardingView()
    }
}
