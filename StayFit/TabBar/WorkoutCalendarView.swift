//
//  WorkoutCalendarView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 8.10.2024.
//

import SwiftUI

struct WeeklyWorkoutView: View {
    let daysOfWeek = ["Pazartesi", "Salı", "Çarşamba", "Perşembe", "Cuma", "Cumartesi", "Pazar"]
    
    @State private var selectedDay: String? = nil
    let workouts: [String: String] = [
        "Pazartesi": "Koşu: 5km",
        "Salı": "Ağırlık Antrenmanı: Bacak",
        "Çarşamba": "Yoga: 1 Saat",
        "Perşembe": "HIIT: 30 Dakika",
        "Cuma": "Koşu: 10km",
        "Cumartesi": "Ağırlık Antrenmanı: Göğüs ve Sırt",
        "Pazar": "Dinlenme Günü"
    ]
    
    var body: some View {
        VStack {
            Text("Haftalık Antrenman Programı")
                .font(.largeTitle)
                .padding()
            
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    VStack {
                        Text(day)
                            .font(.headline)
                            .padding()
                            .background(day == selectedDay ? Color.green : Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .onTapGesture {
                                selectedDay = day
                            }
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            
            Spacer()
            
            if let selectedDay = selectedDay, let workout = workouts[selectedDay] {
                Text("Antrenman: \(workout)")
                    .font(.title2)
                    .padding()
            } else {
                Text("Bir gün seçin")
                    .font(.title2)
                    .padding()
            }
        }
    }
}



#Preview {
    WeeklyWorkoutView()
}
