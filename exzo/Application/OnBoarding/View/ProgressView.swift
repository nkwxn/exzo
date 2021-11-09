//
//  ProgressView.swift
//  PageMechanism
//
//  Created by Difa N Pratama on 04/11/21.
//
/// ProgressBar(Youtube [here](https://www.youtube.com/watch?v=Agjk9v1zNQk)

import SwiftUI

//struct ProgressView: View {
//    @State var percent: CGFloat = 0
//    @State var step = 0
//    var body: some View {
//        VStack {
//            Text("\(self.step) questions left")
//            CustomProgressView(percent: self.$percent)
//        }
//        .padding()
//        .onTapGesture {
//            withAnimation{
//                if self.percent < 0.9 {
//                    self.percent += 0.11
//                    self.step += 1
//                }
//            }
//        }
//        
//    }
//}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}

//MARK: - Custom Progress Bar

struct CustomProgressView: View{
    @Binding var  percent: CGFloat
    
    var body: some View {
        ZStack(alignment: .leading) {
            ZStack(alignment: .trailing) {
                Capsule().fill(Color.antique)
                    .frame(height: 20)
            }
            Capsule().fill(Color.copper)
                .frame(width: self.calPercent(), height: 20)
        }
        
//        .background(Color.black.opacity(0.085))
        .cornerRadius(15)
    }
    func calPercent() -> CGFloat {
        let width = UIScreen.main.bounds.width - 66
        return width * self.percent
    }
}
