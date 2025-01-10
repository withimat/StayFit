//
//  DietDaysRowView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 5.12.2024.
//

import SwiftUI


struct DietDaysRowView: View {
    let plan: DietDays
    @StateObject var viewModel = DietDaysViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(plan.title.uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                HStack(spacing:20){
                    Button(action: {
                        withAnimation(Animation.easeInOut(duration: 1)) {
                            viewModel.deleteDietDay(by: plan.id)
                            viewModel.dietPlanId = plan.id
                            viewModel.getDietPlans()
                            
                        }
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    Image(systemName: plan.isCompleted! ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(plan.isCompleted! ? .green : .gray)
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
        .padding(.horizontal,20)
        .padding(.top,5)
    }
}



#Preview {
    DietDaysRowViewForMember(plan: DietDays(id: 12, title: "Göğüs", dayOfWeek: 1, isCompleted: true, formattedCreatedDate:"11/21/2024"))
}





struct DietDaysRowViewForMember: View {
    let plan: DietDays
    @StateObject var viewModel = DietDaysViewModel()
    @State var workout : WorkoutCevap?
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(plan.title.uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                HStack(spacing:20){
                    Button {
                        viewModel.completeDietDay(dietDayId2: plan.id)
                        viewModel.dietPlanId = workout!.id
                        viewModel.getDietPlans()
                        print("\(viewModel.errorMessage ?? "butona basıldı")")
                        
                    } label: {
                        Image(systemName: plan.isCompleted! ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(plan.isCompleted! ? .green : .gray)
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
        .padding(.horizontal,20)
        .padding(.top,5)
    }
}
