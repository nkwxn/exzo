////
////  ProgressView.swift
////  PageMechanism
////
////  Created by Difa N Pratama on 04/11/21.
////
/// ProgressBar(Youtube [here](https://www.youtube.com/watch?v=Agjk9v1zNQk)

import SwiftUI

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressView(percent: .constant(0.2))
    }
}

// MARK: - Custom Progress Bar

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
