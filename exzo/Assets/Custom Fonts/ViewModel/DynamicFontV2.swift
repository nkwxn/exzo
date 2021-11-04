//
//  DynamicFontV2.swift
//  exzo
//
//  Created by Difa N Pratama on 04/11/21.
//

import SwiftUI

// swiftlint:disable all
struct Avenir: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var textStyle: Font.TextStyle

    init(_ textStyle: Font.TextStyle = .body) {
        self.textStyle = textStyle
    }

    static let shared = Avenir()
    
    func body(content: Content) -> some View {
        content.font(getFont())
    }
    
    func getFont() -> Font {
        switch(sizeCategory) {
        case .extraSmall:
            return Font.custom("Avenir", size: 14 * getStyleFactor())
        case .small:
            return Font.custom("Avenir", size: 15 * getStyleFactor())
        case .medium:
            return Font.custom("Avenir", size: 16 * getStyleFactor())
        case .large:
            return Font.custom("Avenir", size: 17 * getStyleFactor())
        case .extraLarge:
            return Font.custom("Avenir", size: 19 * getStyleFactor())
        case .extraExtraLarge:
            return Font.custom("Avenir", size: 21 * getStyleFactor())
        case .extraExtraExtraLarge:
            return Font.custom("Avenir", size: 23 * getStyleFactor())
        case .accessibilityMedium:
            return Font.custom("Avenir", size: 28 * getStyleFactor())
        case .accessibilityLarge:
            return Font.custom("Avenir", size: 33 * getStyleFactor())
        case .accessibilityExtraLarge:
            return Font.custom("Avenir", size: 40 * getStyleFactor())
        case .accessibilityExtraExtraLarge:
            return Font.custom("Avenir", size: 47 * getStyleFactor())
        case .accessibilityExtraExtraExtraLarge:
            return Font.custom("Avenir", size: 53 * getStyleFactor())
        @unknown default:
            return Font.custom("Avenir", size: 17 * getStyleFactor())
        }
    }

    func getStyleFactor() -> CGFloat {
        switch textStyle {
        case .caption:
            return 0.6
        case .footnote:
            return 0.7
        case .subheadline:
            return 0.8
        case .callout:
            return 0.9
        case .body:
            return 1.0
        case .headline:
            return 1.2
        case .title:
            return 1.5
        case .largeTitle:
            return 2.0
        @unknown default:
            return 1.0
        }
    }

}

struct Lexend: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var textStyle: Font.TextStyle

    init(_ textStyle: Font.TextStyle = .body) {
        self.textStyle = textStyle
    }
    
    static let shared = Lexend()

    func body(content: Content) -> some View {
        content.font(getFont())
    }

    func getFont() -> Font {
        switch(sizeCategory) {
        case .extraSmall:
            return Font.custom("Lexend", size: 14 * getStyleFactor())
        case .small:
            return Font.custom("Lexend", size: 15 * getStyleFactor())
        case .medium:
            return Font.custom("Lexend", size: 16 * getStyleFactor())
        case .large:
            return Font.custom("Lexend", size: 17 * getStyleFactor())
        case .extraLarge:
            return Font.custom("Lexend", size: 19 * getStyleFactor())
        case .extraExtraLarge:
            return Font.custom("Lexend", size: 21 * getStyleFactor())
        case .extraExtraExtraLarge:
            return Font.custom("Lexend", size: 23 * getStyleFactor())
        case .accessibilityMedium:
            return Font.custom("Lexend", size: 28 * getStyleFactor())
        case .accessibilityLarge:
            return Font.custom("Lexend", size: 33 * getStyleFactor())
        case .accessibilityExtraLarge:
            return Font.custom("Lexend", size: 40 * getStyleFactor())
        case .accessibilityExtraExtraLarge:
            return Font.custom("Lexend", size: 47 * getStyleFactor())
        case .accessibilityExtraExtraExtraLarge:
            return Font.custom("Lexend", size: 53 * getStyleFactor())
        @unknown default:
            return Font.custom("Lexend", size: 17 * getStyleFactor())
        }
    }

    func getStyleFactor() -> CGFloat {
        switch textStyle {
        case .caption:
            return 0.6
        case .footnote:
            return 0.7
        case .subheadline:
            return 0.8
        case .callout:
            return 0.9
        case .body:
            return 1.0
        case .headline:
            return 1.2
        case .title:
            return 1.5
        case .largeTitle:
            return 2.0
        @unknown default:
            return 1.0
        }
    }

}

