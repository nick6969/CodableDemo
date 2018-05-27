//
//  Quality.swift
//  CodableTests
//
//  Created by Nick Lin on 2018/5/26.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import XCTest
@testable import Codable

class TestQualityType: XCTestCase {

    func testQuality() {

        do {
            let data = try JSONSerialization.data(withJSONObject: ["good", "bad", "GG"], options: .prettyPrinted)

            let models = try JSONDecoder().decode([Quality].self, from: data)

            switch models[0] {
            case .good:
                XCTAssert(true)
            default:
                XCTAssert(false)
            }

            switch models[1] {
            case .bad:
                XCTAssert(true)
            default:
                XCTAssert(false)
            }

            switch models[2] {
            case .default(let value):
                XCTAssert(value == "GG")
            default:
                XCTAssert(false)
            }

            let encodeData = try JSONEncoder().encode(models)

            let encodeArray = try JSONSerialization.jsonObject(with: encodeData, options: .mutableContainers ) as? [String]
            XCTAssert(encodeArray?[0] == "good")
            XCTAssert(encodeArray?[1] == "bad")
            XCTAssert(encodeArray?[2] == "GG")

        } catch {
            XCTAssert(false)
        }
    }

    func testQualityErrorType() {
        do {
            let data = try JSONSerialization.data(withJSONObject: ["good", "bad", 123], options: .prettyPrinted)
            _ = try JSONDecoder().decode([Quality].self, from: data)
            XCTAssert(false)
        } catch {
            XCTAssert(true)
        }
    }
}
