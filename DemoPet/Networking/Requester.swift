//
//  Requester.swift
//  DemoPet
//
//  Created by Calin Drule on 11.02.2024.
//

import Foundation
import RxSwift

class Requester {
    static var shared = Requester()
    
    let apiService: APIServiceProtocol = APIService()
    
    func getAnimals() -> Observable<AnimalsData> {
        apiService.fetch(request: .build(for: .getAnimals))
    }
    
    func getAnimalDetails(id: Int) -> Observable<AnimalDetailsData> {
        apiService.fetch(request: .build(for: .getAnimalDetails(id: id.description)))
    }
}
