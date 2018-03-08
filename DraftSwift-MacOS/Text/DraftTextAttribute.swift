//
//  DraftTextAttribute.swift
//  DraftSwift-MacOS
//
//  Created by modao on 2018/3/6.
//  Copyright © 2018年 MockingBot. All rights reserved.
//

import Foundation

public struct DraftAttributeType: OptionSet {
    public var rawValue: Int
    public static let None = DraftAttributeType(rawValue: 0)
    public static let AppKit = DraftAttributeType(rawValue: 1 << 0)
    public static let CoreText = DraftAttributeType(rawValue: 1 << 1)
    public static let DraftText = DraftAttributeType(rawValue: 1 << 2)

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

public struct DraftLineStyle: OptionSet {
    public var rawValue: Int
    public static let None = DraftLineStyle(rawValue: 0x00)
    public static let Single = DraftLineStyle(rawValue: 0x01)
    public static let Thick = DraftLineStyle(rawValue: 0x02)
    public static let Double = DraftLineStyle(rawValue: 0x09)
    public static let Solid = DraftLineStyle(rawValue: 0x000)
    public static let Dot = DraftLineStyle(rawValue: 0x100)
    public static let Dash = DraftLineStyle(rawValue: 0x200)
    public static let DashDot = DraftLineStyle(rawValue: 0x300)
    public static let DashDotDot = DraftLineStyle(rawValue: 0x400)
    public static let CircleDot = DraftLineStyle(rawValue: 0x900)

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

public struct DraftVerticalAlignment: OptionSet {
    public var rawValue: Int
    public static let top = DraftVerticalAlignment(rawValue: 0)
    public static let center = DraftVerticalAlignment(rawValue: 1)
    public static let bottom = DraftVerticalAlignment(rawValue: 2)

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

public struct DraftDirection: OptionSet {
    public var rawValue: Int
    public static let none = DraftDirection(rawValue: 0)
    public static let top = DraftDirection(rawValue: 1 << 0)
    public static let right = DraftDirection(rawValue: 1 << 1)
    public static let bottom = DraftDirection(rawValue: 1 << 2)
    public static let left = DraftDirection(rawValue: 1 << 3)
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

public struct DraftTruncationType: OptionSet {
    public var rawValue: Int
    public static let none = DraftTruncationType(rawValue: 0)
    public static let start  = DraftTruncationType(rawValue: 1)
    public static let end = DraftTruncationType(rawValue: 2)
    public static let middle = DraftTruncationType(rawValue: 3)
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

public typealias DraftTextAction = (NSView, NSAttributedString, NSRange, NSRect) -> Void

//public final class DraftBackedString: NSObject, NSCoding, NSCopying {
//    var string: String?
//    public init(string: String?) {
//        self.string = string
//        super.init()
//    }
//}
//
//public final class DraftBinding: NSObject, NSCoding, NSCopying {
//    var deleConfirm = false
//    init(deleteConfirm: Bool) {
//        super.init()
//    }
//}
//
//public final class DraftShadow: NSObject, NSCoding, NSCopying {
//    var color: NSColor?
//    var offset: CGFloat = 0
//    var radius: CGFloat = 0
//    var blendMode = CGBlendMode.clear
//    var subShadow: DraftShadow?
//
//    init(nsShadow: NSShadow) {
//        super.init()
//    }
//
//    var nsShadow: NSShadow {
//
//    }
//}
//
//public class DraftTextDecoration: NSObject, NSCoding, NSCopying {
//    var style: DraftLineStyle
//    var width: CGFloat?
//    var color: NSColor?
//    var shadow: DraftShadow?
//    public init(style: DraftLineStyle, width: CGFloat? = nil, color: NSColor? = nil) {
//        self.style = style
//        self.width = width
//        self.color = color
//        super.init()
//    }
//}
//
//public class DraftTextBorder: NSObject, NSCopying, NSCoding {
//    var lineStyle: DraftLineStyle?
//    var strokeWidth: CGFloat = 0
//    var lineJoin = CGLineJoin.round
//    var insets = NSEdgeInsetsZero
//    var cornerRadius: CGFloat = 0
//    var shadow: DraftShadow?
//    var fillColor: NSColor?
//    public init(style: DraftLineStyle, lineWidth: CGFloat, strokeColor: NSColor?) {
//        lineStyle = style
//        super.init()
//    }
//
//    public init(fillColor: NSColor?, cornerRadius: CGFloat) {
//        super.init()
//    }
//}
//
//public class DraftAttachment: NSObject, NSCopying, NSCoding {
//    var content: AnyObject?
//    var contentInsets = NSEdgeInsetsZero
//    var userInfo: [String: Any]?
//    init(content: AnyObject?) {
//        self.content = content
//    }
//}
//
//public class DraftHighLight: NSObject, NSCopying , NSCoding {
//    var attributes: [NSAttributedStringKey: Any]?
//    // Convenience methods below to set the `attributes`.
//    var font: NSFont? {
//        didSet {
//
//        }
//    }
//    var color: NSColor? {
//        didSet {
//
//        }
//    }
//    var strokeWidth: CGFloat? {
//        didSet {
//
//        }
//    }
//    var strokeColor: NSColor? {
//        didSet {
//
//        }
//    }
//    var shadow: DraftShadow?
//    var innerShadow: DraftShadow?
//    var underline: DraftTextDecoration?
//    var strikeThrough: DraftTextDecoration?
//    var backgroundBorder: DraftTextDecoration?
//    var border: DraftTextDecoration?
//    var attachment: DraftAttachment?
//    var tapAction: DraftTextAction?
//    var userInfo: [String: Any]?
//    var rightClickAction: DraftTextAction?
//
//    init(attributes: [NSAttributedStringKey: Any]?) {
//        self.attributes = attributes
//    }
//    init(backgroundColor: NSColor?) {
//
//    }
//}
