//
//  LionheartExtensionsTests.swift
//  LionheartExtensionsTests
//
//  Created by Daniel Loewenherz on 2/18/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import XCTest
import Nimble
@testable import LionheartExtensions

class LionheartExtensionsTests: XCTestCase {
    func testDate() {
        let aLongTimeAgo = Date.distantPast
        let theFuture = Date.distantFuture

        expect(aLongTimeAgo) < theFuture
        expect(aLongTimeAgo) <= theFuture
        expect(theFuture) > aLongTimeAgo
        expect(theFuture) >= aLongTimeAgo
        expect(aLongTimeAgo) == aLongTimeAgo
    }
    
    func testString() {
        let string = "1234"
        let rangeA = string.range
        let rangeB = NSRange(location: 0, length: 4)

        expect(rangeA.length) == rangeB.length
        expect(rangeA.location) == rangeA.location

        let sentence = "the quick brown fox jumped over the lazy dog"
        expect(sentence.stringByUppercasingFirstLetter) == "The quick brown fox jumped over the lazy dog"
        expect(sentence.stringByLowercasingFirstLetter) == sentence
    }

    func testFont() {
        let font = UIFont.systemFont(ofSize: 12)

        let displayName = font.displayName
        expect(displayName) == ".SFUIText"
    }

    func testColor() {
        let red = UIColor(0xF00)
        expect(red) == UIColor.red

        let green = UIColor(0x0F0)
        expect(green) == UIColor.green

        let blue = UIColor(0x00F)
        expect(blue) == UIColor.blue
    }

    func testToRGBA() {
        var r: CGFloat!
        var g: CGFloat!
        var b: CGFloat!
        var a: CGFloat!
        0xFF0000.toRGBA(&r, &g, &b, &a)

        expect(r) == 1
        expect(g) == 0
        expect(b) == 0
        expect(a) == 1
    }

    func testImage() {
        guard let image = UIImage(color: .red),
            let data = UIImagePNGRepresentation(image) else {
                fatalError()
        }

        let string = data.base64EncodedString()
        expect(string) == "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAA1JREFUCB1j+M/A8B8ABQAB/8gPYhYAAAAASUVORK5CYII="

        guard let newData = Data(base64Encoded: string),
            let newImage = UIImage(data: newData) else {
            fatalError()
        }

        expect(newImage.size) == CGSize(width: 1, height: 1)

        let view = UIView()
        view.backgroundColor = .red
        view.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
        let viewImage = UIImage(view: view, scale: 1)!
        guard let viewImageData = UIImagePNGRepresentation(viewImage) else {
            fatalError()
        }

        expect(viewImageData) == data
    }

    func testFunctional() {
        let noTrueBool: [Bool?] = [false, false, false]
        let oneTrueBool: [Bool?] = [false, false, true]
        let twoTrueBool: [Bool?] = [false, true, true]
        let allTrueBool: [Bool?] = [true, true, true]

        let noTrueString: [String?] = [nil, "", "", ""]
        let oneTrueString: [String?] = [nil, "", "", "one"]
        let twoTrueString: [String?] = ["", "one", "two"]
        let allTrueString: [String?] = ["one", "two", "three"]

        let noTrueInt: [Int?] = [nil, 0, -1, -100]
        let oneTrueInt: [Int?] = [nil, 0, 0, 1]
        let twoTrueIntA: [Int?] = [0, 1, 10]
        let twoTrueIntB: [Int?] = [0, 10, 20]
        let allTrueInt: [Int?] = [1, 10, 100]

        let noTrueMix: [Any?] = [nil, 0, false, ""]
        let oneTrueMixA: [Any?] = [nil, 1, false, ""]
        let oneTrueMixB: [Any?] = [0, true, ""]
        let oneTrueMixC: [Any?] = [0, false, "one"]

        expect(all(noTrueBool)) == false
        expect(all(oneTrueBool)) == false
        expect(all(twoTrueBool)) == false
        expect(all(allTrueBool)) == true

        expect(any(noTrueBool)) == false
        expect(any(oneTrueBool)) == true
        expect(any(twoTrueBool)) == true
        expect(any(allTrueBool)) == true

        expect(all(noTrueString)) == false
        expect(all(oneTrueString)) == false
        expect(all(twoTrueString)) == false
        expect(all(allTrueString)) == true

        expect(any(noTrueString)) == false
        expect(any(oneTrueString)) == true
        expect(any(twoTrueString)) == true
        expect(any(allTrueString)) == true

        expect(all(noTrueInt)) == false
        expect(all(oneTrueInt)) == false
        expect(all(twoTrueIntA)) == false
        expect(all(twoTrueIntB)) == false
        expect(all(allTrueInt)) == true

        expect(any(noTrueInt)) == false
        expect(any(oneTrueInt)) == true
        expect(any(twoTrueIntA)) == true
        expect(any(twoTrueIntB)) == true
        expect(any(allTrueInt)) == true

        expect(all(noTrueMix)) == false
        expect(all(oneTrueMixA)) == false
        expect(all(oneTrueMixB)) == false
        expect(all(oneTrueMixC)) == false

        expect(any(noTrueMix)) == false
        expect(any(oneTrueMixA)) == true
        expect(any(oneTrueMixB)) == true
        expect(any(oneTrueMixC)) == true
    }
}
