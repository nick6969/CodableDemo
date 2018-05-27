//
//  User.swift
//  Codable
//
//  Created by Nick Lin on 2018/5/26.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

struct UserOptional: Codable {
    let name: String
    var picture: String?
}

struct User: Codable {
    let name: String
    let picture: String

    init(from decoder: Decoder) throws {
        let vals = try decoder.container(keyedBy: CodingKeys.self)
        name = try vals.decode(String.self, forKey: CodingKeys.name)
        if let val = try? vals.decode(String.self, forKey: CodingKeys.picture) {
            picture = val
        } else {
            picture = ""
        }
    }
}
