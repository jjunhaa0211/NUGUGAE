//
//  TokenModel.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/06/27.
//

import Foundation

struct TokenModel: Codable {
    let access_token: String
    let resfresh_token: String
    
    
    enum CodingKeys : String, CodingKey{
        case access_token = "access-token"
        case resfresh_token = "refresh-token"
    }
}
