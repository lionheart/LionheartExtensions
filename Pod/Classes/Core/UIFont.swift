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
//

import Foundation

public extension UIFont {
    /**
     Returns a display name for a given `UIFont`.
     
     - throws: A regular expression error, if a match cannot be found.
     - returns: A `String` representing the font name.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func displayName() throws -> String {
        let expression = try NSRegularExpression(pattern: "([a-z])([A-Z])", options: NSRegularExpression.Options())
        let fontName = NSMutableString(string: self.fontName)
        expression.replaceMatches(in: fontName, options: NSRegularExpression.MatchingOptions(), range: fontName.range(), withTemplate: "$1 $2")
        let components = fontName.components(separatedBy: "-")
        return components.joined(separator: " ")
    }
}
