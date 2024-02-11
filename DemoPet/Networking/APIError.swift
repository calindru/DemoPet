//
//  APIError.swift
//  DemoPet
//
//  Created by Calin Drule on 11.02.2024.
//

import Foundation

enum APIError: Error {
    case badURL
    case encodingFailed
    case noDataReceived
}
