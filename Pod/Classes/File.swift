//
//  Copyright 2016 Lionheart Software LLC
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation

public final class File {
    public var filename: String?

    var url: URL? {
        let manager = FileManager.default
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).last,
            let filename = filename else {
                return nil
        }

        return url.appendingPathComponent(filename)
    }

    public required init(filename: String) {
        self.filename = filename
    }

    public static var documentsPath: String? {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true).first
    }

    public static var documentsURL: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first
    }

    public var documentsPath: String? {
        guard let path = File.documentsPath,
            let filename = self.filename else {
                return nil
        }

        return (path as NSString).appendingPathComponent(filename)
    }

    public var bundlePath: String? {
        let bundle = Bundle.main
        guard let filename = filename else {
            return nil
        }

        let components = filename.components(separatedBy: ".")
        return bundle.path(forResource: components[0], ofType: components[1])
    }

    public func read() -> String? {
        guard let path = documentsPath ?? bundlePath else {
            return nil
        }

        return try? String(contentsOfFile: path, encoding: .utf8)
    }

    public var existsInBundle: Bool {
        guard let path = bundlePath else {
            return false
        }

        return FileManager.default.fileExists(atPath: path)
    }

    public var existsInDocuments: Bool {
        guard let path = documentsPath else {
            return false
        }

        return FileManager.default.fileExists(atPath: path)
    }
}

extension File: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    public typealias UnicodeScalarLiteralType = StringLiteralType

    public convenience init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.init(filename: value)
    }

    public convenience init(stringLiteral value: StringLiteralType) {
        self.init(filename: value)
    }

    public convenience init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.init(filename: value)
    }
}
