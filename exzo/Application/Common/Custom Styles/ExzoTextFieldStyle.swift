//
//  ExzoTextFieldStyle.swift
//  exzo
//
//  Created by Nicholas on 02/11/21.
//

import SwiftUI

//struct ExzoTextFieldStyle: TextFieldStyle {
//    private let width: CGFloat?
//    private let height: CGFloat?
//    
//    init(width: CGFloat? = nil, height: CGFloat? = 50) {
//        self.width = width
//        self.height = height
//    }
//    
//    func makeBody(configuration: <#T##Configuration#>) -> some View {
//        ExzoTextField()
//    }
//    
//    struct ExzoTextField: View {
//        let config: TextFieldStyle.Configuration
//        
//        var body: some View {
//            Text("Title")
//        }
//    }
//}

struct ExzoTextField: View {
    @Environment(\.colorScheme) var colorScheme
    
    // public initializer
    var title: String
    @Binding var textToEdit: String
    var style: ExzoTextFieldStyle
    var align: HorizontalAlignment
    var textAlign: TextAlignment
    
    init(_ title: String, input: Binding<String>, alignment: HorizontalAlignment = .leading, style: ExzoTextFieldStyle = .normalTextField) {
        self.title = title
        self._textToEdit = input
        self.align = alignment
        self.style = style
        switch alignment {
        case .leading:
            self.textAlign = .leading
        case .center:
            self.textAlign = .center
        case .trailing:
            self.textAlign = .trailing
        default:
            self.textAlign = .center
        }
    }
    
    enum ExzoTextFieldStyle {
        case normalTextField, emailTextField, pwdTextField
        
        func getKeyboardType() -> UIKeyboardType {
            switch self {
            case .normalTextField:
                return .default
            case .emailTextField:
                return .emailAddress
            case .pwdTextField:
                return .default
            }
        }
    }
    
    func bgColor() -> Color {
        switch colorScheme {
        case .light:
            return Color.white
        case .dark:
            return Color.black
        @unknown default:
            return Color.clear
        }
    }
    
    // private values
    @State private var pwdHidden: Bool = true
    @FocusState private var editing: Bool
    
    var body: some View {
        VStack(alignment: align, spacing: 5) {
            Text(title)
                .foregroundColor(editing ? .accentColor : .primary)
            ZStack(alignment: .center) {
                if editing {
                    Color.accentColor
                        .cornerRadius(10)
                        .shadow(color: .accentColor, radius: 3, x: 0, y: 0)
                    bgColor()
                        .cornerRadius(10)
                        .padding(1)
                } else {
                    bgColor()
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 3, x: 0, y: 0)
                }
                HStack {
                    if pwdHidden && self.style == .pwdTextField {
                        SecureField("", text: $textToEdit)
                            .focused($editing)
                            .keyboardType(style.getKeyboardType())
                            .multilineTextAlignment(textAlign)
                            .disableAutocorrection(true)
                    } else {
                        TextField("", text: $textToEdit)
                            .focused($editing)
                            .keyboardType(style.getKeyboardType())
                            .multilineTextAlignment(textAlign)
                            .disableAutocorrection(style == .emailTextField ? true : false)
                    }
                    if self.style == .pwdTextField {
                        Button {
                            editing = false
                            pwdHidden.toggle()
                        } label: {
                            Image(systemName: pwdHidden ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding(.horizontal, 14)
            }
            .frame(width: nil, height: 43)
        }
    }
}
