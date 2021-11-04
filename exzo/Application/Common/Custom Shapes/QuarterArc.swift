//
//  QuarterArc.swift
//  exzo
//
//  Created by Nicholas on 02/11/21.
//

import SwiftUI

struct QuarterArc: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * 0.65))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.minY * 0.3),
                radius: rect.height * 0.87,
                startAngle: Angle(degrees: 50),
                endAngle: Angle(degrees: 130),
                clockwise: false
            )
            path.addLine(to: CGPoint(x: rect.minY, y: rect.maxY * 0.65))
        }
    }
}
