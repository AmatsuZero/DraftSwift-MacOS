//
//  DraftRubyAnnotation.swift
//  DraftSwift-MacOS
//
//  Created by modao on 2018/3/6.
//  Copyright © 2018年 MockingBot. All rights reserved.
//

import Cocoa
import CoreText

public final class DraftRubyAnnotation: NSObject, NSCopying, NSCoding {

    public func copy(with zone: NSZone? = nil) -> Any {
        let one = DraftRubyAnnotation()
        one.alignment = alignment
        one.overhang = overhang
        one.sizeFactor = sizeFactor
        one.textBefore = textBefore
        one.textAfter = textAfter
        one.textInline = textInline
        one.textInterCharacter = textInterCharacter
        return one
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(alignment.rawValue, forKey: "alignment")
        aCoder.encode(overhang.rawValue, forKey: "overhang")
        aCoder.encode(sizeFactor, forKey: "sizeFactor")
        aCoder.encode(textBefore, forKey: "textBefore")
        aCoder.encode(textAfter, forKey: "textAfter")
        aCoder.encode(textInterCharacter, forKey: "textInterCharacter")
        aCoder.encode(textInline, forKey: "extInline")
    }

    public init?(coder aDecoder: NSCoder) {
        alignment = CTRubyAlignment(rawValue: UInt8(aDecoder.decodeInteger(forKey: "alignment")))!
        overhang = CTRubyOverhang(rawValue: UInt8(aDecoder.decodeInteger(forKey: "overhang")))!
        sizeFactor = aDecoder.decodeDouble(forKey: "sizeFactor")
        textBefore = aDecoder.decodeObject(forKey: "textBefore") as? String
        textInline = aDecoder.decodeObject(forKey: "textInline") as? String
        textInterCharacter = aDecoder.decodeObject(forKey: "textInterCharacter") as? String
    }

    var alignment = CTRubyAlignment.auto
    var overhang = CTRubyOverhang.auto
    var sizeFactor = 0.5
    var textBefore: String?
    var textAfter: String?
    var textInterCharacter: String?
    var textInline: String?
    var rubyAnnotation: CTRubyAnnotation?

    public override init() {
        super.init()
    }

    init?(ctRuby: CTRubyAnnotation?) {
        guard let ruby = ctRuby else {
            return nil
        }
        rubyAnnotation = ruby
        super.init()
    }

}
