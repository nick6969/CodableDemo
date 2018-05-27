//
//  ResponderData.swift
//  Codable
//
//  Created by Nick Lin on 2018/5/28.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import Foundation

struct ResponderData: Decodable {
    let code: Int
    let dic: [String: Any]

    private enum CodingKeys: String, CodingKey {
        case code
        case data
    }

    init(from decoder: Decoder) throws {
        let vals = try decoder.container(keyedBy: CodingKeys.self)
        code = try vals.decode(Int.self, forKey: .code)
        dic = try vals.decode([String : Any].self, forKey: .data)
    }
}
