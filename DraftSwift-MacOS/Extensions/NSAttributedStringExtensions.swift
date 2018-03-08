//
//  NSAttributeStringExtensions.swift
//  DraftSwift-MacOS
//
//  Created by modao on 2018/3/6.
//  Copyright © 2018年 MockingBot. All rights reserved.
//

import Foundation

public extension NSAttributedString {

    var archiveData: Data? {
        return DraftTextArchiver.archivedData(withRootObject: self)
    }

    convenience init?(data: Data) {
        if let attStr = DraftTextUnarchinver.unarchiveObject(with: data) as? NSAttributedString {
            self.init(attributedString: attStr)
        }
        return nil
    }

    

    func attributes(at index: Int) -> [NSAttributedStringKey: Any]? {
        var at = index
        guard length > 0, at <= length else { return nil }
        if length > 0, at == length { at -= 1 }
        return attributes(at: at, effectiveRange: nil)
    }

    func attributeValue(name: NSAttributedStringKey, at: Int) -> Any? {
        var index = at
        guard length > 0, index <= length else { return nil }
        if length > 0, at == length { index -= 1 }
        return attribute(name, at: index, effectiveRange: nil)
    }

    var allAttributes: [NSAttributedStringKey: Any]? { return attributes(at: 0) }
    var font: NSFont? { return font(at: 0) }
    var kern: Int? { return kern(at: 0) }
    var color: NSColor? { return color(at: 0) }
    var backgroundColor: NSColor? { return backgroundColor(at: 0) }
    var strokeWidth: CGFloat? { return strokeWidth(at: 0) }
    var strokeColor: NSColor? { return strokeColor(at: 0) }
    var shadow: NSShadow? { return shadow(at: 0) }
    var strikeThroughStyle: NSUnderlineStyle? { return strikeThroughStyle(at: 0) }
    var strikeThroughColor: NSColor? { return strokeColor(at: 0) }


    func font(at: Int) -> NSFont? {
        return attributeValue(name: .font, at: at) as? NSFont
    }

    func kern(at: Int) -> Int? {
        return attributeValue(name: .kern, at: at) as? Int
    }

    func color(at: Int) -> NSColor? {
        var color = attributeValue(name: .foregroundColor, at: at)
        if color != nil, !(color is NSColor) {
            if CFGetTypeID(color! as CFTypeRef) == CGColor.typeID {
                color = NSColor(cgColor: color as! CGColor)
            } else {
                return nil
            }
        }
        return color as? NSColor
    }

    func backgroundColor(at: Int) -> NSColor? {
        return attributeValue(name: .backgroundColor, at: at) as? NSColor
    }

    func strokeWidth(at: Int) -> CGFloat? {
        return attributeValue(name: .strokeWidth, at: at) as? CGFloat
    }

    func strokeColor(at: Int) -> NSColor? {
        return attributeValue(name: .strokeColor, at: at) as? NSColor
    }

    func shadow(at: Int) -> NSShadow? {
        return attributeValue(name: .shadow, at: at) as? NSShadow
    }

    func strikeThroughStyle(at: Int) -> NSUnderlineStyle? {
        return attributeValue(name: .underlineStyle, at: at) as? NSUnderlineStyle
    }

    func strikeThroughColor(at: Int) -> NSColor? {
        return attributeValue(name: .strikethroughColor, at: at) as? NSColor
    }
}
