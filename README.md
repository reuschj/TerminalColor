> **Note:** This package is deprecated: Use [TerminalTextStyler](https://github.com/reuschj/TerminalTextStyler) instead (it does the same thing, but it's a lot more capable).

# TerminalColor

If you are building a command-line tool with Swift, you may find it useful to highlight output in a color to make it stand out. Doing so, simply means wrapping your text in the necessary ANSI escape codes:

Color | ANSI Escape Code
---- | ----
Black | 0;30
Red | 0;31
Green | 0;32
Brown/Orange | 0;33
Blue | 0;34
Purple | 0;35
Cyan | 0;36
Light Gray | 0;37
Dark Gray | 1;30
Light Red | 1;31
Light Green | 1;32
Yellow | 1;33
Light Blue | 1;34
Light Purple | 1;35
Light Cyan | 1;36
White | 1;37

Source: [StackOverflow](https://stackoverflow.com/a/5947802/3055803)

```
RED='\033[0;31m'
NC='\033[0m' # No Color
printf "I ${RED}love${NC} Stack Overflow\n"
```

In Swift, we can just replace '\033' with the unicode "\u{001B}" (Source: [StackOverflow](https://stackoverflow.com/q/40583721/3055803)).

So, we can switch to the desired color by placing the escape code to start that color in our text and end it by using the escape code for no color. That's all there is to it! So, to highlight our text in yellow, we can just do this:

```swift
print("\u{001B}[1;33mHello, World!\u{001B}[0m")
```

But, that's kinda clunky and hard to read. That's where this package comes in.

## TerminalColor

With the `TerminalColor` struct, we can build a color by giving it the two parts of the escape code combination from the table above.

```swift
let yellow = TerminalColor(1, 33)
let noColor = TerminalColor() // Initialize without input parameters for no color
```

Now, when placed in a string (of by accessing the `command` property), a `TerminalColor` instance will generate the ANSI escape code string:

```swift
let yellow = TerminalColor(1, 33)
let noColor = TerminalColor()
print("\(yellow)Hello, World!\(noColor)")
```

This is much better, but we can make it a bit easier. We can call the `wrap` method to wrap the given text in that color.

```swift
let yellow = TerminalColor(1, 33)
print(yellow.wrap("Hello, World!"))
// Or
print("\(yellow.wrap("Hello, World!")) Blah blah blah...")
```

### Presets

For your convenience, all the colors in the table above can be accessed as static presets:

```swift
let yellow = TerminalColor.yellow
let red = TerminalColor.red
// Etc...
```

## ColorTerminalText

The `ColorTerminalText` struct builds on the `wrap` command to put the emphasis back on your text, not the color. The `ColorTerminalText` instance can then be placed right into a `String` (or turned into a `String` by accessing the `output` property):

```swift
let greeting = ColorTerminalText("Hello, World!", color: .yellow)
print("\(greeting) Blah blah blah...")
```

## Highlight Function(s)

The last step to making your code clean and easy is by just using the `highlight` convenience function to generate a `ColorTerminalText`:

```swift
print("\(highlight("Hello, World!", with: .yellow)) Blah blah blah...")
// Or, because `highlight` defaults to .yellow:
print("\(highlight("Hello, World!")) Blah blah blah...")
```

Each color in the table above also has a unique highlight function:

```swift
print("This is \(highlightYellow("highlighted in yellow")) and this is \(highlightRed("highlighted in red")).")
```
