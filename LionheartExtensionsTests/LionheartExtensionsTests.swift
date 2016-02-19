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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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

    func testInt() {
        expect(30.scaledToDeviceWidth(300)) == 41.4
    }
}
