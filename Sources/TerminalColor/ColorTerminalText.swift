//
//  ColorTerminalText.swift
//  
//
//  Created by Justin Reusch on 10/4/20.
//

import Foundation

/// Holds and displays text that will print with the specified color in a terminal.
public struct ColorTerminalText {
    public var text: String {
        didSet { updateOutput() }
    }
    public var color: TerminalStyle {
        didSet { updateOutput() }
    }
    
    /// The generated output string for terminal
    public private(set) var output: String!
    
    public init<Content: StringProtocol>(_ text: Content, color: TerminalStyle = .noColor) {
        self.output = nil
        self.text = String(text)
        self.color = color
        self.updateOutput()
    }
    
    /// Generates the output
    private mutating func updateOutput() {
        self.output = self.color.wrap(self.text)
    }
}

extension ColorTerminalText: CustomStringConvertible {
    
    /// String representation of terminal command code.
    public var description: String { self.output }
}

extension ColorTerminalText: Equatable {
    
    public static func == (lhs: ColorTerminalText, rhs: ColorTerminalText) -> Bool {
        lhs.text == rhs.text && lhs.color == rhs.color
    }
}
