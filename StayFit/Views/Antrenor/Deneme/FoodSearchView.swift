//
//  FoodSearchView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 26.12.2024.
//

import SwiftUI
struct FoodSearchView: View {
    @StateObject private var viewModel = FoodSearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Yemek ara...", text: $viewModel.searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: {
                        viewModel.search()
                    }) {
                        Text("Ara")
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
                
                if viewModel.foodItems.isEmpty {
                    Text("Sonuç yok").padding()
                } else {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 8) {
                            ForEach(viewModel.foodItems) { item in
                                NavigationLink(destination: FoodDetailView(foodItem: item)) {
                                    HStack(spacing: 12) {
                                        if let imageUrl = item.foodImages?.foodImage?.first?.imageUrl {
                                            AsyncImage(url: URL(string: imageUrl)) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            .frame(width: 60, height: 60)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                        } else {
                                            Image(systemName: "person.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 60, height: 60)
                                                .foregroundColor(.gray)
                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                        }
                                        
                                        VStack(alignment: .leading) {
                                            Text(item.foodName)
                                                .font(.headline)
                                                .foregroundColor(.primary)
                                            
                                            if let calories = item.servings.serving.first?.calories {
                                                Text("Kalori: \(calories)")
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                            }
                                        }
                                        Spacer()
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                                }
                                .buttonStyle(PlainButtonStyle()) // To remove default button styling
                            }
                        }
                        .padding()
                    }
                }
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Yemek Ara")
        }
    }
}


#Preview {
    FoodSearchView()
}
