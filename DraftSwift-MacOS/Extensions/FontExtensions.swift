//
//  FontExtensions.swift
//  DraftSwift-MacOS
//
//  Created by modao on 2018/3/6.
//  Copyright © 2018年 MockingBot. All rights reserved.
//

import CoreText

extension NSFont {
    var isEmoji: Bool {
        return fontName == "AppleColorEmoji"
    }
    //MARK: Emoji
    /// Get the `AppleColorEmoji` font's ascent with a specified font size. It may used to create custom emoji
    var emojiAscent: CGFloat {
        if pointSize < 16 {
            return 1.25 * pointSize
        } else if pointSize >= 16, pointSize <= 24 {
            return 0.5  * pointSize + 12
        } else {
            return pointSize
        }
    }
    var emojiDescent: CGFloat {
        if pointSize < 16 {
            return  0.390625 * pointSize
        } else if pointSize >= 16, pointSize <= 24 {
            return 0.15625 * pointSize + 3.75
        } else {
            return 0.3125 * pointSize
        }
    }
    var emojiBoundingRect: NSRect {
        let size = emojiAscent
        var rect = NSRect(origin: CGPoint(x: 0.75, y: 0),
                          size: NSSize(width: size, height: size))
        if pointSize < 16 {
            rect.origin.y = -0.2525 * pointSize
        } else if pointSize >= 16, pointSize <= 24 {
            rect.origin.y = 0.1225 * pointSize - 6
        } else {
            rect.origin.y = -0.1275 * pointSize
        }
        return rect
    }
    var bold: NSFont? {
        let newDescriptor = fontDescriptor.withSymbolicTraits(.bold)
        return NSFont(descriptor: newDescriptor, size: pointSize)
    }
    var italic: NSFont? {
        let newDescriptor = fontDescriptor.withSymbolicTraits(.italic)
        return NSFont(descriptor: newDescriptor, size: pointSize)
    }
    var boldItalic: NSFont? {
        let newDescriptor = fontDescriptor.withSymbolicTraits([.bold, .italic])
        return NSFont(descriptor: newDescriptor, size: pointSize)
    }
}

extension CTFont {
    var isEmoji: Bool {
        let name = CTFontCopyPostScriptName(self)
        return CFEqual("AppleColorEmoji" as CFString, name)
    }
    /// Whether the font contains color bitmap glyphs
    var containBitmap: Bool {
        return CTFontGetSymbolicTraits(self).contains(.traitColorGlyphs)
    }
    func containBitmap(glyph: CGGlyph) -> Bool {
        guard containBitmap else {
            return false
        }
        return CTFontCreatePathForGlyph(self, glyph, nil) == nil
    }
}

extension CGFont {
    var isEmoji: Bool {
        guard let name = self.postScriptName else {
            return false
        }
        return CFEqual("AppleColorEmoji" as CFString, name)
    }
}

extension CFRange {
    var nsRange: NSRange {
        return NSRange(location: location, length: length)
    }
}

extension NSRange {
    var cfRange: CFRange {
        return CFRangeMake(location, length)
    }
}
