//
//  NSParagraphStyleExtensions.swift
//  DraftSwift-MacOS
//
//  Created by modao on 2018/3/7.
//  Copyright © 2018年 MockingBot. All rights reserved.
//

import Foundation
import CoreText

extension NSParagraphStyle {

    var ctStyle: CTParagraphStyle {
        var settings = [CTParagraphStyleSetting]()

        var lineSpacingValue = lineSpacing
        let ls = CTParagraphStyleSetting(spec: .lineSpacingAdjustment, valueSize: MemoryLayout.size(ofValue: lineSpacingValue), value: &lineSpacingValue)
        settings.append(ls)

        var paragraphSpacingValue = paragraphSpacing
        let ps = CTParagraphStyleSetting(spec: .paragraphSpacing, valueSize: MemoryLayout.size(ofValue: paragraphSpacing), value: &paragraphSpacingValue)
        settings.append(ps)

        if var ctAlignment = CTTextAlignment(rawValue: UInt8(alignment.rawValue)) {
            let ca = CTParagraphStyleSetting(spec: .alignment, valueSize: MemoryLayout.size(ofValue: ctAlignment), value: &ctAlignment)
            settings.append(ca)
        }

        var firstlineHeadIndentValue = firstLineHeadIndent
        let flh = CTParagraphStyleSetting(spec: .firstLineHeadIndent, valueSize: MemoryLayout.size(ofValue: firstlineHeadIndentValue), value: &firstlineHeadIndentValue)
        settings.append(flh)

        var headIndentValue = headIndent
        let hi = CTParagraphStyleSetting(spec: .headIndent, valueSize: MemoryLayout.size(ofValue: headIndentValue), value: &headIndentValue)
        settings.append(hi)

        var tailIndentValue = tailIndent
        let ti = CTParagraphStyleSetting(spec: .tailIndent, valueSize: MemoryLayout.size(ofValue: tailIndentValue), value: &tailIndentValue)
        settings.append(ti)

        if var ctLinebreak = CTLineBreakMode(rawValue: UInt8(lineBreakMode.rawValue)) {
            let cl = CTParagraphStyleSetting(spec: .lineBreakMode, valueSize: MemoryLayout.size(ofValue: ctLinebreak), value: &ctLinebreak)
            settings.append(cl)
        }

        var minium = minimumLineHeight
        let mlh = CTParagraphStyleSetting(spec: .minimumLineHeight, valueSize: MemoryLayout.size(ofValue: minium), value: &minium)
        settings.append(mlh)

        var max = maximumLineHeight
        let mah = CTParagraphStyleSetting(spec: .maximumLineHeight, valueSize: MemoryLayout.size(ofValue: max), value: &max)
        settings.append(mah)

        if var direction = CTWritingDirection(rawValue: Int8(baseWritingDirection.rawValue)) {
            let bwd = CTParagraphStyleSetting(spec: .baseWritingDirection, valueSize: MemoryLayout.size(ofValue: direction), value: &direction)
            settings.append(bwd)
        }

        var lineheightMul = lineHeightMultiple
        let lhm = CTParagraphStyleSetting(spec: .lineHeightMultiple, valueSize: MemoryLayout.size(ofValue: lineheightMul), value: &lineheightMul)
        settings.append(lhm)

        var spacingBef = paragraphSpacingBefore
        let psb = CTParagraphStyleSetting(spec: .paragraphSpacingBefore, valueSize: MemoryLayout.size(ofValue: spacingBef), value: &spacingBef)
        settings.append(psb)

        var tabs = tabStops.map {
            return CTTextTabCreate(CTTextAlignment(rawValue: UInt8($0.alignment.rawValue))!, Double($0.location), $0.options as CFDictionary)
        }
        let cftabs = CTParagraphStyleSetting(spec: .tabStops, valueSize: MemoryLayout.size(ofValue: tabs), value: &tabs)
        settings.append(cftabs)

        var interval = defaultTabInterval
        let di = CTParagraphStyleSetting(spec: .defaultTabInterval, valueSize: MemoryLayout.size(ofValue: interval), value: &interval)
        settings.append(di)
        
        return CTParagraphStyleCreate(&settings, settings.count)
    }
}

extension CTParagraphStyle {

    var nsStyle: NSParagraphStyle? {
        let style = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        var paragraphSpacing: CGFloat = 0
        if CTParagraphStyleGetValueForSpecifier(self, .paragraphSpacing, MemoryLayout<CGFloat>.size, &paragraphSpacing) {
            style.paragraphSpacing = paragraphSpacing
        }
        var alignment: CTTextAlignment = .center
        if CTParagraphStyleGetValueForSpecifier(self, .alignment, MemoryLayout<CTTextAlignment>.size, &alignment),
            let nsAlignment = NSTextAlignment(rawValue: UInt(alignment.rawValue)) {
            style.alignment = nsAlignment
        }
        var firstLineHeadIndent: CGFloat = 0
        if CTParagraphStyleGetValueForSpecifier(self, .firstLineHeadIndent, MemoryLayout<CGFloat>.size, &firstLineHeadIndent) {
            style.firstLineHeadIndent = firstLineHeadIndent
        }
        var headIndent: CGFloat = 0
        if CTParagraphStyleGetValueForSpecifier(self, .headIndent, MemoryLayout<CGFloat>.size, &headIndent) {
            style.headIndent = headIndent
        }
        var lineBreakMode: CTLineBreakMode = .byWordWrapping
        if CTParagraphStyleGetValueForSpecifier(self, .lineBreakMode, MemoryLayout<CTLineBreakMode>.size, &lineBreakMode),
            let nsValue = NSParagraphStyle.LineBreakMode(rawValue: UInt(lineBreakMode.rawValue)) {
            style.lineBreakMode = nsValue
        }
        var miniumLineHeight: CGFloat = 0
        if CTParagraphStyleGetValueForSpecifier(self, .minimumLineHeight, MemoryLayout<CGFloat>.size, &miniumLineHeight) {
            style.minimumLineHeight = miniumLineHeight
        }
        var baseWritingDirection: CTWritingDirection = .leftToRight
        if CTParagraphStyleGetValueForSpecifier(self, .baseWritingDirection, MemoryLayout<CTWritingDirection>.size, &baseWritingDirection),
            let nsValue = NSWritingDirection(rawValue: Int(baseWritingDirection.rawValue)) {
            style.baseWritingDirection = nsValue
        }
        var lineHeightMultiple: CGFloat = 0
        if CTParagraphStyleGetValueForSpecifier(self, .lineHeightMultiple, MemoryLayout<CGFloat>.size, &lineHeightMultiple) {
            style.lineHeightMultiple = lineHeightMultiple
        }
        var paragraphSpacingBefore: CGFloat = 0
        if CTParagraphStyleGetValueForSpecifier(self, .paragraphSpacingBefore, MemoryLayout<CGFloat>.size, &paragraphSpacingBefore) {
            style.paragraphSpacingBefore = paragraphSpacingBefore
        }
        var tabStops = [CoreText.CTTextTab]()
        if CTParagraphStyleGetValueForSpecifier(self, .tabStops, MemoryLayout<CFArray>.size, &tabStops) {
            style.tabStops = tabStops.map { tab -> NSTextTab? in
                if let alignment = NSTextAlignment(rawValue: UInt(CTTextTabGetAlignment(tab).rawValue)) {
                    let location = CGFloat(CTTextTabGetLocation(tab))
                    let options: [NSTextTab.OptionKey: Any] = CTTextTabGetOptions(tab) as? [NSTextTab.OptionKey : Any] ?? [:]
                    return NSTextTab(textAlignment: alignment, location: location, options: options)
                }
                return nil
            }.flatMap { $0 }
        }
        var defaultTabInterval: CGFloat = 0
        if CTParagraphStyleGetValueForSpecifier(self, .defaultTabInterval, MemoryLayout<CGFloat>.size, &defaultTabInterval) {
            style.defaultTabInterval = defaultTabInterval
        }
        return nil
    }
}
