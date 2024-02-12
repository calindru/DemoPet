//
//  AnimalsViewModelWrapper.swift
//  DemoPet
//
//  Created by Calin Drule on 12.02.2024.
//

import Foundation
import SwiftUI
import RxSwift

class AnimalsViewModelWrapper: ObservableObject {
    @Published var animals: [AnimalData] = []
    
    private var disposeBag = DisposeBag()
    
    init(animalsObservable: Observable<AnimalsData>) {
        animalsObservable
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] animals in
                self?.animals = animals.animals
            })
            .disposed(by: disposeBag)
    }
}
