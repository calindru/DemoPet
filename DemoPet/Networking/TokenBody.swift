//
//  TokenBody.swift
//  DemoPet
//
//  Created by Calin Drule on 11.02.2024.
//

import Foundation

struct TokenBody: Encodable {
    let client_id: String
    let client_secret: String
    let grant_type = "client_credentials"
}
