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
        let aLongTimeAgo = NSDate.distantPast()
        let theFuture = NSDate.distantFuture()

        expect(aLongTimeAgo) < theFuture
        expect(aLongTimeAgo) <= theFuture
        expect(theFuture) > aLongTimeAgo
        expect(theFuture) >= aLongTimeAgo
        expect(aLongTimeAgo) == aLongTimeAgo
    }
    
    func testString() {
        let string = "1234"
        let rangeA = string.range()
        let rangeB = NSRange(location: 0, length: 4)

        expect(rangeA.length) == rangeB.length
        expect(rangeA.location) == rangeA.location
    }

    func testFont() {
        let font = UIFont.systemFontOfSize(12)

        do {
            let displayName = try font.displayName()
            expect(displayName) == ".SFUIText Regular"
        }
        catch {
            XCTAssert(false)
        }
    }

    func testColor() {
        let red = UIColor(hex: 0xFF0000FF)
        expect(red) == UIColor.redColor()

        let green = UIColor(hex: 0x00FF00FF)
        expect(green) == UIColor.greenColor()

        let blue = UIColor(hex: 0x0000FFFF)
        expect(blue) == UIColor.blueColor()
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

        let noTrueMix: [AnyObject?] = [nil, 0, false, ""]
        let oneTrueMixA: [AnyObject?] = [nil, 1, false, ""]
        let oneTrueMixB: [AnyObject?] = [0, true, ""]
        let oneTrueMixC: [AnyObject?] = [0, false, "one"]

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
