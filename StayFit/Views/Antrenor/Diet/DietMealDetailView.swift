//
//  DietMealDetailView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 7.12.2024.
//

import SwiftUI


struct DietMealDetailView: View {
    let meal: DietMeal
    private let lightGreen = Color(red: 235/255, green: 255/255, blue: 235/255)
    private let mediumGreen = Color(red: 144/255, green: 238/255, blue: 144/255)
    private let darkGreen = Color(red: 34/255, green: 139/255, blue: 34/255)
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Başlık Kartı
                VStack {
                    Text(
                        "\(String(format: "%.0f", meal.portion)) " +
                        "\(meal.unit) \(meal.foodName)"
                    )


                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(mediumGreen)
                                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
                        )
                }
                .padding(.horizontal)
                
                
                    
                  
                
               
                
                
                // Besin Değerleri Grid
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 15) {
                    // Besin Bilgileri Kartı
                    
                    DietDetailBox(title: "Kalori", value: "\(String(format: "%.f", meal.calories)) kcal", icon: "flame.fill")
                    // Nutritional Detail Boxes
                    DietDetailBox(title: "Karbonhidrat", value: "\(String(format: "%.f", meal.carbohydrate)) g", icon: "chart.pie.fill")
                    DietDetailBox(title: "Protein", value: "\(String(format: "%.f", meal.protein)) g", icon: "leaf.fill")
                    DietDetailBox(title: "Yağ", value: "\(String(format: "%.f", meal.fat)) g", icon: "drop.fill")
                }
                .padding(.horizontal)

                // Kategori Kartı
                VStack(spacing: 15) {
                    DietCategoryRow(title: "Yemek Türü", value: mealTypeDescription(meal.mealType), icon: "fork.knife")
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .shadow(color: .gray.opacity(0.3), radius: 6, x: 0, y: 3)
                )
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
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
        // Gradient background
        .background(
            LinearGradient(gradient:
                Gradient(colors: [Color(red: 248/255, green: 252/255, blue: 248/255), Color.white]),
                           startPoint:.top,
                           endPoint:.bottom)
        )
        .navigationBarTitleDisplayMode(.inline)
    }

    // Yemek türünü açıklayan bir yardımcı fonksiyon
    func mealTypeDescription(_ type: Int) -> String {
        switch type {
        case 0:
            return "1. Öğün"
        case 1:
            return "2. Öğün"
        case 2:
            return "3. Öğün"
        case 3:
            return "4. Öğün"
        default:
            return "Bilinmeyen"
        }
    }
}

// Besin Değerleri Kutusu
struct DietDetailBox: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(Color(red: 34/255, green: 139/255, blue: 34/255))
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(value)
                .font(.headline)
                .bold()
                .foregroundColor(Color(red: 34/255, green: 139/255, blue: 139/255))
        }
        .frame(maxWidth:.infinity)
        .padding()
        // Card styling with shadow
        .background(
            RoundedRectangle(cornerRadius:12)
                .fill(Color.white)
                .shadow(color:.gray.opacity(0.2), radius:4,x:0,y:2)
        )
    }
}

// Kategori Satırı
struct DietCategoryRow : View {
    let title : String
    let value : String
    let icon : String
    
    var body : some View {
        HStack(spacing :15) {
            Image(systemName :icon )
                .font(.system(size :20))
                // Icon color adjustment
                .foregroundColor(Color(red :144/255 , green :238/255 , blue :144/255))
                // Fixed width for alignment
                .frame(width :30)

            VStack(alignment :.leading , spacing :4) {
                Text(title )
                    // Font styling for title
                    .font(.subheadline )
                    // Title color adjustment
                    .foregroundColor(.gray)

                Text(value )
                    // Font styling for value display
                    .font(.headline )
                    // Value color adjustment
                    .foregroundColor(Color(red :34/255 , green :139/255 , blue :34/255))
            }

            Spacer()
        }
    }
}

// Örnek Önizleme
struct DietMealDetailView_Previews : PreviewProvider {
    static var previews : some View {
        DietMealDetailView(meal : DietMeal(
            id :0,
            dietDayId :1,
            mealType :0,
            foodName :"Yulaf Ezmesi tatlısı",
            portion :150.0,
            unit :"gram",
            calories :200.0,
            carbohydrate :40.0,
            protein :7.0,
            fat :3.0))
    }
}
