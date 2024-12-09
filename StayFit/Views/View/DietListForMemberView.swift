//
//  DietListForMemberView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 9.12.2024.
//

import SwiftUI


struct DietListForMemberView: View {
    @StateObject var viewModel = DietListModelView()
    var workoutdays: DietDays
    @Environment(\.dismiss) var dismiss
    
    private func mealTypeDescription(_ mealType: Int) -> String {
        switch mealType {
        case 0: return "1. Öğün"
        case 1: return "2. Öğün"
        case 2: return "3. Öğün"
        case 3: return "4. öğün"
        default: return "Bilinmiyor"
        }
    }
    
    private var groupedDietMeals: [String: [DietMeal]] {
        Dictionary(grouping: viewModel.dietmeals.sorted(by: { $0.mealType < $1.mealType })) {
            mealTypeDescription($0.mealType)
        }
    }

    private func totalCalories(for meals: [DietMeal]) -> Int {
        Int(meals.reduce(0) { $0 + $1.calories }) // Assuming DietMeal has a 'calories' property
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(groupedDietMeals.keys.sorted(), id: \.self) { key in
                        Section(header: Text(key).font(.headline).padding(.vertical)) {
                            let meals = groupedDietMeals[key] ?? []
                            ForEach(meals, id: \.id) { diet in
                                NavigationLink(destination: DietMealDetailView(meal: diet).navigationBarBackButtonHidden(true)
                                   
                                ) {
                                    DietMealRowViewForMember(meal: diet)
                                     
                                }
                                .padding(.horizontal, 5)
                            }
                            Text("Toplam Kalori: \(totalCalories(for: meals))")
                                .font(.subheadline)
                                .padding(.horizontal, 5)
                        }
                    }
                    
                   
                        let overallTotalCalories = viewModel.dietmeals.reduce(0) { $0 + $1.calories }
                        Text("Tüm Öğünlerin Toplam Kalorisi: \(String(format: "%.1f", overallTotalCalories))")
                            .font(.headline)
                            .padding()
                    
                }
                .padding()
            }
            .navigationTitle("Diet Listesi")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
            .onAppear {
                viewModel.dietId = workoutdays.id
                viewModel.fetchDiets(for: workoutdays.id)
            }
        }
    }
}
#Preview {
    DietListForMemberView( workoutdays: DietDays(id: 1, title: "Bacak", dayOfWeek: 0, isCompleted: false))
}
