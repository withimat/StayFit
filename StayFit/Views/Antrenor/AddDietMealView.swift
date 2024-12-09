//
//  AddDietMealView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 7.12.2024.
//

import SwiftUI


struct AddDietMealView: View {
    @ObservedObject var viewModel : DietListModelView
    @Environment(\.dismiss) var dismiss

    @State private var meal = DietMeal(
        id: 0,
        dietDayId: 0,
        mealType: 0,
        foodName: "",
        portion: 0.0,
        unit: "",
        calories: 0.0,
        carbs: 0.0,
        protein: 0.0,
        fat: 0.0
    )
    @State private var units = ["Gram", "Adet", "Kilo", "Litre", "Porsiyon"]
    @State private var selectedUnit = "Gram"
    @State private var isSubmitting = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        Form {
            // Besin Bilgileri Bölümü
            Section(header: Text("Besin Bilgileri")) {
                TextField("Besin Adı", text: $meal.foodName)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)

                HStack {
                    Text("Porsiyon")
                        .offset(x:-10)
                        .foregroundColor(.secondary)
                    Spacer()
                    
                    TextField("Porsiyon", value: $meal.portion, format: .number)
                        .keyboardType(.decimalPad)
                        .frame(width: 80) // İsteğe bağlı: Genişlik sınırlandırması
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()


                Section {
                    HStack {
                        Text("Birim").foregroundColor(.secondary)
                        Spacer()
                        Picker("", selection: $selectedUnit) {
                            ForEach(units, id: \.self) { unit in
                                Text(unit).tag(unit)
                            }
                        }
                        .pickerStyle(MenuPickerStyle()) // Menü stili
                    }
                }


            }

            // Kalori ve Besin Değerleri
            Section(header: Text("Besin Değerleri")) {
                HStack {
                    Text("Kalori:")
                    Spacer()
                    Stepper("", value: $meal.calories, in: 0...5000, step: 10)
                        .labelsHidden() // Sadece butonlar görünür
                    TextField("Kalori", value: $meal.calories, format: .number)
                        .keyboardType(.decimalPad)
                        .frame(width: 80)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Karbonhidrat:")
                    Spacer()
                    Stepper("", value: $meal.carbs, in: 0...1000, step: 10)
                        .labelsHidden()
                    TextField("Karbonhidrat", value: $meal.carbs, format: .number)
                        .keyboardType(.decimalPad)
                        .frame(width: 80)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Protein:")
                    Spacer()
                    Stepper("", value: $meal.protein, in: 0...1000, step: 10)
                        .labelsHidden()
                    TextField("Protein", value: $meal.protein, format: .number)
                        .keyboardType(.decimalPad)
                        .frame(width: 80)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                HStack {
                    Text("Yağ:")
                    Spacer()
                    Stepper("", value: $meal.fat, in: 0.0...1000.0, step: 10)
                        .labelsHidden()
                    TextField("Yağ", value: $meal.fat, format: .number)
                        .keyboardType(.decimalPad)
                        .frame(width: 80)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }


            // Yemek Türü Bölümü
            Section(header: Text("Yemek Türü")) {
                Stepper("Yemek Türü: \(mealTypeDescription(meal.mealType))", value: $meal.mealType, in: 0...10)
            }

            // Kaydet Butonu
            Section {
                Button {
                    meal.unit = selectedUnit
                    isSubmitting = true
                    meal.dietDayId = viewModel.dietId
                    
                  
        

                    
                    viewModel.addDiets([meal])
                    isSubmitting = false
                    dismiss()
                } label: {
                    HStack {
                        Spacer()
                        if isSubmitting {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        }
                        Text(isSubmitting ? "Kaydediliyor..." : "Kaydet")
                        Spacer()
                    }
                }
                .disabled(meal.foodName.isEmpty || isSubmitting)
            }
        }
        .onAppear(){
           
        }
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
        .navigationTitle("Yeni Besin Ekle")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Bilgi", isPresented: $showAlert) {
            Button("Tamam", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }

    // Yemek Türü Açıklaması
    private func mealTypeDescription(_ mealType: Int) -> String {
        switch mealType {
        case 0: return "1. Öğün"
        case 1: return "2. Öğün"
        case 2: return "3. Öğün"
        case 3: return "4. öğün"
        default: return "Bilinmiyor"
        }
    }
}


struct AddDietMealView_Previews: PreviewProvider {
    class MockDietListModelView: DietListModelView {
        override init() {
            super.init()
            self.dietId = 9 // Örnek bir diyet günü kimliği
        }

        override func addDiets(_ meals: [DietMeal]) {
            print("Yemekler eklendi: \(meals)")
        }
    }

    static var previews: some View {
        NavigationView {
            AddDietMealView(viewModel: MockDietListModelView())
        }
    }
}
