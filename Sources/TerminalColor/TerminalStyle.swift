//
//  TerminalColor.swift
//
//
//  Created by Justin Reusch on 10/4/20.
//

import Foundation

public protocol Coded {
    var code: UInt8 { get }
}

/// Stores a custom color for terminal fonts.
/// This creates the escape command to change terminal
/// font color.
/// [ANSI Escape Codes](https://en.wikipedia.org/wiki/ANSI_escape_code)
public struct TerminalStyle {
    public private(set) var codes: [UInt8]? = nil
    
    public private(set) var command: String
    
    public var styles: [SGR]? {
        guard let codes = codes else { return nil }
        return codes.map { SGR.from(code: $0) }
    }
    
    public var foreground: ForegroundColor? {
        guard let codes = codes else { return nil }
        for code in codes {
            if let foreground = ForegroundColor.from(code: code) {
                return foreground as ForegroundColor
            }
        }
        return nil
    }
    
    public var background: BackgroundColor? {
        guard let codes = codes else { return nil }
        for code in codes {
            if let background = BackgroundColor.from(code: code) {
                return background as BackgroundColor
            }
        }
        return nil
    }
    
    // Init ------------------------------------------------------------------------------ /
    
    /// Init with individual escape codes.
    public init(codes: [UInt8]) {
        self.codes = codes.isEmpty ? nil : codes
        self.command = Self.makeCommand(codes: codes)
    }
    
    /// Init with individual escape codes.
    public init(
        styles: [SGR]? = nil,
        foreground: ForegroundColor? = nil,
        background: BackgroundColor? = nil
    ) {
        var codes: [UInt8] = []
        if let foreground = foreground {
            codes.append(foreground.code)
        }
        if let background = background {
            codes.append(background.code)
        }
        if let styles = styles {
            styles.forEach { codes.append($0.code) }
        }
        self.codes = codes.isEmpty ? nil : codes
        self.command = Self.makeCommand(codes: codes)
    }
    
    // Instance methods ------------------------------------------------------------------------------ /
    
    /// Wraps given text with an ANSI escape code command to start the custom color at the beginning and ends
    /// the string with a no-color command.
    public func wrap<Content: StringProtocol>(_ content: Content) -> String { "\(command)\(content)\(Self.noColor)" }
    
    /// This formats the ANSI escape code string that switches the terminal color.
    private static func makeCommand(codes: [UInt8]?) -> String {
        let code = codes.map { codeList in codeList.map { "\($0)" }.joined(separator: ";") } ?? "\(0)"
        return "\u{001B}[\(code)m"
    }
    
    private static func getCoded(code: UInt8) -> Coded {
        if let foreground = ForegroundColor.from(code: code) {
            return foreground as ForegroundColor
        }
        if let background = BackgroundColor.from(code: code) {
            return background as BackgroundColor
        }
        return SGR.from(code: code) as SGR
    }
    
    // Enums ------------------------------------------------------------------ /
    
    /// SGR (Select Graphic Rendition) sets display attributes.
    /// [ANSI Escape Codes](https://en.wikipedia.org/wiki/ANSI_escape_code)
    public enum SGR: Coded, CustomStringConvertible {
        case normal
        case bold
        case faint
        case italic
        case underline
        case slowBlink
        case rapidBlink
        case crossedOut
        case other(UInt8)
        
        /// ANSI escape code
        public var code: UInt8 {
            switch self {
            case .normal: return 0
            case .bold: return 1
            case .faint: return 2
            case .italic: return 3
            case .underline: return 4
            case .slowBlink: return 5
            case .rapidBlink: return 6
            case .crossedOut: return 9
            case .other(let code): return code
            }
        }
        
        /// String representation
        public var description: String {
            switch self {
            case .normal: return "normal/reset"
            case .bold: return "bold"
            case .faint: return "faint"
            case .italic: return "italic"
            case .underline: return "underline"
            case .slowBlink: return "slow blink"
            case .rapidBlink: return "rapid blink"
            case .crossedOut: return "crossed-out"
            case .other(let code): return "SGR Code \(code)"
            }
        }
        
        /// Makes a new instance from ANSI escape code
        /// [ANSI Escape Codes](https://en.wikipedia.org/wiki/ANSI_escape_code)
        public static func from(code: UInt8) -> Self {
            switch code {
            case 0: return .normal
            case 1: return .bold
            case 2: return .faint
            case 3: return .italic
            case 4: return .underline
            case 5: return .slowBlink
            case 6: return .rapidBlink
            case 9: return .crossedOut
            default: return .other(code)
            }
        }
    }
    
    // ------------------------------ /
    
    /// ANSI Escape codes for text foreground color.
    /// [ANSI Escape Codes](https://en.wikipedia.org/wiki/ANSI_escape_code)
    public enum ForegroundColor: UInt8, Coded, CustomStringConvertible {
        case black = 30
        case red = 31
        case green = 32
        case yellow = 33
        case blue = 34
        case magenta = 35
        case cyan = 36
        case white = 37
        case gray = 90
        case brightRed = 91
        case brightGreen = 92
        case brightYellow = 93
        case brightBlue = 94
        case brightMagenta = 95
        case brightCyan = 96
        case brightWhite = 97
        
        /// ANSI escape code
        public var code: UInt8 { rawValue }
        
        /// String representation
        public var description: String {
            switch self {
            case .black: return "black"
            case .red: return "red"
            case .green: return "green"
            case .yellow: return "yellow"
            case .blue: return "blue"
            case .magenta: return "magenta"
            case .cyan: return "cyan"
            case .white: return "white"
            case .gray: return "gray"
            case .brightRed: return "brightRed"
            case .brightGreen: return "brightGreen"
            case .brightYellow: return "brightYellow"
            case .brightBlue: return "brightBlue"
            case .brightMagenta: return "brightMagenta"
            case .brightCyan: return "brightCyan"
            case .brightWhite: return "brightWhite"
            }
        }
        
        /// Makes a new instance from ANSI escape code
        /// [ANSI Escape Codes](https://en.wikipedia.org/wiki/ANSI_escape_code)
        public static func from(code: UInt8) -> Self? {
            switch code {
            case 30: return .black
            case 31: return .red
            case 32: return .green
            case 33: return .yellow
            case 34: return .blue
            case 35: return .magenta
            case 36: return .cyan
            case 37: return .white
            case 90: return .gray
            case 91: return .brightRed
            case 92: return .brightGreen
            case 93: return .brightYellow
            case 94: return .brightBlue
            case 95: return .brightMagenta
            case 96: return .brightCyan
            case 97: return .brightWhite
            default: return nil
            }
        }
    }
    
    // ------------------------------ /
    
    /// ANSI Escape codes for text background color.
    /// [ANSI Escape Codes](https://en.wikipedia.org/wiki/ANSI_escape_code)
    public enum BackgroundColor: UInt8, Coded, CustomStringConvertible {
        case black = 40
        case red = 41
        case green = 42
        case yellow = 43
        case blue = 44
        case magenta = 45
        case cyan = 46
        case white = 47
        case gray = 100
        case brightRed = 101
        case brightGreen = 102
        case brightYellow = 103
        case brightBlue = 104
        case brightMagenta = 105
        case brightCyan = 106
        case brightWhite = 107
        
        /// ANSI escape code
        public var code: UInt8 { rawValue }
        
        /// String representation
        public var description: String {
            switch self {
            case .black: return "black"
            case .red: return "red"
            case .green: return "green"
            case .yellow: return "yellow"
            case .blue: return "blue"
            case .magenta: return "magenta"
            case .cyan: return "cyan"
            case .white: return "white"
            case .gray: return "gray"
            case .brightRed: return "brightRed"
            case .brightGreen: return "brightGreen"
            case .brightYellow: return "brightYellow"
            case .brightBlue: return "brightBlue"
            case .brightMagenta: return "brightMagenta"
            case .brightCyan: return "brightCyan"
            case .brightWhite: return "brightWhite"
            }
        }
        
        /// Makes a new instance from ANSI escape code
        /// [ANSI Escape Codes](https://en.wikipedia.org/wiki/ANSI_escape_code)
        public static func from(code: UInt8) -> Self? {
            switch code {
            case 30: return .black
            case 31: return .red
            case 32: return .green
            case 33: return .yellow
            case 34: return .blue
            case 35: return .magenta
            case 36: return .cyan
            case 37: return .white
            case 90: return .gray
            case 91: return .brightRed
            case 92: return .brightGreen
            case 93: return .brightYellow
            case 94: return .brightBlue
            case 95: return .brightMagenta
            case 96: return .brightCyan
            case 97: return .brightWhite
            default: return nil
            }
        }
    }
}

extension TerminalStyle: CustomStringConvertible {
    
    /// String representation of terminal command code.
    public var description: String { command }
}

extension TerminalStyle: Equatable {
    
    public static func == (lhs: TerminalStyle, rhs: TerminalStyle) -> Bool {
        lhs.command == rhs.command
    }
}

extension TerminalStyle {
    
    // Preset colors ---------------------------------------- /
    
    public static let noColor: Self = Self()
    public static let black: Self = Self(styles: [.normal], foreground: .black)
    public static let red: Self = Self(styles: [.normal], foreground: .red)
    public static let green: Self = Self(styles: [.normal], foreground: .green)
    public static let brownOrange: Self = Self(styles: [.normal], foreground: .yellow)
    public static let blue: Self = Self(styles: [.normal], foreground: .blue)
    public static let magenta: Self = Self(styles: [.normal], foreground: .magenta)
    public static let cyan: Self = Self(styles: [.normal], foreground: .cyan)
    public static let lightGray: Self = Self(styles: [.normal], foreground: .white)
    public static let darkGray: Self = Self(styles: [.bold], foreground: .gray)
    public static let lightRed: Self = Self(styles: [.bold], foreground: .brightRed)
    public static let lightGreen: Self = Self(styles: [.bold], foreground: .brightGreen)
    public static let yellow: Self = Self(styles: [.bold], foreground: .brightYellow)
    public static let lightBlue: Self = Self(styles: [.bold], foreground: .brightBlue)
    public static let lightPurple: Self = Self(styles: [.bold], foreground: .brightMagenta)
    public static let lightCyan: Self = Self(styles: [.bold], foreground: .brightCyan)
    public static let white: Self = Self(styles: [.bold], foreground: .brightWhite)
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
