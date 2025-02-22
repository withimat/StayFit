//
//  WeeklyWorkoutDayRowView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 3.12.2024.
//

import SwiftUI


struct WeeklyWorkoutDayRowView: View {
    let plan: WorkoutDays
    @StateObject var viewModel = WeeklyWorkoutPlanViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(plan.title.uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                HStack(spacing: 20) {
                    Button(action: {
                        withAnimation(Animation.easeInOut(duration: 1)) {
                            viewModel.deleteWorkoutDay(by: plan.id)
                        }
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    Image(systemName: plan.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(plan.isCompleted ? .green : .gray)
                }
            }
            HStack {
                Text(DayOfWeek(rawValue: plan.dayOfWeek)?.displayName ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text(plan.formattedCreatedDate ?? "")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .frame(height: 50)
        .padding(30)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue.opacity(0.3))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 2)
        )
        .padding(.horizontal, 20)
        .padding(.top, 5)
    }
}

#Preview {
    WeeklyWorkoutDayRowView(plan: WorkoutDays(id: 12, title: "İmat", dayOfWeek: 1, isCompleted: false))
}



struct WeeklyWorkoutDayRowViewForMember: View {
    @State var workout : WorkoutCevap?
    let plan: WorkoutDays
    @ObservedObject var viewModel: WeeklyWorkoutPlanViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(plan.title.uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                HStack(spacing: 20) {
                    Button {
                        viewModel.completeWorkoutDay(workoutDayId2: plan.id)
                        viewModel.workoutPlanId = workout!.id
                        viewModel.getWorkoutPlans()
                        
                       
                    } label: {
                        Image(systemName: plan.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(plan.isCompleted ? .green : .gray)
                    }
                }
            }
            HStack {
                Text(DayOfWeek(rawValue: plan.dayOfWeek)?.displayName ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Text(plan.formattedCreatedDate ?? "")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .frame(height: 50)
        .padding(30)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue.opacity(0.3))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 2)
        )
        .padding(.horizontal, 20)
        .padding(.top, 5)
    }
}
