//
//  DraftTextArchiver.swift
//  DraftSwift-MacOS
//
//  Created by modao on 2018/3/6.
//  Copyright © 2018年 MockingBot. All rights reserved.
//

import Foundation

var CTFRunDelegate: CFTypeID = {
    var typeID: CFTypeID = CFTypeID(kCFNotFound)
    let delegate = DraftRunDelegate()
    if let runDelegate = delegate.cfRunDelegate {
        typeID = CFGetTypeID(runDelegate)
    }
    return typeID
}()

var CTRubyAnnotationTypeID: CFTypeID = {
    var typeID: CFTypeID = 0
    if CTRubyAnnotationGetTypeID() + 1 > 1 {
        typeID = CTFRunDelegate
    } else {
        typeID = CFTypeID(kCFNotFound)
    }
    return typeID
}()

public class DraftTextArchiver: NSKeyedArchiver, NSKeyedArchiverDelegate {

    public override init() {
        super.init()
        delegate = self
    }

    public override init(forWritingWith data: NSMutableData) {
        super.init(forWritingWith: data)
        self.delegate = self
    }

    public func archiver(_ archiver: NSKeyedArchiver, willEncode object: Any) -> Any? {
        let typeID = CFGetTypeID(object as CFTypeRef)
        if typeID == CTRubyAnnotationTypeID {
            return CTRunDelegateGetRefCon(object as! CTRunDelegate)
        } else if typeID == CTRubyAnnotationGetTypeID() {
            return DraftRubyAnnotation(ctRuby: (object as! CTRubyAnnotation))
        } else {
            return object
        }
    }

    override public class func archivedData(withRootObject: Any) -> Data {
        let data = NSMutableData()
        let archiver = DraftTextArchiver(forWritingWith: data)
        archiver.encodeRootObject(withRootObject)
        archiver.finishEncoding()
        return data as Data
    }

    class func archiveData(rootObject: AnyObject, toFile path: String) throws {
        let data = NSKeyedArchiver.archivedData(withRootObject: rootObject)
        try data.write(to: URL(fileURLWithPath: path), options: .atomic)
    }
}

public class DraftTextUnarchinver: NSKeyedUnarchiver, NSKeyedUnarchiverDelegate {
    public override init() {
        super.init()
        delegate = self
    }
    public override init(forReadingWith data: Data) {
        super.init(forReadingWith: data)
        delegate = self
    }
    override public class func unarchiveObject(with: Data) -> Any? {
        guard !with.isEmpty else { return nil }
        let unarchiver = DraftTextUnarchinver(forReadingWith: with)
        return unarchiver.decodeObject()
    }
    override public class func unarchiveObject(withFile path: String) -> Any? {
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return nil }
        return unarchiveObject(with: data)
    }
    public func unarchiver(_ unarchiver: NSKeyedUnarchiver, didDecode object: Any?) -> Any? {
        if let runDelegate = object as? DraftRunDelegate {
            return runDelegate.cfRunDelegate
        } else if let ct = object as? DraftRubyAnnotation {
            return ct.rubyAnnotation
        } else {
            return object
        }
    }
}
