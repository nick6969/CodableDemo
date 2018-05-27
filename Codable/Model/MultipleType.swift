//
//  MultipleType.swift
//  Codable
//
//  Created by Nick Lin on 2018/5/26.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

struct MultipleType: Codable {
    var count: Int

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let val = try? values.decode(String.self, forKey: CodingKeys.count) {
            if let value = Int(val) {
                count = value
            } else if let value = Double(val) {
                count = Int(value)
            } else {
                throw DecodingError.typeMismatch(MultipleType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for MultipleType.count"))
            }
        } else if let val = try? values.decode(Int.self, forKey: CodingKeys.count) {
            count = val
        } else if let val = try? values.decode(Double.self, forKey: CodingKeys.count) {
            count = Int(val)
        } else {
            throw DecodingError.typeMismatch(MultipleType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for MultipleType.count"))
        }
    }

}
