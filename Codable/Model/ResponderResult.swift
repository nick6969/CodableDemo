//
//  ResponderResult.swift
//  Codable
//
//  Created by Nick Lin on 2018/5/26.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

struct UserData: Codable {
    var id: Int
    var name: String
}

struct ErrorMessage: Codable {
    var code: Int
    var message: String
}

enum ResponderResult: Codable {
    case error(ErrorMessage)
    case user(UserData)

    private enum CodingKeys: String, CodingKey {
        case code
        case data
    }
    
    init(from decoder: Decoder) throws {
        let vals = try decoder.container(keyedBy: CodingKeys.self)
        let code = try vals.decode(Int.self, forKey: CodingKeys.code)
        switch code {
        case 200:
            let value = try vals.decode(UserData.self, forKey: CodingKeys.data)
            self = .user(value)
        case 201:
            let value = try vals.decode(ErrorMessage.self, forKey: CodingKeys.data)
            self = .error(value)
        default:
            throw DecodingError.typeMismatch(ResponderResult.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ResponderResult"))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .user(let value):
            try container.encode(200, forKey: .code)
            try container.encode(value, forKey: .data)
        case .error(let value):
            try container.encode(201, forKey: .code)
            try container.encode(value, forKey: .data)
        }
    }
}
