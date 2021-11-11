//
//  CategoryGrid.swift
//  exzo
//
//  Created by Nicholas on 05/11/21.
//

import SwiftUI

struct CategoryItem: Identifiable {
    var id = UUID()
    var iconName: String
    var name: String
    var selected: Bool
}

struct CategoryGrid: View {
    // Variables
    @Binding var grid: [CategoryItem]
    var gridColor: Color
    
    init(_ gridItems: Binding<[CategoryItem]>, color: Color) {
        self._grid = gridItems
        self.gridColor = color
    }
    
    // Grid View Property
    var gridItems: [GridItem] = Array(
        repeating: GridItem(.flexible()), count: 5
    )
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 20) {
            ForEach(Array(grid.enumerated()), id: \.0) { idx, _ in
                CategoryGridItem(category: $grid[idx], accent: gridColor)
                    .aspectRatio(0.7, contentMode: .fit)
            }
        }
    }
}

struct CategoryGridItem: View {
    @Binding var category: CategoryItem
    var accent: Color
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Image(category.iconName)
                .resizable()
                .foregroundColor(self.category.selected ? Color.white : accent)
                .background {
                    Circle()
                        .strokeBorder(accent, lineWidth: 2)
                        .foregroundColor(Color.clear)
                        .background(Circle().fill(self.category.selected ? accent : Color.clear))
                }
            Text(category.name)
        }
        .onTapGesture {
            self.category.selected.toggle()
        }
        .buttonStyle(PlainButtonStyle())
    }
}
