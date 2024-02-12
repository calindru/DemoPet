//
//  AnimalDetailsData.swift
//  DemoPet
//
//  Created by Calin Drule on 12.02.2024.
//

import Foundation

enum Gender: String, Decodable {
    case male = "Male"
    case female = "Female"
}

struct AnimalDetailsData: Decodable {
    let animal: AnimalInfoData
}

struct AnimalInfoData: Decodable {
    let id: Int
    let url: URL
    let type: String
    let species: String
    let breeds: BreedsData
    let colors: ColorsData
    let age: String
    let gender: Gender
    let size: String
    let name: String
    let status: String
    let distance: Double?
}
