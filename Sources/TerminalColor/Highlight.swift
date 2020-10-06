//
//  Highlight.swift
//  
//
//  Created by Justin Reusch on 10/4/20.
//

import Foundation

/// Highlights the given text in the requested terminal color, (defaulting to yellow).
/// - Parameter text: The content to highlight
/// - Parameter color: The terminal color to highlight with.
/// - Returns: An instance of `ColorTerminalText` to add to `String` output
public func highlight<Content: StringProtocol>(_ text: Content, with color: TerminalStyle = .yellow) -> ColorTerminalText { ColorTerminalText(text, color: color) }

// Convenience functions for each preset color
public func highlightYellow<Content: StringProtocol>(_ text: Content) -> ColorTerminalText { ColorTerminalText(text, color: .yellow) }
public func highlightRed<Content: StringProtocol>(_ text: Content) -> ColorTerminalText { ColorTerminalText(text, color: .red) }
public func highlightGreen<Content: StringProtocol>(_ text: Content) -> ColorTerminalText { ColorTerminalText(text, color: .green) }
public func highlightBlue<Content: StringProtocol>(_ text: Content) -> ColorTerminalText { ColorTerminalText(text, color: .blue) }
public func highlightWhite<Content: StringProtocol>(_ text: Content) -> ColorTerminalText { ColorTerminalText(text, color: .white) }
public func highlightBlack<Content: StringProtocol>(_ text: Content) -> ColorTerminalText { ColorTerminalText(text, color: .black) }
public func highlightPurple<Content: StringProtocol>(_ text: Content) -> ColorTerminalText { ColorTerminalText(text, color: .purple) }
public func highlightCyan<Content: StringProtocol>(_ text: Content) -> ColorTerminalText { ColorTerminalText(text, color: .cyan) }
public func highlightBrownOrange<Content: StringProtocol>(_ text: Content) -> ColorTerminalText { ColorTerminalText(text, color: .brownOrange) }
public func highlightLightGray<Content: StringProtocol>(_ text: Content) -> ColorTerminalText { ColorTerminalText(text, color: .lightGray) }
public func highlightDarkGray<Content: StringProtocol>(_ text: Content) -> ColorTerminalText { ColorTerminalText(text, color: .darkGray) }
public func highlightLightRed<Content: StringProtocol>(_ text: Content) -> ColorTerminalText { ColorTerminalText(text, color: .lightRed) }
public func highlightLightGreen<Content: StringProtocol>(_ text: Content) -> ColorTerminalText { ColorTerminalText(text, color: .lightGreen) }
public func highlightLightBlue<Content: StringProtocol>(_ text: Content) -> ColorTerminalText { ColorTerminalText(text, color: .lightBlue) }
public func highlightLightPurple<Content: StringProtocol>(_ text: Content) -> ColorTerminalText { ColorTerminalText(text, color: .lightPurple) }
public func highlightLightCyan<Content: StringProtocol>(_ text: Content) -> ColorTerminalText { ColorTerminalText(text, color: .lightCyan) }
