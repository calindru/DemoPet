//
//  AnimalDetailsViewModel.swift
//  DemoPet
//
//  Created by Calin Drule on 12.02.2024.
//

import Foundation
import RxSwift

class AnimalDetailsViewModel {
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var animalDetailsObservable: Observable<AnimalDetailsData> {
        Requester.shared.getAnimalDetails(id: id)
    }
}
