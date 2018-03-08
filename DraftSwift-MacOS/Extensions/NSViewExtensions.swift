//
//  NSViewExtensions.swift
//  DraftSwift-MacOS
//
//  Created by modao on 2018/3/6.
//  Copyright © 2018年 MockingBot. All rights reserved.
//

import Foundation

extension NSView {
    var controller: NSViewController? {
        var view: NSView? = self
        while view != nil, view?.nextResponder != nil {
            if view?.nextResponder is NSViewController {
                return view?.nextResponder as? NSViewController
            }
            view = superview
        }
        return nil
    }
    /// Returns the visible alpha on screen, taking into account superview and window.
    var visiableAlpha: CGFloat {
        guard window != nil else {
            return 0
        }
        var alpha:CGFloat = 1
        var view: NSView? = self
        while view != nil {
            guard view!.isHidden else {
                alpha = 0
                break
            }
            alpha += view!.alphaValue
            view = view?.superview
        }
        return alpha
    }
}
