//
//  YararliBilgiler.swift
//  StayFit
//
//  Created by İmat Gökaslan on 29.10.2024.
//

import SwiftUI


// Fitness ipuçlarını listeleyen ana View
struct FitnessTipsView: View {
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "BG")
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "beyaz")!,.font : UIFont(name: "Pacifico-Regular" , size: 22)!]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
    @Environment(\.dismiss) var dismiss
    let icerik: [FitnessTip] = Bundle.main.decode("fitness.json")

    var body: some View {
        NavigationStack {
            List(icerik) { tip in
                NavigationLink(destination: FitnessTipDetailView(tip: tip)
                    .navigationBarBackButtonHidden(true)
                ) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(tip.title)
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text(tip.category)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .frame(height: 120)
                    
                    
                }
                .padding()
                .background(randomColor())
                
                .cornerRadius(10)
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
            .navigationTitle("Fitness İpuçları")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(InsetGroupedListStyle())  // Modern liste stili
        }
    }
    func randomColor() -> Color {
            Color(
                red: Double.random(in: 0.3...1),
                green: Double.random(in: 0.4...1),
                blue: Double.random(in: 0.5...1)
            )
        }
}


// Fitness ipucu detaylarını gösteren View
struct FitnessTipDetailView: View {
    let tip: FitnessTip  // Parametre olarak seçilen fitness ipucunu alıyoruz
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(tip.title)
                    .font(.title)
                    .fontWeight(.bold)

                Text("Kategori: \(tip.category)")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text(tip.description)
                    .font(.body)
                    .padding(.top, 8)

                if let duration = tip.duration {
                    Text("Süre: \(duration)")
                        .font(.body)
                        .foregroundColor(.blue)
                }

                if let recommendedFoods = tip.recommendedFoods {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Önerilen Yiyecekler:")
                            .font(.headline)
                        ForEach(recommendedFoods, id: \.self) { food in
                            Text("• \(food)")
                                .font(.body)
                        }
                    }
                }

                if let recommendedIntake = tip.recommendedIntake {
                    Text("Önerilen Su Tüketimi: \(recommendedIntake)")
                        .font(.body)
                        .foregroundColor(.green)
                }
            }
            .padding()
        }
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .foregroundColor(.white)
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
        .navigationTitle(tip.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    FitnessTipsView()
}

struct FitnessTip: Codable, Identifiable {
    var id: Int
    var title: String
    var description: String
    var category: String
    var duration: String?
    var recommendedFoods: [String]?
    var recommendedIntake: String?
}



