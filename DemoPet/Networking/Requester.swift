//
//  Requester.swift
//  DemoPet
//
//  Created by Calin Drule on 11.02.2024.
//

import Foundation
import OAuthSwift
import RxSwift

class Requester {
    static var shared = Requester()
    
    let apiService: APIServiceProtocol = APIService()
    
    func getAnimals() -> Observable<AnimalData> {
        apiService.fetch(request: .build(for: .getAnimals))
    }
}
