//
//  Quality.swift
//  Codable
//
//  Created by Nick Lin on 2018/5/26.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

enum Quality: Codable {
    case good
    case bad
    case `default`(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(String.self) {
            switch value {
            case "good":
                self = .good
            case "bad":
                self = .bad
            default:
                self = .default(value)
            }
        } else {
            throw DecodingError.typeMismatch(Quality.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Quality"))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .default(let value):
            try container.encode(value)
        case .good:
            try container.encode("good")
        case .bad:
            try container.encode("bad")
        }
    }
}
