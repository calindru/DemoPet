//
//  TokenData.swift
//  DemoPet
//
//  Created by Calin Drule on 11.02.2024.
//

import Foundation

struct TokenData: Decodable {
    let token_type: String
    let expires_in: Int
    let access_token: String
}
