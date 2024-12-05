//
//  ExxerciseRowView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 3.12.2024.
//

import SwiftUI

struct ExerciseRowView: View {
    let exercise: Exercise
    var onDelete: () -> Void // Silme işleminden sonra çağrılacak bir closure
    
    var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                // Başlık ve Kategoriler
                HStack {
                    Text(exercise.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                    HStack(spacing: 15) {
                        Image(systemName: "pencil")
                            .foregroundColor(.white)
                        Button{
                            onDelete()
                        } label: {
                            Image(systemName: "trash")
                                .foregroundColor(.white)
                        }

                       
                    }
                }
                
                // Alt Açıklama
                Text(exercise.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Detaylar
                HStack(spacing: 15) {
                    // Set Bilgisi
                    VStack(alignment: .leading, spacing: 5) {
                        Text("\(exercise.setCount) Set")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("\(exercise.repetitionCount) Tekrar")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    // Süre ve Seviye
                    VStack(alignment: .trailing, spacing: 5) {
                        HStack {
                            
                            Text("dinlenme süresi \(exercise.durationMinutes)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Image(systemName: "clock")
                                .foregroundColor(.gray)
                        }
                        
                        HStack {
                            Text("Hareket Sırası: \(exercise.priority)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Divider()
                    .background(Color.gray)
            }
            .onAppear(){
                
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.black.opacity(0.8))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2)
            )
            
        }
}

// Örnek Model ve Önizleme
struct ExerciseRowView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseRowView(exercise: Exercise(
            id: 0,
            workoutDayId: 1,
            priority: 2,
            name: "Abs Workout",
            description: "Core strength exercises",
            setCount: 4,
            repetitionCount: 12,
            durationMinutes: 15,
            exerciseLevel: 2,
            exerciseCategory: 1
        ), onDelete: {
            
        })
            .padding()
            
    }
}


struct MemberExerciseRowView: View {
    let exercise: Exercise
    
    var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                // Başlık ve Kategoriler
                HStack {
                    Text(exercise.name)
                        .font(.headline)
                        .foregroundColor(.white)
                
                   
                }
                
                // Alt Açıklama
                Text(exercise.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Detaylar
                HStack(spacing: 15) {
                    // Set Bilgisi
                    VStack(alignment: .leading, spacing: 5) {
                        Text("\(exercise.setCount) Set")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("\(exercise.repetitionCount) Tekrar")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    // Süre ve Seviye
                    VStack(alignment: .trailing, spacing: 5) {
                        HStack {
                            
                            Text("dinlenme süresi \(exercise.durationMinutes)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Image(systemName: "clock")
                                .foregroundColor(.gray)
                        }
                        
                        HStack {
                            Text("Hareket Sırası: \(exercise.priority)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Divider()
                    .background(Color.gray)
            }
            .onAppear(){
                
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.black.opacity(0.8))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2)
            )
            
        }
}
