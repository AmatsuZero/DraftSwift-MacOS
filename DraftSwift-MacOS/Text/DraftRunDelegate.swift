//
//  DraftRunDelegate.swift
//  DraftSwift-MacOS
//
//  Created by modao on 2018/3/6.
//  Copyright © 2018年 MockingBot. All rights reserved.
//

import Cocoa
import CoreText

private func deallocCallback(ref: UnsafeMutableRawPointer) {
    ref.deallocate()
}

private func getAscentCallback(ref: UnsafeMutableRawPointer) -> CGFloat {
    let target = Unmanaged<DraftRunDelegate>.fromOpaque(ref).takeUnretainedValue()
    return target.ascent
}

private func getDescentCallback(ref: UnsafeMutableRawPointer) -> CGFloat {
    let target = Unmanaged<DraftRunDelegate>.fromOpaque(ref).takeUnretainedValue()
    return target.descent
}

private func getWidthCallback(ref: UnsafeMutableRawPointer) -> CGFloat {
    let target = Unmanaged<DraftRunDelegate>.fromOpaque(ref).takeUnretainedValue()
    return target.width
}

public final class DraftRunDelegate: NSObject, NSCopying, NSCoding {

    var cfRunDelegate: CTRunDelegate? {
        var callbacks = CTRunDelegateCallbacks(version: kCTRunDelegateCurrentVersion,
                                               dealloc: deallocCallback,
                                               getAscent: getAscentCallback,
                                               getDescent: getDescentCallback,
                                               getWidth: getWidthCallback)
        var copy = self.copy()
        return CTRunDelegateCreate(&callbacks, &copy)
    }
    var userInfo: [String: Any]?
    var ascent: CGFloat = 0
    var descent: CGFloat = 0
    var width: CGFloat = 0

    public override init() {
        super.init()
    }

    public func copy(with zone: NSZone? = nil) -> Any {
        let one = DraftRunDelegate()
        one.ascent = ascent
        one.descent = descent
        one.width = width
        one.userInfo = userInfo
        return one
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(ascent, forKey: "ascent")
        aCoder.encode(descent, forKey: "descent")
        aCoder.encode(width, forKey: "width")
        aCoder.encode(userInfo, forKey: "userInfo")
    }

    public init?(coder aDecoder: NSCoder) {
        ascent = CGFloat(aDecoder.decodeDouble(forKey: "ascent"))
        descent = CGFloat(aDecoder.decodeDouble(forKey: "descent"))
        width = CGFloat(aDecoder.decodeDouble(forKey: "width"))
        userInfo = aDecoder.decodeObject(forKey: "userInfo") as? [String: Any]
    }
}
