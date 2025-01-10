//
//  Fatsecret.swift
//  StayFit
//
//  Created by İmat Gökaslan on 26.12.2024.
//

import Foundation
import Combine
import SwiftUI

class FoodSearchViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var foodItems: [FoodItem] = []
    private var cancellables = Set<AnyCancellable>() 
    func search() {
        guard !searchQuery.isEmpty else {
            foodItems = []
            return
        }
        fetchFoodItems(for: searchQuery)
    }
    
    private func fetchFoodItems(for query: String) {
        let urlString = "\(APIConfig.baseURL)/api/Tests?foodName=\(query)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [FoodItem].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Hata: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] items in
                self?.foodItems = items
            })
            .store(in: &cancellables)
    }
}


struct FoodItem: Identifiable, Codable {
    var id: String { foodId }
    let foodId: String
    let foodName: String
    let foodType: String
    let foodUrl: String?
    let brandName: String?
    let foodImages: FoodImages?
    let servings: Servings
}

struct FoodImages: Codable {
    let foodImage: [FoodImage]?
}

struct FoodImage: Codable {
    let imageUrl: String
    let imageType: String
}

struct Servings: Codable {
    let serving: [Serving]
}

struct Serving: Codable {
    let metricServingUnit : String?
    let numberOfUnits : String?
    let servingDescription: String
    let calories: String
    let carbohydrate: String
    let protein: String
    let fat: String
}
