//
//  ResponderData.swift
//  CodableTests
//
//  Created by Nick Lin on 2018/5/28.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

import XCTest
@testable import Codable

class TestResponderData: XCTestCase {

    func testResponderDataUser() {
        do {
            let resultCode = 200
            let resultData: [String: Any] = ["id": 1, "name": "JJ"]
            let userData = try JSONSerialization.data(withJSONObject: ["code": resultCode, "data": resultData], options: .prettyPrinted)
            let model = try JSONDecoder().decode(ResponderData.self, from: userData)
            XCTAssert(model.code == 200)
            XCTAssert(model.dic.keys.count == 2)
            XCTAssert(model.dic["id"] as? Int == 1)
            XCTAssert(model.dic["name"] as? String == "JJ")
        } catch {
            XCTAssert(false)
        }
    }

    func testResultDataError() {
        do {
            let resultCode = 201
            let resultData: [String: Any] = ["code": 404, "message": "請確認帳號密碼"]
            let userData = try JSONSerialization.data(withJSONObject: ["code": resultCode, "data": resultData], options: .prettyPrinted)
            let model = try JSONDecoder().decode(ResponderData.self, from: userData)
            XCTAssert(model.code == 201)
            XCTAssert(model.dic.keys.count == 2)
            XCTAssert(model.dic["code"] as? Int == 404)
            XCTAssert(model.dic["message"] as? String == "請確認帳號密碼")
        } catch {
            XCTAssert(false)
        }
    }

    func testResultDataContent() {
        do {
            let resultCode = 999
            let resultData: [String: Any] = ["message": ["AA", "BB"], "success": false, "data": ["AA": 1, "BB": 2]]
            let userData = try JSONSerialization.data(withJSONObject: ["code": resultCode, "data": resultData], options: .prettyPrinted)
            let model = try JSONDecoder().decode(ResponderData.self, from: userData)
            XCTAssert(model.code == 999)
            XCTAssert(model.dic.keys.count == 3)
            if let array = model.dic["message"] as? [String] {
                XCTAssert(array[0] == "AA")
                XCTAssert(array[1] == "BB")
            } else {
                XCTAssert(false)
            }

            if let success = model.dic["success"] as? Bool {
                XCTAssert(!success)
            } else {
                XCTAssert(false)
            }

            if let data = model.dic["data"] as? [String: Any] {
                XCTAssert(data.keys.count == 2)
                XCTAssert(data["AA"] as? Int == 1)
                XCTAssert(data["BB"] as? Int == 2)
            } else {
                XCTAssert(false)
            }
        } catch {
            XCTAssert(false)
        }
    }
}
