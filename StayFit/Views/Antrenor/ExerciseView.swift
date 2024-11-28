//  ExerciseView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 22.11.2024.
//


import SwiftUI
struct ExerciseListView: View {
    @StateObject private var viewModel = ExerciseViewModel()
    var workoutdays: WorkoutDays
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.exercises.sorted(by: { $0.priority < $1.priority }), id: \.name) { exercise in
                    NavigationLink {
                        ExerciseDetailView(exercise: exercise)
                        
                    } label: {
                        VStack(alignment: .leading) {
                            Text(exercise.name)
                                .font(.headline)
                            Text(exercise.description)
                                .font(.subheadline)
                            Text("Hareket Önceliği : \(exercise.priority)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }

                    
                }
                .navigationTitle("Egzersiz Listesi")
                .navigationBarTitleDisplayMode(.inline)
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
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: AddExerciseView(viewModel: viewModel).navigationBarBackButtonHidden(true)
                        ){
                            Image(systemName: "plus")
                                .imageScale(.large)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.WorkoutId = workoutdays.id
                print(viewModel.WorkoutId)
                viewModel.fetchExercises(for: workoutdays.id)
            }
        }
    }

}





#Preview {
    ExerciseListView( workoutdays: WorkoutDays(id: 1, title: "Bacak", dayOfWeek: 0, isCompleted: false))
}



struct ExerciseDetailView: View {
    let exercise: Exercise
    
    // Özel renkler
    private let lightBlue = Color(red: 235/255, green: 245/255, blue: 255/255)
    private let mediumBlue = Color(red: 100/255, green: 149/255, blue: 237/255)
    private let darkBlue = Color(red: 25/255, green: 25/255, blue: 112/255)
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Başlık Kartı
                VStack {
                    Text(exercise.name)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(mediumBlue)
                                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
                        )
                }
                .padding(.horizontal)
                
                // Açıklama Kartı
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(mediumBlue)
                        HStack {
                            Spacer()
                            Text("Açıklama")
                                .font(.headline)
                                .foregroundColor(darkBlue)
                                .padding(.horizontal)
                            Spacer()
                        }
                        .padding(.horizontal,15)
                        
                    }
                    
                    Text(exercise.description)
                        .font(.body)
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(lightBlue)
                        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                )
                .padding(.horizontal)
                
                // Detaylar Grid
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 15) {
                    DetailBox(title: "Öncelik", value: "\(exercise.priority)", icon: "star.fill")
                    DetailBox(title: "Set Sayısı", value: "\(exercise.setCount)", icon: "repeat.circle.fill")
                    DetailBox(title: "Tekrar", value: "\(exercise.repetitionCount)", icon: "number.circle.fill")
                    DetailBox(title: "Set Arası Dinlenme", value: "\(exercise.durationMinutes) dk", icon: "clock.fill")
                }
                .padding(.horizontal)
                
                // Kategori ve Seviye Kartı
                VStack(spacing: 15) {
                    CategoryRow(title: "Egzersiz Seviyesi", value:String( exercise.exerciseLevel), icon: "chart.bar.fill")
                    CategoryRow(title: "Kategori", value:String( exercise.exerciseCategory), icon: "folder.fill")
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                )
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color(red: 248/255, green: 250/255, blue: 252/255))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailBox: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(Color(red: 100/255, green: 149/255, blue: 237/255))
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(value)
                .font(.headline)
                .bold()
                .foregroundColor(Color(red: 25/255, green: 25/255, blue: 112/255))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
        )
    }
}

struct CategoryRow: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(Color(red: 100/255, green: 149/255, blue: 237/255))
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text(value)
                    .font(.headline)
                    .foregroundColor(Color(red: 25/255, green: 25/255, blue: 112/255))
            }
            
            Spacer()
        }
    }
}
