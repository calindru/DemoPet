//
//  AnimalsView.swift
//  DemoPet
//
//  Created by Calin Drule on 10.02.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct AnimalsView: View {
    @ObservedObject var viewModelWrapper: DataViewModelWrapper<AnimalsData>
    
    var body: some View {
        NavigationView {
            List(viewModelWrapper.data?.animals ?? []) { animal in
                let viewModel = AnimalDetailsViewModel(id: animal.id)
                let wrapper = DataViewModelWrapper<AnimalDetailsData>(dataObservable: viewModel.animalDetailsObservable)
                NavigationLink(destination: AnimalDetailsView(viewModelWrapper: wrapper)) {
                    AnimalCellView(animal: animal)
                }
            }
        }
    }
}

struct AnimalCellView: View {
    let animal: AnimalData
    
    var body: some View {
        HStack {
            Text(animal.name)
            
            Spacer()
            
            Text(animal.species)
        }
    }
}

#Preview {
    let itemsViewModel = AnimalsViewModel()
    let viewModelWrapper = DataViewModelWrapper<AnimalsData>(dataObservable: itemsViewModel.animalsObservable)
    return AnimalsView(viewModelWrapper: viewModelWrapper)
}
