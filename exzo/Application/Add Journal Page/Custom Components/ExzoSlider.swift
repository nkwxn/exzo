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
    @Binding var value: Double {
        didSet {
            HFHelper.selectionChanged()
        }
    }
    var range: ClosedRange<Double>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if let title = title {
                Text("\(title): \(Int(value))")
                    .font(Avenir.shared.getFont().bold())
            }
            Slider(value: $value, in: range, step: 1.0) {
                
            } minimumValueLabel: {
                Text("\(Int(range.lowerBound))")
                    .font(Avenir.shared.getFont().bold())
            } maximumValueLabel: {
                Text("\(Int(range.upperBound))")
                    .font(Avenir.shared.getFont().bold())
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
