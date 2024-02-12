//
//  DemoPetApp.swift
//  DemoPet
//
//  Created by Calin Drule on 10.02.2024.
//

import SwiftUI

@main
struct DemoPetApp: App {
    var body: some Scene {
        WindowGroup {
            let itemsViewModel = AnimalsViewModel()
            let viewModelWrapper = AnimalsViewModelWrapper(animalsObservable: itemsViewModel.animalsObservable)
            AnimalsView(viewModelWrapper: viewModelWrapper)
        }
    }
}
