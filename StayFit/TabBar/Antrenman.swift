//
//  Antrenman.swift
//  StayFit
//
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


/*
 
 struct AnterorSecim: View {
     func loadTrainerFromUserDefaults() -> Person? {
         if let savedTrainer = UserDefaults.standard.data(forKey: "selectedPerson") {
             let decoder = JSONDecoder()
             if let loadedTrainer = try? decoder.decode(Person.self, from: savedTrainer) {
                 return loadedTrainer
             }
         }
         return nil
     }

     @State private var person : Person?
     @State private var isNavigatingToList: Bool = false  // Antrenor listesine geçiş kontrolü

     var body: some View {
         VStack {
             if let person = person {
                 Text("Seçilen Antrenör: \(person.firstName) \(person.lastName)")
                     .font(.title)
                     .padding()

                 Button(action: {
                     deleteTrainerFromUserDefaults()  // Silme işlemi
                     self.person = nil  // Ekranı güncelle
                 }) {
                     Text("Antrenörü Sil")
                         .foregroundColor(.white)
                         .padding()
                         .background(Color.red)
                         .cornerRadius(10)
                 }
                 .padding()
             } else {
                 Text("Lütfen aşağıdan bir antrenör seçin")
                 Button(action: {
                     isNavigatingToList = true
                 }) {
                 
                     Text("Antrenör Seç")
                         .foregroundColor(.white)
                         .padding()
                         .background(Color.blue)
                         .cornerRadius(10)
                 }
                 .fullScreenCover(isPresented: $isNavigatingToList) {
                     PersonListView()  // AntrenorListesi sayfası
                 }
             }
         }
         .onAppear {
             person = loadTrainerFromUserDefaults()  // Trainer'ı yükle
         }
     }

     // Trainer'ı UserDefaults'tan silmek için fonksiyon
     func deleteTrainerFromUserDefaults() {
         UserDefaults.standard.removeObject(forKey: "selectedPerson")
     }
 }

 
 */
