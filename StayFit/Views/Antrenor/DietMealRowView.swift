//
//  DietMealRowView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 7.12.2024.
//

import SwiftUI

struct DietMealRowView: View {
    let meal: DietMeal
    var onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(meal.foodName)
                    .font(.subheadline)
                    .foregroundColor(.white)
                Spacer()
                HStack(spacing: 10) {
                    Image(systemName: "pencil")
                        .foregroundColor(.white)
                    Button {
                        onDelete()
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.white)
                    }
                }
            }

            HStack {
                VStack(alignment: .leading, spacing: 3) { // Boşlukları azalt
                    Text("\(meal.portion, specifier: "%.f") \(meal.unit)")
                        .font(.footnote) // Yazı boyutunu daha da küçült
                        .foregroundColor(.gray)
                    Text("\(meal.calories, specifier: "%.f") kcal")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 3) { // Boşlukları azalt
                    Text("Karbonhidrat: \(meal.carbs, specifier: "%.f") g")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Text("Protein: \(meal.protein, specifier: "%.f") g")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Text("Yağ: \(meal.fat, specifier: "%.f") g")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            
            Divider()
                .background(Color.gray)
        }
        .padding(15) // Padding'i azalt
        .background(
            RoundedRectangle(cornerRadius: 8) // Köşe yarıçapını azalt
                .fill(Color.black.opacity(0.8))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8) // Köşe yarıçapını azalt
                .stroke(Color.gray, lineWidth: 1) // Çizgi kalınlığını azalt
        )
    }
}


struct DietMealRowView_Previews: PreviewProvider {
    static var previews: some View {
        DietMealRowView(meal: DietMeal(
            id: 0,
            dietDayId: 1,
            mealType: 1,
            foodName: "Tavuk Göğsü",
            portion: 150.0,
            unit: "gram",
            calories: 165.0,
            carbs: 0.0,
            protein: 31.0,
            fat: 3.6
        ), onDelete: {
            print("Silme işlemi çağrıldı!")
        })
        .padding()
    }
}

struct DietMealRowViewForMember: View {
    let meal: DietMeal

    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) { // Boşlukları azalt
            // Başlık ve Kalori
            HStack {
                Text(meal.foodName)
                    .font(.subheadline) // Başlık boyutunu küçült
                    .foregroundColor(.white)
                Spacer()
                
            }
            
            // Besin Bilgileri
            HStack {
                VStack(alignment: .leading, spacing: 3) { // Boşlukları azalt
                    Text("\(meal.portion, specifier: "%.f") \(meal.unit)")
                        .font(.footnote) // Yazı boyutunu daha da küçült
                        .foregroundColor(.gray)
                    Text("\(meal.calories, specifier: "%.f") kcal")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 3) { // Boşlukları azalt
                    Text("Karbonhidrat: \(meal.carbs, specifier: "%.f") g")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Text("Protein: \(meal.protein, specifier: "%.f") g")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Text("Yağ: \(meal.fat, specifier: "%.f") g")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            
            Divider()
                .background(Color.gray)
        }
        .padding(15) // Padding'i azalt
        .background(
            RoundedRectangle(cornerRadius: 8) // Köşe yarıçapını azalt
                .fill(Color.black.opacity(0.8))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8) // Köşe yarıçapını azalt
                .stroke(Color.gray, lineWidth: 1) // Çizgi kalınlığını azalt
        )
    }
}
