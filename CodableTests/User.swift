//
//  User.swift
//  CodableTests
//
//  Created by Nick Lin on 2018/5/26.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import XCTest
@testable import Codable

class TestUser: XCTestCase {

    func testUserOptional() {
        let dics = [["name": "nick", "picture": "001.jpg"], ["name": "jojo"]]

        do {
            let data = try JSONSerialization.data(withJSONObject: dics, options: .prettyPrinted)

            let models = try JSONDecoder().decode([UserOptional].self, from: data)
            XCTAssert(models[0].name == "nick")
            XCTAssert(models[0].picture == "001.jpg")
            XCTAssert(models[1].name == "jojo")
            XCTAssert(models[1].picture == nil)
        } catch {
            XCTAssert(false)
        }
    }

    func testUser() {
        let dics = [["name": "nick", "picture": "001.jpg"], ["name": "jojo"]]

        do {
            let data = try JSONSerialization.data(withJSONObject: dics, options: .prettyPrinted)

            let models = try JSONDecoder().decode([User].self, from: data)
            XCTAssert(models[0].name == "nick")
            XCTAssert(models[0].picture == "001.jpg")
            XCTAssert(models[1].name == "jojo")
            XCTAssert(models[1].picture == "")
        } catch {
            XCTAssert(false)
        }
    }
}
