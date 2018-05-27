//
//  MultipleType.swift
//  CodableTests
//
//  Created by Nick Lin on 2018/5/26.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import XCTest
@testable import Codable

class TestMultipleType: XCTestCase {

    func testMultiple01() {
        do {
            let data = try JSONSerialization.data(withJSONObject: [["count": 1], ["count": "2"]], options: .prettyPrinted)

            let models = try JSONDecoder().decode([MultipleType].self, from: data)
            XCTAssert(models[0].count == 1)
            XCTAssert(models[1].count == 2)
        } catch {
            XCTAssert(false)
        }
    }

    func testMultiple02() {
        do {
            let data = try JSONSerialization.data(withJSONObject: [["count": 1.2], ["count": "2.2"]], options: .prettyPrinted)

            let models = try JSONDecoder().decode([MultipleType].self, from: data)
            XCTAssert(models[0].count == 1)
            XCTAssert(models[1].count == 2)
        } catch {
            XCTAssert(false)
        }
    }

}
