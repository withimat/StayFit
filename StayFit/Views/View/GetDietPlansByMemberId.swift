//
//  GetDietPlansByMemberId.swift
//  StayFit
//
//  Created by İmat Gökaslan on 9.12.2024.
//

import SwiftUI

struct GetDietPlansByMemberId: View {
    @ObservedObject var viewModel = DietDaysViewModel()
    @Environment(\.dismiss) var dismiss
    var workout: WorkoutCevap
    @State var showAlert = false
    @State var alertMessage = ""
    @State var isError = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Yükleniyor...")
                } else if viewModel.dietDays.isEmpty {
                    Text("Diyet planı yok.")
                        .foregroundColor(.gray)
                } else {
                    DietPlansScrollView(dietDays: viewModel.dietDays, workout: workout, viewModel: viewModel)
                }
                Spacer()
            }
            .navigationTitle("Diyet Planları")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("İptal") {
                    dismiss()
                },
                trailing: Button(action: {
                    viewModel.dietPlanId = workout.id
                    viewModel.getDietPlans()
                }, label: {
                    Image(systemName: "repeat")
                })
            )
            .alert("Bilgi", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("Tamam") {
                    if viewModel.errorMessage == "Tebrikler!! Bugünü tamamladınız..." {
                        withAnimation(Animation.easeInOut(duration: 2.0)) {
                            viewModel.dietPlanId = workout.id
                            viewModel.getDietPlans()
                        }
                    }
                    withAnimation(Animation.easeOut(duration: 1)) {
                        viewModel.dietPlanId = workout.id
                        viewModel.getDietPlans()
                        viewModel.errorMessage = nil
                    }
                }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            .onAppear {
                viewModel.dietPlanId = workout.id
                
                    viewModel.getDietPlans()
                
            }
        }
    }
}

struct DietPlansScrollView: View {
    let dietDays: [DietDays]
    let workout: WorkoutCevap
    let viewModel: DietDaysViewModel

    var body: some View {
        ScrollView {
            ForEach(sortedDietDays, id: \.id) { plan in
                NavigationLink {
                    DietListForMemberView(workoutdays: plan)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    DietDaysRowViewForMember(plan: plan, viewModel: viewModel, workout: workout)
                }
            }
        }
    }

    // DietDays sorted by DayOfWeek
    private var sortedDietDays: [DietDays] {
        dietDays.sorted { first, second in
            let firstSortOrder = DayOfWeek(rawValue: first.dayOfWeek)?.sortOrder ?? Int.max
            let secondSortOrder = DayOfWeek(rawValue: second.dayOfWeek)?.sortOrder ?? Int.max
            return firstSortOrder < secondSortOrder
        }
    }
}

#Preview {
    GetDietPlansByMemberId(workout: WorkoutCevap(
        id: 9,
        title: "",
        description: "",
        formattedStartDate: "",
        formattedEndDate: "",
        status: 0,
        endDate: "",
        startDate: "")
    )
}
