//
//  ExzoSlider.swift
//  exzo
//
//  Created by Nicholas on 06/11/21.
//

import SwiftUI

struct ExzoSlider: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var title: String? = nil
    @Binding var value: Double
    var range: ClosedRange<Double>
    
    var body: some View {
        VStack(alignment: .leading) {
            if let title = title {
                Text(title)
            }
            Slider(value: $value, in: range, step: 1.0) {
                Text("Stress Level")
            } minimumValueLabel: {
                Text("\(Int(range.lowerBound))")
            } maximumValueLabel: {
                Text("\(Int(range.upperBound))")
            }
            .padding(.horizontal)
            .padding(.vertical, 7)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(colorScheme == .light ? Color.antique : Color.brandy)
            }
        }
    }
}
