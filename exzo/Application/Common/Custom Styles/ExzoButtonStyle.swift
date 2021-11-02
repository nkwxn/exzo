//
//  ExzoButtonStyle.swift
//  exzo
//
//  Created by Nicholas on 02/11/21.
//

import SwiftUI

struct ExzoButtonStyle: ButtonStyle {
    private let width: CGFloat?
    private let height: CGFloat?
    private let type: CustomButtonType
    
    init(type: CustomButtonType, width: CGFloat? = nil, height: CGFloat? = 50) {
        self.width = width
        self.height = height
        self.type = type
    }
    
    func makeBody(configuration: Configuration) -> some View {
        ExzoButton(type: type, configuration: configuration)
            .frame(width: width, height: height, alignment: .center)
    }
    
    enum CustomButtonType {
        case primary
        case secondary
        
        func getBgColor(enabled: Bool, scheme: ColorScheme) -> Color {
            switch self {
            case .primary:
                if enabled {
                    if scheme == .light {
                        return Color("accent_brandy")
                    } else {
                        return Color("accent_brandy")
                    }
                } else {
                    return Color("disabled")
                }
            case .secondary:
                if scheme == .light {
                    return Color.white
                } else {
                    return Color.black
                }
            }
        }
        
        func getBorderColor(enabled: Bool, scheme: ColorScheme) -> Color {
            if enabled {
                if scheme == .light {
                    return Color("accent_copper")
                } else {
                    return Color("accent_copper")
                }
            } else {
                return Color("disabled")
            }
        }
        
        func getLabelColor(enabled: Bool, scheme: ColorScheme) -> Color {
            switch self {
            case .primary:
                if enabled {
                    return Color.white
                } else {
                    return Color.white
                }
            case .secondary:
                if enabled {
                    return Color("accent_copper")
                } else {
                    return Color("disabled")
                }
            }
        }
    }
    
    struct ExzoButton: View {
        let type: CustomButtonType
        let configuration: ButtonStyle.Configuration
        
        @Environment(\.isEnabled) private var isEnabled
        @Environment(\.colorScheme) private var colorScheme
        
        var backgroundColor: Color {
            return type.getBgColor(enabled: isEnabled, scheme: colorScheme)
        }
        
        var borderColor: Color {
            return type.getBorderColor(enabled: isEnabled, scheme: colorScheme)
        }
        
        var labelColor: Color {
            return type.getLabelColor(enabled: isEnabled, scheme: colorScheme)
        }
        
        var body: some View {
            ZStack {
                switch type {
                case .primary:
                    backgroundColor
                        .cornerRadius(10)
                case .secondary:
                    borderColor
                        .cornerRadius(10)
                    backgroundColor
                        .cornerRadius(8)
                        .padding(2)
                }
                configuration.label
                    .foregroundColor(labelColor)
            }
        }
    }
}
