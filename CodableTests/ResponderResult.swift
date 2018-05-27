//
//  ResponderResult.swift
//  CodableTests
//
//  Created by Nick Lin on 2018/5/5.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import XCTest
@testable import Codable

class TestResponderResult: XCTestCase {

    func testResultUser() {

        let resultUserCode = 200
        let resultUser: [String: Any] = ["id": 1, "name": "JJ"]

        do {
            let userData = try JSONSerialization.data(withJSONObject: ["code": resultUserCode, "data": resultUser], options: .prettyPrinted)

            let modelUser = try JSONDecoder().decode(ResponderResult.self, from: userData)
            switch modelUser {
            case .user(let value):
                XCTAssert(value.id == 1)
                XCTAssert(value.name == "JJ")
            default:
                XCTAssert(false)
            }
        } catch {
            XCTAssert(false)
        }

    }

    func testResultError() {

        let resultErrorCode = 201
        let resultError: [String: Any] = ["code": 404, "message": "請確認帳號密碼"]

        do {
            let errorData = try JSONSerialization.data(withJSONObject: ["code": resultErrorCode, "data": resultError], options: .prettyPrinted)

            let modelError = try JSONDecoder().decode(ResponderResult.self, from: errorData)
            switch modelError {
            case .error(let value):
                XCTAssert(value.code == 404)
                XCTAssert(value.message == "請確認帳號密碼")

            default:
                XCTAssert(false)
            }
        } catch {
            XCTAssert(false)
        }

    }

    func testResultEncode() {
        do {
            let resultUserCode = 200
            let resultUser: [String: Any] = ["id": 1, "name": "JJ"]
            let userData = try JSONSerialization.data(withJSONObject: ["code": resultUserCode, "data": resultUser], options: .prettyPrinted)
            let modelUser = try JSONDecoder().decode(ResponderResult.self, from: userData)
            switch modelUser {
            case .user(let value):
                XCTAssert(value.id == 1)
                XCTAssert(value.name == "JJ")
            default:
                XCTAssert(false)
            }

            let encodeData = try JSONEncoder().encode(modelUser)

            let encodeStrng = String(data: encodeData, encoding: .utf8)!
            XCTAssert(encodeStrng.first == "{")
            XCTAssert(encodeStrng.last == "}")
            XCTAssert(encodeStrng.contains("\"code\":200"))
            XCTAssert(encodeStrng.contains("\"data\""))
            XCTAssert(encodeStrng.contains("\"name\":\"JJ\""))
            XCTAssert(encodeStrng.contains("\"id\":1"))

            let model = try JSONDecoder().decode(ResponderResult.self, from: encodeData)
            switch model {
            case .user(let value):
                XCTAssert(value.id == 1)
                XCTAssert(value.name == "JJ")
            default:
                XCTAssert(false)
            }
        } catch {
            XCTAssert(false)
        }
    }

}
