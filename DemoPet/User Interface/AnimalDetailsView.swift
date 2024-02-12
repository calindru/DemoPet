//
//  AnimalDetailsView.swift
//  DemoPet
//
//  Created by Calin Drule on 12.02.2024.
//

import SwiftUI
import SDWebImageSwiftUI

private extension Constants {
    static let cellIconSize = CGFloat(80)
}

struct AnimalDetailsView: View {
    @ObservedObject var viewModelWrapper: DataViewModelWrapper<AnimalDetailsData>
    
    var body: some View {
        if let animalDetails = viewModelWrapper.data {
            let animal = animalDetails.animal
            let padding = CGFloat(20)
            
            Text(animal.name)
                .font(.largeTitle)
                .padding(.vertical, padding)
             
            AnimalDetailView(detailCaption: "Breed", animalDetail: animal.breeds.primary, font: .title)
                .padding(.vertical, padding)

            AnimalDetailView(detailCaption: "Size", animalDetail: animal.size, font: .title)
                .padding(.vertical, padding)
            
            AnimalDetailView(detailCaption: "Gender", animalDetail: animal.gender.rawValue, font: .title)
                .padding(.vertical, padding)
            
            AnimalDetailView(detailCaption: "Status", animalDetail: animal.status, font: .title)
                .padding(.vertical, padding)
            
            AnimalDetailView(detailCaption: "Distance", animalDetail: animal.distance?.description ?? "-", font: .title)
                .padding(.vertical, padding)
            
            Spacer()
        } else {
            EmptyView()
        }
    }
}

struct AnimalDetailView: View {
    let detailCaption: String
    let animalDetail: String
    let font: Font
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(detailCaption)
                    .foregroundStyle(.gray)
                Text(animalDetail)
                    .font(font)
            }
            
            Spacer()
        }
        .padding(.leading, 20)
    }
}

#Preview {
    let itemsViewModel = AnimalDetailsViewModel(id: 70700899)
    let viewModelWrapper = DataViewModelWrapper<AnimalDetailsData>(dataObservable: itemsViewModel.animalDetailsObservable)
    return AnimalDetailsView(viewModelWrapper: viewModelWrapper)
}
