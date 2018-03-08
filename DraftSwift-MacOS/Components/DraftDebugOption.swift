//
//  DraftDebugOption.swift
//  DraftSwift-MacOS
//
//  Created by modao on 2018/3/6.
//  Copyright © 2018年 MockingBot. All rights reserved.
//

import Cocoa

public protocol DraftDebugTarget: NSObjectProtocol {
    func setDebugOption(option: DraftDebugOption?)
}

private func _sharedDebugSetRetain(allocator: CFAllocator?, value: UnsafeRawPointer?) -> UnsafeRawPointer? {
    return value
}

private func _sharedDebugSetRelease(allocator: CFAllocator?, value: UnsafeRawPointer?) {

}

private func _sharedDebugSetFunction(value: UnsafeRawPointer?, context: UnsafeMutableRawPointer?) {
    if let ptr = value, let target = Unmanaged<AnyObject>.fromOpaque(ptr).takeUnretainedValue() as? DraftDebugTarget {
        target.setDebugOption(option: DraftDebugOption.sharedDebugOption)
    }
}

public final class DraftDebugOption: NSObject, NSCopying {
    ///  baseline color
    var baselineColor: NSColor?
    /// CTFrame path border color
    var CTFrameBorderColor: NSColor?
    /// CTFrame path fill color
    var CTFrameFillColor: NSColor?
    /// CTLine bounds border color
    var CTLineBorderColor: NSColor?
    /// CTLine bounds fill color
    var CTLineFillColor: NSColor?
    /// CTLine line number color
    var CTLineNumberColor: NSColor?
    /// CTRun bounds border color
    var CTRunBorderColor: NSColor?
    /// CTRun bounds fill color
    var CTRunFillColor: NSColor?
    /// CTRunNumberColor
    var CTRunNumberColor: NSColor?
    /// CGGlyph bounds border color
    var CGGlyphBorderColor: NSColor?
    /// CGGlyph bounds fill color
    var CGGlyphFillColor: NSColor?

    private static var _sharedDebugLock: pthread_mutex_t = pthread_mutex_t()
    private static var _sharedDebugOption: DraftDebugOption?
    private static var _sharedDebugTargets: CFMutableSet = {
        var callbacks = kCFTypeSetCallBacks
        callbacks.retain = _sharedDebugSetRetain
        callbacks.release = _sharedDebugSetRelease
        return CFSetCreateMutable(CFAllocatorGetDefault().takeUnretainedValue(), 0, &callbacks)
    }()
    static var sharedDebugOption: DraftDebugOption? {
        set(newValue) {
            guard Thread.isMainThread else {
                fatalError("This method must be called on the main thread")
            }
            pthread_mutex_lock(&_sharedDebugLock)
            _sharedDebugOption = newValue?.copy() as? DraftDebugOption
            CFSetApplyFunction(_sharedDebugTargets, _sharedDebugSetFunction, nil)
            pthread_mutex_unlock(&_sharedDebugLock)
        }
        get {
            pthread_mutex_lock(&_sharedDebugLock)
            let op = _sharedDebugOption
            pthread_mutex_unlock(&_sharedDebugLock)
            return op
        }
    }
    public func copy(with zone: NSZone? = nil) -> Any {
        let op = DraftDebugOption()
        op.baselineColor = self.baselineColor
        op.CTFrameBorderColor = self.CTFrameBorderColor
        op.CTFrameFillColor = self.CTFrameFillColor
        op.CTLineBorderColor = self.CTLineBorderColor
        op.CTLineFillColor = self.CTLineFillColor
        op.CTLineNumberColor = self.CTLineNumberColor
        op.CTRunBorderColor = self.CTRunBorderColor
        op.CTRunFillColor = self.CTRunFillColor
        op.CTRunNumberColor = self.CTRunNumberColor;
        op.CGGlyphBorderColor = self.CGGlyphBorderColor
        op.CGGlyphFillColor = self.CGGlyphFillColor
        return op
    }
    /// `YES`: at least one debug color is visible. `NO`: all debug color is invisible/nil
    var needDrawDebug: Bool {
        return baselineColor != nil || CTFrameBorderColor != nil || CTFrameFillColor != nil
            || CTLineBorderColor != nil || CTLineFillColor != nil || CTLineNumberColor != nil
            || CTRunBorderColor != nil || CTRunNumberColor != nil || CTRunFillColor != nil
            || CGGlyphBorderColor != nil || CGGlyphFillColor != nil
    }
    /// Set all debug color to nil
    func clear() {
        baselineColor = nil
        CTFrameBorderColor = nil
        CTFrameFillColor = nil
        CTLineBorderColor = nil
        CTLineFillColor = nil
        CTLineNumberColor = nil
        CTRunBorderColor = nil
        CTRunFillColor = nil
        CTRunNumberColor = nil
        CTRunBorderColor = nil
        CGGlyphFillColor = nil
        CGGlyphBorderColor = nil
    }
    /// Add a debug targe
    /// - When `setSharedDebugOption:` is called, all added debug target will receive `setDebugOption:` in main thread. It maintains an unsafe_unretained reference to this target. The target must to removed before dealloc.
    /// - Parameter target: A debug target
    class func addDebugTarget(target: inout DraftDebugTarget) {
        pthread_mutex_lock(&_sharedDebugLock)
        CFSetAddValue(_sharedDebugTargets, &target)
        pthread_mutex_unlock(&_sharedDebugLock)
    }
    class func removeDebugTarget(target: inout DraftDebugTarget) {
        pthread_mutex_lock(&_sharedDebugLock)
        CFSetRemoveValue(_sharedDebugTargets, &target)
        pthread_mutex_unlock(&_sharedDebugLock)
    }
}
