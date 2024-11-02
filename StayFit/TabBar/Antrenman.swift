//
//  Antrenman.swift
//  StayFit
//cscs
//  Created by İmat Gökaslan on 9.10.2024.
//sdscscs

import SwiftUI


struct Antrenman: View {
    @ObservedObject var workoutProgram = AntrenmanViewModel()
    @State private var selectedDay: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // Gün adını tam almak için (Pazartesi, Salı, vb.)
        formatter.locale = Locale(identifier: "tr_TR") // Türkçe gün adları için
        return formatter.string(from: Date())
    }()
    
    let daysOfWeek = ["Pazartesi", "Salı", "Çarşamba", "Perşembe", "Cuma", "Cumartesi", "Pazar"]

    var body: some View {
       NavigationStack{
            VStack {
                // Gün seçimi için Picker
                Picker("Gün Seçin", selection: $selectedDay) {
                    ForEach(daysOfWeek, id: \.self) { day in
                        Text(day).tag(day)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()

                // Seçilen günün antrenmanını gösterme
                if let workout = workoutProgram.program[selectedDay] {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(workout.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text(workout.description)
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    .padding()
                } else {
                    Text("Bu gün için program bulunamadı.")
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .navigationTitle("Antrenman Programı")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    Antrenman()
}

