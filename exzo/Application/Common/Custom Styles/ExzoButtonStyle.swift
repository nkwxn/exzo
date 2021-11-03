//
//  ExzoButtonStyle.swift
//  exzo
//
//  Created by Nicholas on 02/11/21.
//

import SwiftUI

struct ExzoButtonStyle: PrimitiveButtonStyle {
    private let width: CGFloat?
    private let height: CGFloat?
    private let type: CustomButtonType
    
    init(type: CustomButtonType, width: CGFloat? = nil, height: CGFloat? = 50) {
        self.width = width
        self.height = height
        self.type = type
    }
    
    func makeBody(configuration: Configuration) -> some View {
        switch type {
        case .smallIconPrimary:
            ExzoSmallButton(type: type, configuration: configuration)
                .frame(width: 35, height: 35, alignment: .center)
        default:
            ExzoButton(type: type, configuration: configuration)
                .frame(width: width, height: height, alignment: .center)
        }
    }
    
    enum CustomButtonType {
        case primary
        case secondary
        case smallIconPrimary
        
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
            case .smallIconPrimary:
                if enabled {
                    return Color("accent_brandy")
                } else {
                    return Color("disabled")
                }
            }
        }
        
        func getBorderColor(enabled: Bool, scheme: ColorScheme) -> Color {
            if enabled {
                switch self {
                case .smallIconPrimary:
                    return Color("accent_copper")
                default:
                    if scheme == .light {
                        return Color("accent_copper")
                    } else {
                        return Color("accent_copper")
                    }
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
            case .smallIconPrimary:
                return Color.white
            }
        }
    }
    
    struct ExzoSmallButton: View {
        @GestureState private var pressed = false
        
        let type: CustomButtonType
        let configuration: PrimitiveButtonStyle.Configuration
        
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
            let tapGesture = LongPressGesture(minimumDuration: 300)
                .updating($pressed) { value, state, transaction in
                    state = value
                    DispatchQueue.main.async {
                        self.configuration.trigger()
                    }
                }
            
            return ZStack {
                backgroundColor
                    .cornerRadius(20)
                HStack {
                    configuration.label
                }
                .foregroundColor(labelColor)
            }
            .opacity(pressed ? 0.5 : 1.0)
            .gesture(tapGesture)
        }
    }
    
    struct ExzoButton: View {
        @GestureState private var pressed = false
        
        let type: CustomButtonType
        let configuration: PrimitiveButtonStyle.Configuration
        
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
            let tapGesture = LongPressGesture(minimumDuration: 300)
                .updating($pressed) { value, state, transaction in
                    state = value
                    DispatchQueue.main.async {
                        self.configuration.trigger()
                    }
                }
            
            return ZStack {
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
                default:
                    backgroundColor
                        .cornerRadius(10)
                }
                HStack {
                    configuration.label
                }
                .foregroundColor(labelColor)
            }
            .opacity(pressed ? 0.5 : 1.0)
            .gesture(tapGesture)
        }
    }
}
