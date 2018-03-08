//
//  TextUtilities.swift
//  DraftSwift-MacOS
//
//  Created by modao on 2018/3/6.
//  Copyright © 2018年 MockingBot. All rights reserved.
//

import Foundation
import Quartz
import CoreText

func clamp<T: Comparable> (x: T, low: T, high: T) -> T {
    return x > high ? high : x < low ? low : x
}

var DraftVerticalFormRotateCharacterSet = CharacterSet()
var DraftVerticalFormRotateAndMoveCharacterSet = CharacterSet()

