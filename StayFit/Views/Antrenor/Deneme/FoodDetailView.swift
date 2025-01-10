import SwiftUI
import Charts

struct FoodDetailView: View {
    let foodItem: FoodItem
    @State private var selectedServingIndex: Int = 0
    @State private var inputAmount: String = ""
    @State private var selectedUnit: String = "gr"
    
    var calculatedValues: (calories: Double, carbohydrate: Double, protein: Double, fat: Double) {
        guard foodItem.servings.serving.indices.contains(selectedServingIndex),
              let serving = foodItem.servings.serving[selectedServingIndex] as Serving?,
              let baseCalories = Double(serving.calories),
              let baseCarbohydrate = Double(serving.carbohydrate),
              let baseProtein = Double(serving.protein),
              let baseFat = Double(serving.fat),
              let amount = Double(inputAmount) else {
            return (0, 0, 0, 0)
        }

        if amount == 100 {
            return (
                calories: baseCalories / 10,
                carbohydrate: baseCarbohydrate / 10,
                protein: baseProtein / 10,
                fat: baseFat / 10
            )
        }

        
        let factor = amount
        
        return (
            calories: baseCalories * factor,
            carbohydrate: baseCarbohydrate * factor,
            protein: baseProtein * factor,
            fat: baseFat * factor
        )
    }

    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Besin Görseli
                if let imageUrl = foodItem.foodImages?.foodImage?.first?.imageUrl {
                    AsyncImage(url: URL(string: imageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: .infinity, height: 300)
                    } placeholder: {
                        ProgressView()
                    }
                    .cornerRadius(12)
                } else {
                    HStack {
                        Spacer()
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                        Spacer()
                    }
                }
                
                // Besin Adı ve Marka
                Text(foodItem.foodName)
                    .font(.largeTitle)
                    .bold()
                
                // Porsiyon Seçimi
                VStack(alignment: .leading, spacing: 8) {
                    Text("Porsiyon Seçin:")
                        .font(.headline)
                    
                    Picker("Porsiyon Seçimi", selection: $selectedServingIndex) {
                        ForEach(foodItem.servings.serving.indices, id: \.self) { index in
                            Text(foodItem.servings.serving[index].servingDescription)
                                .tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                // Kullanıcıdan Miktar Girişi
                VStack(alignment: .leading, spacing: 8) {
                    Text("Lütfen \(foodItem.servings.serving[selectedServingIndex].numberOfUnits ?? "null") değeri Girin:")
                        .font(.headline)
                    
                    TextField(
                        "\(foodItem.servings.serving[selectedServingIndex].numberOfUnits ?? "null") (ör. 1)",
                        text: $inputAmount
                    )
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                }
                
                // Hesaplanan Değerler
                VStack(alignment: .leading, spacing: 20) {
                    Text("Besin Değerleri:")
                        .font(.headline)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Kalori:")
                                .foregroundColor(.orange)
                            Text("\(String(format: "%.2f", calculatedValues.calories)) kcal")
                                .font(.title2)
                                .bold()
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("Karbonhidrat:")
                                .foregroundColor(.blue)
                            Text("\(String(format: "%.2f", calculatedValues.carbohydrate)) g")
                                .font(.title2)
                                .bold()
                        }
                    }
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Protein:")
                                .foregroundColor(.green)
                            Text("\(String(format: "%.2f", calculatedValues.protein)) g")
                                .font(.title2)
                                .bold()
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("Yağ:")
                                .foregroundColor(.red)
                            Text("\(String(format: "%.2f", calculatedValues.fat)) g")
                                .font(.title2)
                                .bold()
                        }
                    }
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(12)
                
                // Diyet Listesine Ekleme Butonu
                HStack {
                    Spacer()
                    Button {
                        print("Diyet listesine eklendi")
                    } label: {
                        Text("Diyet Listesine Ekle")
                            .padding()
                            .padding(.horizontal)
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .background(.orange)
                            .cornerRadius(20)
                    }
                    Spacer()
                }
            }
            .padding()
        }
        .navigationTitle("Detaylar")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct FoodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Sample serving data
        let sampleServing = Serving(
            metricServingUnit: "adet", numberOfUnits: "1",
            servingDescription: "1 adet",
            calories: "52",
            carbohydrate: "14 g",
            protein: "0.3 g",
            fat: "0.2 g"
        )
        
        // Sample food item data
        let sampleFoodItem = FoodItem(
            foodId: "12",
            foodName: "Elma",
            foodType: "Meyve",
            foodUrl: nil,
            brandName: "Doğal",
            foodImages: FoodImages(foodImage: [FoodImage(imageUrl: "https://www.foodimagedb.com/food-images/6b5d0828-7391-49e6-ba02-606b0363d41e_1024x1024.png", imageType: "thumbnail")]),
            servings: Servings(serving: [sampleServing])
        )
        
        // Preview for FoodDetailView
        FoodDetailView(foodItem: sampleFoodItem)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
