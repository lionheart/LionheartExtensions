//
//  File.swift
//  LionheartExtensions
//
//  Created by Daniel Loewenherz on 3/4/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation

final class File: StringLiteralConvertible {
    var filename: String?

    lazy var documentsPath: String? = {
        let paths: [NSString] = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        if let path = paths.first,
            filename = self.filename {
                return path.stringByAppendingPathComponent(filename)
        }
        else {
            return nil
        }
    }()

    var bundlePath: String? {
        let bundle = NSBundle.mainBundle()
        if let filename = filename {
            let components = filename.componentsSeparatedByString(".")
            return bundle.pathForResource(components[0], ofType: components[1])
        }
        else {
            return nil
        }
    }

    typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    typealias UnicodeScalarLiteralType = StringLiteralType

    init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        filename = value
    }

    init(stringLiteral value: StringLiteralType) {
        filename = value
    }

    init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        filename = value
    }

    func read() -> String? {
        if let path = documentsPath,
            contents = try? String(contentsOfFile: path, encoding: NSUTF8StringEncoding) {
                return contents
        }
        else if let path = bundlePath,
            contents = try? String(contentsOfFile: path, encoding: NSUTF8StringEncoding) {
                return contents
        }
        else {
            return nil
        }
    }

    func existsInBundle() -> Bool {
        let manager = NSFileManager.defaultManager()

        guard let path = bundlePath else {
            return false
        }

        return manager.fileExistsAtPath(path)
    }

    func existsInDocuments() -> Bool {
        let manager = NSFileManager.defaultManager()

        guard let path = documentsPath else {
            return false
        }

        return manager.fileExistsAtPath(path)
    }
}