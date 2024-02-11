//
//  JSONData.swift
//  DemoPet
//
//  Created by Calin Drule on 11.02.2024.
//

import Foundation

struct JSONData<T: Decodable>: Decodable {
    let JSON: T
}
