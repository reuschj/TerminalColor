import XCTest
@testable import TerminalColor

final class TerminalColorTests: XCTestCase {
    let yellow = TerminalColor(1, 33)
    let noColor = TerminalColor()
    
    func testThatCodeGeneratesCorrectly() {
        XCTAssertEqual(yellow.command, "\u{001B}[1;33m")
        XCTAssertEqual(noColor.command, "\u{001B}[0m")
        XCTAssertEqual(yellow, TerminalColor.yellow)
        XCTAssertEqual(noColor, TerminalColor.noColor)
    }
    
    func testThatContentCanBeWrapped() {
        let wrapped = yellow.wrap("Hello, World!")
        XCTAssertEqual(wrapped, "\u{001B}[1;33mHello, World!\u{001B}[0m")
        XCTAssertEqual(wrapped, "\(yellow)Hello, World!\(noColor)")
    }
    
    func testColorTerminalText() {
        let highlighted = ColorTerminalText("Hello, World!", color: .yellow)
        XCTAssertEqual(highlighted.output, "\u{001B}[1;33mHello, World!\u{001B}[0m")
        XCTAssertEqual("\(highlighted)", "\u{001B}[1;33mHello, World!\u{001B}[0m")
        XCTAssertEqual(highlight("Hello, World!", with: .yellow).output, "\u{001B}[1;33mHello, World!\u{001B}[0m")
    }
}
