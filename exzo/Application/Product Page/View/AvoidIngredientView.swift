//
//  AvoidIngredientView.swift
//  exzo
//
//  Created by Difa N Pratama on 02/02/22.
//

import SwiftUI

struct Ingredient: Identifiable {
    let id: String = UUID().uuidString
    let desc: String
    let subtask: DetailIngredient
}

struct DetailIngredient: Identifiable {
    let id: String = UUID().uuidString
    let desc: String
    let height: Float
}

struct DetailIngredientCell: View {
    let task: DetailIngredient
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "viewfinder")
                Text(task.desc)
                    .padding(.trailing, 25)
            }
            .frame( height: CGFloat(task.height * 1.5))
        }
        
    }
}

struct IngredientCell: View {
    @State private var isExpanded: Bool = false
    
    let task: Ingredient
    
    var body: some View {
        content
            .padding(.leading)
            .frame(maxWidth: 400)
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 5) {
            if !isExpanded{
                header
                    .animation(.default)
                    .cornerRadius(10, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
            } else {
                header
                    .animation(.default)
                    .cornerRadius(10, corners: [.topLeft, .topRight])
            }
            if isExpanded {
                DetailIngredientCell(task: task.subtask)
                    .padding(.leading)
            }
            Divider()
        }
    }
    
    private var header: some View {
        HStack {
            Text(task.desc)
            Spacer()
            Image(systemName: "chevron.down")
                .foregroundColor(Color.primary.opacity(0.2))
            Spacer()
                .frame(width:20)
        }
        .contentShape(Rectangle())
        .padding(.vertical, 4)
        .background(Color("accent_copper"))
        .onTapGesture {
            withAnimation { isExpanded.toggle() }
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

