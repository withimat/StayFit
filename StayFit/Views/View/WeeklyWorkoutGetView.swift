//
//  WeeklyWorkoutGetView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 24.11.2024.
//

import SwiftUI

struct WeeklyWorkoutGetView: View {
    @StateObject private var viewModel = WeeklyWorkoutPlanViewModel()
    @Environment(\.dismiss) var dismiss
    let workout : WorkoutCevap
     var body: some View {
         NavigationStack {
             VStack {
                     List {
                         ForEach(viewModel.workoutDays) { plan in
                             NavigationLink {
                                 MemberExerciseListView(workoutdays: plan)
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
                                         
                                         Text(plan.formattedCreatedDate!)
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

                         }
                     }
                 
              
                 
             }
             .navigationTitle("Antrenman Planları")
             .navigationBarTitleDisplayMode(.inline)
             .navigationBarItems(
                 leading: Button("İptal") {
                     dismiss()
                 }
             )
             .onAppear {
                 //WorkoutDays = viewModel.workoutDays
                 viewModel.workoutPlanId = workout.id
                 viewModel.getWorkoutPlans()
             }
         }
     }
 }


#Preview {
    WeeklyWorkoutGetView( workout: WorkoutCevap(id: 2, title: "Paazartesi", description: "", formattedStartDate: "", formattedEndDate: "", status: 0, endDate: "", startDate: ""))
}
