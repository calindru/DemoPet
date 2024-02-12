//
//  AnimalsViewModel.swift
//  DemoPet
//
//  Created by Calin Drule on 12.02.2024.
//

import Foundation
import RxSwift

class AnimalsViewModel {
    var animalsObservable: Observable<AnimalsData> {
        Requester.shared.getAnimals()
    }
}
