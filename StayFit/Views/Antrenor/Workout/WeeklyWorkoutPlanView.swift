//
//  WeeklyWorkoutPlanView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 3.12.2024.
//  viewModel.workoutPlanId = workout.id
//.sorted(by: { $0.dayOfWeek < $1.dayOfWeek })

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
                    ScrollView {
                        ForEach(viewModel.workoutDays.sorted(by: {
                            let firstSortOrder = DayOfWeek(rawValue: $0.dayOfWeek)?.sortOrder ?? Int.max
                            let secondSortOrder = DayOfWeek(rawValue: $1.dayOfWeek)?.sortOrder ?? Int.max
                            return firstSortOrder < secondSortOrder
                        })) { plan in
                            NavigationLink {
                                ExerciseListView(workoutdays: plan)
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                WeeklyWorkoutDayRowView(plan: plan, viewModel: viewModel)
                            }
                        }
                    }

                    
                    
                }
                Spacer()
                Form {
                    Section(header: Text("Yeni Antrenman Planı")) {
                        TextField("Başlık", text: $viewModel.title)
                        
                        Picker("Gün Seçimi", selection: $viewModel.dayOfWeek) {
                            ForEach(DayOfWeek.allCases, id: \.self) { day in
                                Text(day.displayName).tag(day)
                            }
                        }
                    }
                    
                    Section {
                        Button(action: {
                            viewModel.createWorkoutPlan()
                            viewModel.workoutPlanId = workout.id
                            viewModel.getWorkoutPlans()
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
            .navigationBarTitleDisplayMode(.inline)
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
                    if viewModel.errorMessage == "Antrenman Planı başarıyla gönderildi!" {
                        withAnimation(Animation.easeInOut(duration: 2.0)) { // 1 saniye süreyle animasyon
                            viewModel.resetFields()
                            viewModel.workoutPlanId = workout.id
                            viewModel.getWorkoutPlans()
                        }
                    }
                    withAnimation(Animation.easeOut(duration: 1)) { // 0.5 saniyelik daha hızlı bir animasyon
                        viewModel.errorMessage = nil
                    }
                }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            .onAppear {
                viewModel.workoutPlanId = workout.id
                withAnimation(Animation.easeInOut(duration: 0.5)) {
                    viewModel.getWorkoutPlans()
                }
                
            }
        }
    }
}



#Preview {
    WeeklyWorkoutPlanView( workout: WorkoutCevap(id: 2, title: "", description: "", formattedStartDate: "", formattedEndDate: "", status: 0, endDate: "", startDate: ""))
}
