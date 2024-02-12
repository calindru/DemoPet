//
//  BreedsData.swift
//  DemoPet
//
//  Created by Calin Drule on 11.02.2024.
//

import Foundation

struct BreedsData: Decodable {
    let primary: String
    let secondary: String?
    let mixed: Bool
    let unknown: Bool
}
