//
//  APIEndpoint.swift
//  DemoPet
//
//  Created by Calin Drule on 11.02.2024.
//

import Foundation

enum APIConstants {
    static let baseURL = "https://api.petfinder.com/v2/"
    static let apiKey = "8FvB92COL3loJkRHBozGPLOVKZTG4CgXal6Dou6EjsH5lj2SXB"
    static let apiSecret = "zcYSA3CrhG6yW1dc539o8rAVgj7ecwLUaYHTSe3s"
}

enum APIEndpoint {
    // Authentication
    case getToken
    
    // Content
    case getAnimals
    case getAnimalDetails(id: String)
    
    var url: URL {
        var url = URL(string: APIConstants.baseURL)!
        
        switch self {
            // Authentication
        case .getToken:
            url.append(path: "oauth2/token")
            
            // Content
        case .getAnimals:
            url.append(path: "animals")
        case .getAnimalDetails(let id):
            url.append(path: "animals")
            url.append(queryItems: [
                URLQueryItem(name: "id", value: id)
            ])
        }
        
        return url
    }
}
