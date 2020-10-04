//
//  TerminalColor.swift
//
//
//  Created by Justin Reusch on 10/4/20.
//

import Foundation

/// Stores a custom color for terminal fonts.
/// This creates the escape command to change terminal
/// font color.
public struct TerminalColor {
    var escapeCode: (Int, Int)?
    
    /// Init with an escape code tuple. Default (`nil`) creates a "no color" command.
    public init(escapeCode: (Int, Int)? = nil) {
        self.escapeCode = escapeCode
    }
    
    /// Init with individual escape codes.
    public init(_ first: Int, _ second: Int) {
        self.escapeCode = (first, second)
    }
    
    /// This formats the ANSI escape code string that switches the terminal color.
    public var command: String {
        let code = escapeCode.map { "\($0.0);\($0.1)" } ?? "\(0)"
        return "\u{001B}[\(code)m"
    }
    
    /// Wraps given text with an ANSI escape code command to start the custom color at the beginning and ends
    /// the string with a no-color command.
    public func wrap<Content: StringProtocol>(_ content: Content) -> String { "\(self)\(content)\(Self.noColor)" }
}

extension TerminalColor: CustomStringConvertible {
    
    /// String representation of terminal command code.
    public var description: String { command }
}

extension TerminalColor: Equatable {
    
    public static func == (lhs: TerminalColor, rhs: TerminalColor) -> Bool {
        lhs.escapeCode?.0 == rhs.escapeCode?.0 && lhs.escapeCode?.1 == rhs.escapeCode?.1
    }
}

extension TerminalColor {
    
    // Preset colors ---------------------------------------- /
    
    public static let noColor: Self = Self()
    public static let black: Self = Self(escapeCode: (0, 30))
    public static let red: Self = Self(escapeCode: (0, 31))
    public static let green: Self = Self(escapeCode: (0, 32))
    public static let brownOrange: Self = Self(escapeCode: (0, 33))
    public static let blue: Self = Self(escapeCode: (0, 34))
    public static let purple: Self = Self(escapeCode: (0, 35))
    public static let cyan: Self = Self(escapeCode: (0, 36))
    public static let lightGray: Self = Self(escapeCode: (0, 37))
    public static let darkGray: Self = Self(escapeCode: (1, 30))
    public static let lightRed: Self = Self(escapeCode: (1, 31))
    public static let lightGreen: Self = Self(escapeCode: (1, 32))
    public static let yellow: Self = Self(escapeCode: (1, 33))
    public static let lightBlue: Self = Self(escapeCode: (1, 34))
    public static let lightPurple: Self = Self(escapeCode: (1, 35))
    public static let lightCyan: Self = Self(escapeCode: (1, 36))
    public static let white: Self = Self(escapeCode: (1, 37))
}

// Reference ------------------------------------------------------------------------------------------------ /

// Source: https://stackoverflow.com/a/5947802/3055803

// ANSI Escape Codes:
// ---------------------------------------- /
// Black        0;30     Dark Gray     1;30
// Red          0;31     Light Red     1;31
// Green        0;32     Light Green   1;32
// Brown/Orange 0;33     Yellow        1;33
// Blue         0;34     Light Blue    1;34
// Purple       0;35     Light Purple  1;35
// Cyan         0;36     Light Cyan    1;36
// Light Gray   0;37     White         1;37

// ---------------------------------------- /
// RED='\033[0;31m'
// NC='\033[0m' # No Color
// printf "I ${RED}love${NC} Stack Overflow\n"

// Source: https://stackoverflow.com/q/40583721/3055803

// let redColor = "\u{001B}[0;31m"
// let message = "Some Message"
// print(redColor + message)
// print("\(redColor)\(message)")
