//
//  StudentDetailView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 1.11.2024.
//

import SwiftUI

struct StudentDetailView: View {
    let student: Student
    @StateObject private var viewModel = StudentDetailViewModel() // WorkoutPlanViewModel'dan güncelledik
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Öğrenci Bilgileri Başlığı ve Fotoğraf
                    HStack(alignment: .center, spacing: 30) {
                        if let photoPath = student.photoPath, let url = URL(string: photoPath) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } placeholder: {
                                ProgressView()
                            }
                        } else {
                            Image("hoca")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .foregroundColor(.gray)
                        }
                        
                        Text("\(student.firstName) \(student.lastName)")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal)
                    
                    let screenWidth = UIScreen.main.bounds.width
                    
                    // Öğrenci Bilgileri
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Öğrenci Bilgileri")
                            .fontWeight(.semibold)
                            .font(.headline)
                        
                        Group {
                            Text("Abonelik Bitiş Tarihi : \t \(student.endDate)")
                            Divider()
                            Text("Abonelik Ücreti        : \t \(student.amount) TL")
                            Divider()
                            Text("Boy                            : \t \(student.height) cm")
                            Divider()
                            Text("Kilo                            : \t  \(student.weight) kg")
                            Divider()
                            Text("Cinsiyet                     : \t \(student.gender == 0 ? "Erkek" : "Kadın")")
                            Divider()
                            Text("Doğum Tarihi            : \t \(student.birthDate)")
                        }
                        .font(.subheadline)
                    }
                    .frame(width: screenWidth * 5 / 6)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.secondarySystemBackground)))
                    .padding(.horizontal)
                    
                    
                    HStack {
                        Spacer()
                        NavigationLink {
                            AntrenorWorkoutPlanView(student: student)
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Text("Yeni bir antrenman programı ekle")
                                .padding()
                                .font(.system(size: 15))
                                .clipShape(Rectangle())
                                .background(.gray)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // Workout Planları Gösterimi
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Antrenman Planları")
                            .fontWeight(.semibold)
                            .font(.headline)
                        
                        if viewModel.isLoading {
                            ProgressView("Antrenman planları yükleniyor...")
                        } else if let errorMessage = viewModel.errorMessage {
                            Text("Hata: \(errorMessage)")
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                        } else if viewModel.workoutPlan.isEmpty {
                            Text("Henüz antrenman planı yok.")
                                .foregroundColor(.gray)
                        } else {
                            ForEach(viewModel.workoutPlan, id: \.id) { workout in
                                
                                NavigationLink {
                                    ExerciseView(workout: workout)
                                } label: {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(workout.title)
                                            .font(.headline)
                                        Text(workout.description)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        HStack {
                                            Text("Başlangıç: \(workout.formattedStartDate)")
                                            Spacer()
                                            Text("Bitiş: \(workout.formattedEndDate)")
                                        }
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                    }
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.systemBackground)))
                                    .shadow(radius: 2)
                                }

                            }
                        }
                    }
                    .padding()
                    
                  
                   
                }
            }
            .onAppear {
                viewModel.fetchWorkoutPlan(subscriptionId: "\(student.id)")
                
            }
            .padding()
        }
    }
}

#Preview {
    StudentDetailView(student: Student(id: "12", memberId: "12", endDate: "11/21", amount: 5500, height: 180, weight: 80, firstName: "İmat", lastName: "Gokaslan", gender: 0, birthDate: "15/08", photoPath: ""))
}
