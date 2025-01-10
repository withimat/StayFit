//
//  WeeklyWorkoutGetView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 24.11.2024.
//

import SwiftUI

struct WeeklyWorkoutGetView: View {
    @ObservedObject var viewModel = WeeklyWorkoutPlanViewModel()
    @Environment(\.dismiss) var dismiss
    var workout: WorkoutCevap

    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isError = false

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    ForEach(viewModel.workoutDays.sorted(by: {
                        let firstSortOrder = DayOfWeek(rawValue: $0.dayOfWeek)?.sortOrder ?? Int.max
                        let secondSortOrder = DayOfWeek(rawValue: $1.dayOfWeek)?.sortOrder ?? Int.max
                        return firstSortOrder < secondSortOrder
                    })) { plan in
                        NavigationLink {
                            MemberExerciseListView(workoutdays: plan)
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            WeeklyWorkoutDayRowViewForMember(workout: workout, plan: plan, viewModel: viewModel)
                        }
                    }
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
                        if viewModel.errorMessage == "Tebrikler!! Bugünü tamamladınız..." {
                            withAnimation(Animation.easeInOut(duration: 2.0)) {
                                viewModel.workoutPlanId = workout.id
                                viewModel.getWorkoutPlans()
                               
                            }
                        }
                        withAnimation(Animation.easeOut(duration: 1)) {
                            viewModel.workoutPlanId = workout.id
                            viewModel.getWorkoutPlans()
                            viewModel.errorMessage = nil
                        }
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
}


#Preview {
    WeeklyWorkoutGetView( workout: WorkoutCevap(id: 12, title: "İmat", description: "", formattedStartDate: "", formattedEndDate: "", status: 0, endDate: "", startDate: ""))
}
