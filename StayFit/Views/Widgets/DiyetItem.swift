//
//  DiyetItem.swift
//  StayFit
//
//  Created by İmat Gökaslan on 8.10.2024.
//

import SwiftUI
struct DiyetItem: View {
    var diyet: DietMeal
    
    var body: some View {
        VStack {
            ZStack {
                Image("diyet")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .frame(width: 150)
                
                VStack {
                    Text(diyet.foodName) // Yemek adı
                        .fontWeight(.semibold)
                        .font(.system(size: 16))
                    Text("Öğün: \(mealTypeName(diyet.mealType))") // Öğün tipi
                        .font(.system(size: 12))
                    Text("Porsiyon: \(diyet.portion, specifier: "%.0f") \(diyet.unit)") // Porsiyon bilgisi
                        .font(.system(size: 12))
                }
                .frame(width: 120)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.white)
                .cornerRadius(20)
                .offset(y: 80)
                .shadow(radius: 5)
            }
        }
        .padding(.bottom,5)
   
    }
    
    // Öğün tipini metin olarak dönüştüren bir yardımcı fonksiyon
    private func mealTypeName(_ mealType: Int) -> String {
        switch mealType {
        case 0: return "Kahvaltı"
        case 1: return "Öğle Yemeği"
        case 2: return "Akşam Yemeği"
        case 3: return "Ara Öğün"
        default: return "Bilinmeyen"
        }
    }
}

#Preview {
    DiyetItem(diyet: DietMeal(id: 1, dietDayId: 1, mealType: 1, foodName: "Yulaf Ezmesi", portion: 100, unit: "gram", calories: 375, carbohydrate: 50, protein: 17, fat: 10))
}
