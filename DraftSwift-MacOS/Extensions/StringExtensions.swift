//
//  CharExtensions.swift
//  DraftSwift-MacOS
//
//  Created by modao on 2018/3/6.
//  Copyright © 2018年 MockingBot. All rights reserved.
//

import Foundation

extension UniChar {
    /*
     Whether the character is 'line break char':
     U+000D (\\r or CR)
     U+2028 (Unicode line separator)
     U+000A (\\n or LF)
     U+2029 (Unicode paragraph separator)
     */
    var isLinebreak: Bool {
        switch self {
        case 0x000D, 0x2028, 0x000A, 0x2029:
            return true
        default:
            return false
        }
    }
}

extension String {
    /*
     Whether the string is a 'line break':
     U+000D (\\r or CR)
     U+2028 (Unicode line separator)
     U+000A (\\n or LF)
     U+2029 (Unicode paragraph separator)
     \\r\\n, in that order (also known as CRLF)
     */
    var isLineBreak: Bool {
        if count > 2 || count == 0 { return false }
        let nsstr = self as NSString
        if count == 1 {
            return nsstr.character(at: 0).isLinebreak
        } else {
            let offset = self.index(startIndex, offsetBy: 1)
            return self[startIndex] == "\r" && self[offset] == "\n"
        }
    }
    /*
     If the string has a 'line break' suffix, return the 'line break' length
     */
    var tailLength: UInt {
        if count >= 2 {
            let c2 = (self as NSString).character(at: count-1)
            if c2.isLinebreak {
                let c1 = index(endIndex, offsetBy: -2)
                let second = Character(UnicodeScalar(c2)!)
                return self[c1] == "\r" && second == "\n" ? 2 : 1
            } else {
                return 0
            }
        } else if count == 1 {
            return (self as NSString).character(at: 0).isLinebreak ? 1 : 0
        } else {
            return 0
        }
    }
}
