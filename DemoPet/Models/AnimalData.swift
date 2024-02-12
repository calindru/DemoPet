//
//  AnimalData.swift
//  DemoPet
//
//  Created by Calin Drule on 11.02.2024.
//

import Foundation

struct AnimalsData: Decodable {
    let animals: [AnimalData]
}

struct AnimalData: Decodable {
    let id: Int
    let url: String
    let type: String // TODO: change to enum
    let species: String
    let breeds: BreedsData
}

extension AnimalData: Identifiable {}
