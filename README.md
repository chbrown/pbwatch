# pbwatch

Polling NSPasteboard (Mac OS X's copy & paste handler) for changes.

### Outtakes:

    from ScriptingBridge import NSPasteboardItem, NSPasteboardFilter, NSFilterServicesPasteboard


## Mac OS X documentation

The main NSPasteboard reference:

* https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSPasteboard_Class/Reference/Reference.html

From Mac OS X documentation site:

> The following constants are provided by NSString as possible string encodings.

    NSASCIIStringEncoding = 1,
    NSNEXTSTEPStringEncoding = 2,
    NSJapaneseEUCStringEncoding = 3,
    NSUTF8StringEncoding = 4,
    NSISOLatin1StringEncoding = 5,
    NSSymbolStringEncoding = 6,
    NSNonLossyASCIIStringEncoding = 7,
    NSShiftJISStringEncoding = 8,
    NSISOLatin2StringEncoding = 9,
    NSUnicodeStringEncoding = 10,
    NSWindowsCP1251StringEncoding = 11,
    NSWindowsCP1252StringEncoding = 12,
    NSWindowsCP1253StringEncoding = 13,
    NSWindowsCP1254StringEncoding = 14,
    NSWindowsCP1250StringEncoding = 15,
    NSISO2022JPStringEncoding = 21,
    NSMacOSRomanStringEncoding = 30,
    NSUTF16StringEncoding = NSUnicodeStringEncoding,
    NSUTF16BigEndianStringEncoding = 0x90000100,
    NSUTF16LittleEndianStringEncoding = 0x94000100,
    NSUTF32StringEncoding = 0x8c000100,
    NSUTF32BigEndianStringEncoding = 0x98000100,
    NSUTF32LittleEndianStringEncoding = 0x9c000100,
    NSProprietaryStringEncoding = 65536

And we can do things like:

    from ScriptingBridge import NSUTF8StringEncoding

Not sure if this would be any help, it's just a bunch of integers:

    NSString.availableStringEncodings()

Verbose example project:

* https://developer.apple.com/library/mac/samplecode/ClipboardViewer/Introduction/Intro.html#//apple_ref/doc/uid/DTS40008825-Intro-DontLinkElementID_2

## License

Copyright (c) 2013 Christopher Brown. [MIT Licensed](LICENSE).
