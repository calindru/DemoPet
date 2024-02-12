//
//  AnimalsView.swift
//  DemoPet
//
//  Created by Calin Drule on 10.02.2024.
//

import SwiftUI

struct AnimalsView: View {
    @ObservedObject var viewModelWrapper: AnimalsViewModelWrapper
    
    var body: some View {
        List(viewModelWrapper.animals) { animal in
            Text(animal.species)
        }
        .onAppear {
            
        }
        .onTapGesture {
            
        }
    }
}

#Preview {
    let itemsViewModel = AnimalsViewModel()
    let viewModelWrapper = AnimalsViewModelWrapper(animalsObservable: itemsViewModel.animalsObservable)
    return AnimalsView(viewModelWrapper: viewModelWrapper)
}
