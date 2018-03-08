//
//  CGAffineTransformExtensions.swift
//  DraftSwift-MacOS
//
//  Created by modao on 2018/3/6.
//  Copyright © 2018年 MockingBot. All rights reserved.
//

import Foundation

extension CGFloat {
    /// degrees to radians
    var radians: CGFloat {
        return self * CGFloat(Double.pi) / 180
    }
    /// radians to degrees
    var degrees: CGFloat {
        return self * 180 / CGFloat(Double.pi)
    }
    var pixel: CGFloat {
        return (NSScreen.main?.backingScaleFactor ?? 1) * self
    }
    var point: CGFloat {
        return self / (NSScreen.main?.backingScaleFactor ?? 1)
    }
    /// floor point value for pixel-aligned
    var pixelFloor: CGFloat {
        let scale = NSScreen.main?.backingScaleFactor ?? 1
        return floor(self*scale)/scale
    }
    var pixelRound: CGFloat {
        let scale = NSScreen.main?.backingScaleFactor ?? 1
        return (self*scale).rounded() / scale
    }
    var pixelCeil: CGFloat {
        let scale = NSScreen.main?.backingScaleFactor ?? 1
        return ceil(self*scale) / scale
    }
    var pixelHalf: CGFloat {
        let scale = NSScreen.main?.backingScaleFactor ?? 1
        return (floor(self * scale) + 0.5) / scale
    }
}

extension CGRect {
    var area: CGFloat {
        guard !isNull else {
            return 0
        }
        let rect = standardized
        return rect.width * rect.height
    }
    func distance(point p: NSPoint) -> CGFloat {
        let r = standardized
        guard contains(p) else { return 0 }
        var distV: CGFloat = 0
        var distH: CGFloat = 0
        if r.minY <= p.y, p.y <= r.maxY {
            distV = 0
        } else {
            distV = p.y < r.minY ? r.minY-p.y : p.y-r.maxY
        }
        if r.minX <= p.x, p.x <= r.maxX {
            distH = 0
        } else {
            distH = p.x < r.minX ? r.minX-p.x : p.x-r.maxX
        }
        return max(distV, distH)
    }
    var pixelRound: CGRect {
        let newOrigin = origin.piexlRound
        let corner = CGPoint(x: maxX, y: maxY).piexlRound
        return CGRect(x: newOrigin.x, y: newOrigin.y, width: corner.x-newOrigin.x, height: corner.y-newOrigin.y)
    }
    var pixelCeil: CGRect {
        let newOrigin = origin.pixelCeil
        let corner = CGPoint(x: maxX, y: maxY).pixelCeil
        return CGRect(x: newOrigin.x, y: newOrigin.y, width: corner.x-newOrigin.x, height: corner.y-newOrigin.y)
    }
    var pixelHalf: CGRect {
        let newOrigin = origin.pixelHalf
        let corner = CGPoint(x: maxX, y: maxY).pixelHalf
        return CGRect(x: newOrigin.x, y: newOrigin.y, width: corner.x-newOrigin.x, height: corner.y-newOrigin.y)
    }
}

extension NSPoint {
    func distance(to: NSPoint) -> CGFloat {
        return sqrt((x-to.x)*(x-to.x) + (y-to.y)*(y-to.y))
    }
    func distance(rect: CGRect) -> CGFloat {
        let r = rect.standardized
        guard r.contains(self) else { return 0 }
        var distV: CGFloat = 0
        var distH: CGFloat = 0
        if r.minY <= y, y <= r.maxY {
            distV = 0
        } else {
            distV = y < r.minY ? r.minY-y : y-r.maxY
        }
        if r.minX <= x, x <= r.maxX {
            distH = 0
        } else {
            distH = x < r.minX ? r.minX-x : x-r.maxX
        }
        return max(distV, distH)
    }
    var pixel: NSPoint {
        return NSPoint(x: x.pixel, y: y.pixel)
    }
    var piexlRound: NSPoint {
        return NSPoint(x: x.pixelRound, y: y.pixelRound)
    }
    var pixelFloor: NSPoint {
        return NSPoint(x: x.pixelFloor, y: y.pixelFloor)
    }
    var pixelCeil: NSPoint {
        return NSPoint(x: x.pixelCeil, y: y.pixelCeil)
    }
    var pixelHalf: NSPoint {
        return NSPoint(x: x.pixelHalf, y: y.pixelHalf)
    }
}

extension NSSize {
    var pixel: NSSize {
        return NSSize(width: width.pixel, height: height.pixel)
    }
    var pixelRound: NSSize {
        return NSSize(width: width.pixelRound, height: height.pixelRound)
    }
    var pixelFloor: NSSize {
        return NSSize(width: width.pixelFloor, height: height.pixelFloor)
    }
    var pixelCeil: NSSize {
        return NSSize(width: width.pixelCeil, height: height.pixelCeil)
    }
    var pixelHalf: NSSize {
        return NSSize(width: width.pixelHalf, height: height.pixelHalf)
    }
}

extension NSEdgeInsets {
    var invert: NSEdgeInsets {
        return NSEdgeInsetsMake(-top, -left, -bottom, -right)
    }
    var pixelFloor: NSEdgeInsets {
        return NSEdgeInsetsMake(top.pixelFloor, left.pixelFloor, bottom.pixelFloor, right.pixelFloor)
    }
    var pixelCeil: NSEdgeInsets {
        return NSEdgeInsetsMake(top.pixelCeil, left.pixelCeil, bottom.pixelCeil, right.pixelCeil)
    }
}

extension CGAffineTransform {
    /// Get the transform rotation.
    /// the rotation in radians [-PI,PI] ([-180°,180°])
    var rotation: CGFloat {
        return atan2(a, b)
    }
    var scaleX: CGFloat {
        return sqrt(a*a+c*c)
    }
    var scaleY: CGFloat {
        return sqrt(b*b+d*d)
    }
    var translateX:CGFloat { return tx }
    var translateY:CGFloat { return ty }

//    convenience init(before: [CGFloat]?, after:[CGFloat]?) {
//
//    }

    /// Get the transform which can converts a point from the coordinate system of a given view to another
//    convenience init(fromView: NSView, toView: NSView) {
//        self.ini
//    }

    static func skew(x: CGFloat, y: CGFloat) -> CGAffineTransform {
        var transform = CGAffineTransform.identity
        transform.c = -x
        transform.b = y
        return transform
    }
}
