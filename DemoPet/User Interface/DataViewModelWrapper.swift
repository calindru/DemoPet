//
//  DataViewModelWrapper.swift
//  DemoPet
//
//  Created by Calin Drule on 12.02.2024.
//

import Foundation
import RxSwift

class DataViewModelWrapper<D: Decodable>: ObservableObject {
    @Published var data: D?
    
    private var disposeBag = DisposeBag()
    
    init(dataObservable: Observable<D>) {
        dataObservable
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] data in
                self?.data = data
            })
            .disposed(by: disposeBag)
    }
}
