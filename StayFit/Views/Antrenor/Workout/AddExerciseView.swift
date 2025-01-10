//
//  AddExerciseView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 24.11.2024.
//

import SwiftUI

struct AddExerciseView: View {
    @ObservedObject var viewModel: ExerciseViewModel
    @Environment(\.dismiss) var dismiss

    @State private var exercise = Exercise(
        id: 0,
        workoutDayId: 0,
        priority: 1, name: "",
        description: "",
        setCount: 0,
        repetitionCount: 0,
        durationMinutes: 0,
        exerciseLevel: 0,
        exerciseCategory: 0
    )

    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isSubmitting = false

    var body: some View {
        Form {
            Section(header: Text("Egzersiz Bilgileri")) {
                TextField("Egzersiz Adı", text: $exercise.name)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    
                TextField("Açıklama", text: $exercise.description)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                Stepper("Egzersiz Önceliği: \(exercise.priority)", value: $exercise.priority, in: 1...15)
            }
            
            Section(header: Text("Set ve Tekrar Bilgileri")) {
                Stepper("Set Sayısı: \(exercise.setCount)", value: $exercise.setCount, in: 0...100)
                Stepper("Tekrar Sayısı: \(exercise.repetitionCount)", value: $exercise.repetitionCount, in: 0...100)
                Stepper("Set Arası Dinlenme Süresi: \(exercise.durationMinutes)", value: $exercise.durationMinutes, in: 0...300)
            }
            
            Section(header: Text("Seviye ve Kategori")) {
                Stepper("Egzersiz Seviyesi: \(exercise.exerciseLevel)", value: $exercise.exerciseLevel, in: 0...5)
                Stepper("Egzersiz Kategorisi: \(exercise.exerciseCategory)", value: $exercise.exerciseCategory, in: 0...10)
            }
            
            Section {
                Button {
                    isSubmitting = true
                    exercise.workoutDayId = viewModel.WorkoutId
                    
                    // Öncelik değerini ayarlama
                    let existingPriorities = viewModel.exercises.map { $0.priority }
                    let newPriority = (1...15).first { !existingPriorities.contains($0) } ?? 1
                    exercise.priority = newPriority
                    
                    // Array içinde gönderiyoruz
                    viewModel.addExercises([exercise])
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
                .disabled(exercise.name.isEmpty || isSubmitting || exercise.description.isEmpty)
            }
        }
        .onAppear(){}
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
        .navigationTitle("Yeni Egzersiz Ekle")
        .alert("Bilgi", isPresented: $showAlert) {
            Button("Tamam", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
}
