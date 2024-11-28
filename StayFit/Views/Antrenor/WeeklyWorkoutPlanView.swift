//
//  WeeklyWorkoutPlanView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 22.11.2024.
//  viewModel.workoutPlanId = workout.id

import SwiftUI

struct WeeklyWorkoutPlanView: View {
    @StateObject private var viewModel = WeeklyWorkoutPlanViewModel()
    @Environment(\.dismiss) var dismiss
    let workout: WorkoutCevap
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Yükleniyor...")
                } else {
                    List {
                        ForEach(viewModel.workoutDays) { plan in
                            HStack {
                                NavigationLink {
                                    ExerciseListView(workoutdays: plan)
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(plan.title)
                                            .font(.headline)
                                        
                                        HStack {
                                            Text(DayOfWeek(rawValue: plan.dayOfWeek)?.displayName ?? "")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                            
                                            Spacer()
                                            
                                            Text(plan.formattedCreatedDate ?? "")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                        
                                        if plan.isCompleted {
                                            Text("Tamamlandı")
                                                .foregroundColor(.green)
                                                .font(.caption)
                                        }
                                    }
                                    .padding(.vertical, 4)
                                }
                                
                                Spacer()
                                
                                // Silme Butonu
                                Button(action: {
                                    viewModel.deleteWorkoutDay(by: plan.id)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                        }
                    }
                }
                
                Form {
                    Section(header: Text("Yeni Antrenman Planı")) {
                        TextField("Başlık", text: $viewModel.title)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        Picker("Gün Seçimi", selection: $viewModel.dayOfWeek) {
                            ForEach(DayOfWeek.allCases, id: \.self) { day in
                                Text(day.displayName).tag(day)
                            }
                        }
                    }
                    
                    Section {
                        Button(action: {
                            viewModel.createWorkoutPlan()
                        }) {
                            HStack {
                                Spacer()
                                if viewModel.isSubmitting {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                }
                                Text(viewModel.isSubmitting ? "Gönderiliyor..." : "Kaydet")
                                Spacer()
                            }
                        }
                        .disabled(viewModel.title.isEmpty || viewModel.isSubmitting)
                    }
                }
                .frame(height: 220)
            }
            .navigationTitle("Antrenman Planları")
            .navigationBarItems(
                leading: Button("İptal") {
                    dismiss()
                },
                trailing: Button(action: {
                    viewModel.workoutPlanId = workout.id
                    viewModel.getWorkoutPlans()
                }, label: {
                    Image(systemName: "repeat")
                })
            )
            .alert("Bilgi", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("Tamam") {
                    if viewModel.errorMessage == "Workout plan başarıyla gönderildi!" {
                        viewModel.getWorkoutPlans()
                        viewModel.resetFields()
                    }
                    viewModel.errorMessage = nil
                }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            .onAppear {
                viewModel.workoutPlanId = workout.id
                viewModel.getWorkoutPlans()
            }
        }
    }
}



#Preview {
    WeeklyWorkoutPlanView( workout: WorkoutCevap(id: 23, title: "", description: "", formattedStartDate: "", formattedEndDate: "", status: 0, endDate: "", startDate: ""))
}
