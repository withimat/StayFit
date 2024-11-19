//
//  ExerciseView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 22.11.2024.
//

import SwiftUI
struct ExerciseView: View {
    @StateObject private var viewModel = ExerciseViewModel()
    let workout: WorkoutCevap

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.exercises.sorted(by: { $0.priority < $1.priority })) { workout in
                        NavigationLink(destination: ExerciseDetailView(exercise: workout)) {
                            VStack(alignment: .leading) {
                                Text(workout.name)
                                    .font(.headline)
                                Text(workout.description)
                                    .font(.subheadline)
                                Text("Öncelik: \(workout.priority)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .onDelete(perform: deleteWorkout)
                }
                .navigationTitle("Egzersiz Listesi")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {  
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: AddExerciseView(viewModel: viewModel)) {
                            Image(systemName: "plus")
                                .imageScale(.large)
                        }
                    }
                }
            }
        }
    }

    private func deleteWorkout(at offsets: IndexSet) {
        viewModel.exercises.remove(atOffsets: offsets)
    }
}


struct AddExerciseView: View {
    @ObservedObject var viewModel: ExerciseViewModel
    @State private var newWorkout = Exercise(
        id: 0,
        workoutDayId: 8,
        isCompleted: false,
        priority: 1,
        name: "",
        description: "",
        setCount: 0,
        repetitionCount: 0,
        durationMinutes: 0,
        exerciseLevel: 0,
        exerciseCategory: 0
    )
    @State private var showAlert = false
    @State private var successAlert = false
    
    var body: some View {
        Form {
            Section(header: Text("Egzersiz Bilgileri")) {
                TextField("Egzersiz Adı", text: $newWorkout.name)
                TextField("Açıklama", text: $newWorkout.description)
                
                Stepper("Öncelik: \(newWorkout.priority)", value: $newWorkout.priority, in: 0...10)
                Toggle("Tamamlandı mı?", isOn: $newWorkout.isCompleted)
            }
            
            Section(header: Text("Set ve Tekrar Bilgileri")) {
                Stepper("Set Sayısı: \(newWorkout.setCount)", value: $newWorkout.setCount, in: 0...100)
                Stepper("Tekrar Sayısı: \(newWorkout.repetitionCount)", value: $newWorkout.repetitionCount, in: 0...100)
                Stepper("Süre (dk): \(newWorkout.durationMinutes)", value: $newWorkout.durationMinutes, in: 0...300)
            }
            
            Section(header: Text("Seviye ve Kategori")) {
                Stepper("Egzersiz Seviyesi: \(newWorkout.exerciseLevel)", value: $newWorkout.exerciseLevel, in: 0...5)
                Stepper("Egzersiz Kategorisi: \(newWorkout.exerciseCategory)", value: $newWorkout.exerciseCategory, in: 0...10)
            }
            
            Section {
                Button("Egzersiz Ekle") {
                    addWorkout()
                }
                .buttonStyle(.bordered)
                .alert("Bu öncelik zaten mevcut! Lütfen farklı bir öncelik seçin.", isPresented: $showAlert) {
                    Button("Tamam", role: .cancel) {}
                }
                .alert("Hareket başarıyla eklendi!", isPresented: $successAlert) {
                    Button("Tamam", role: .cancel) {
                        resetForm()
                    }
                }
            }
        }
        .navigationTitle("Yeni Egzersiz Ekle")
    }
    
    private func addWorkout() {
        // Öncelik kontrolü
        if viewModel.exercises.contains(where: { $0.priority == newWorkout.priority }) {
            showAlert = true
        } else {
            let workout = Exercise(
                id: Int.random(in: 1...1000),
                workoutDayId: newWorkout.workoutDayId,
                isCompleted: newWorkout.isCompleted,
                priority: newWorkout.priority,
                name: newWorkout.name,
                description: newWorkout.description,
                setCount: newWorkout.setCount,
                repetitionCount: newWorkout.repetitionCount,
                durationMinutes: newWorkout.durationMinutes,
                exerciseLevel: newWorkout.exerciseLevel,
                exerciseCategory: newWorkout.exerciseCategory
            )
            viewModel.exercises.append(workout)
            
            // Alerti göster ve formu temizle
            successAlert = true
        }
    }
    
    private func resetForm() {
        newWorkout = Exercise(
            id: 0,
            workoutDayId: 8,
            isCompleted: false,
            priority: 1,
            name: "",
            description: "",
            setCount: 0,
            repetitionCount: 0,
            durationMinutes: 0,
            exerciseLevel: 0,
            exerciseCategory: 0
        )
    }
}



#Preview {
    ExerciseView(workout: WorkoutCevap(id: 12, title: "imat", description: "imat", formattedStartDate: "", formattedEndDate: "", status: 0, endDate: "", startDate: ""))
}

struct ExerciseDetailView: View {
    let exercise: Exercise

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(exercise.name)
                .font(.largeTitle)
                .bold()

            Text("Açıklama:")
                .font(.headline)
            Text(exercise.description)
                .font(.body)

            Text("Öncelik: \(exercise.priority)")
                .font(.subheadline)
                .foregroundColor(.gray)

            Text("Set Sayısı: \(exercise.setCount)")
            Text("Tekrar Sayısı: \(exercise.repetitionCount)")
            Text("Süre (dk): \(exercise.durationMinutes)")

            Text("Egzersiz Seviyesi: \(exercise.exerciseLevel)")
            Text("Egzersiz Kategorisi: \(exercise.exerciseCategory)")
        }
        .padding()
        .navigationTitle("Egzersiz Detayları")
        .navigationBarTitleDisplayMode(.inline)
    }
}
