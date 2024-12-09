//
//  GetDietPlansByMemberId.swift
//  StayFit
//
//  Created by İmat Gökaslan on 9.12.2024.
//

import SwiftUI

struct GetDietPlansByMemberId: View {
    @StateObject private var viewModel = DietDaysViewModel()
        @Environment(\.dismiss) var dismiss
        var workout: WorkoutCevap
        
        var body: some View {
            NavigationStack {
                VStack {
                    if viewModel.isLoading {
                        ProgressView("Yükleniyor...")
                    } else if viewModel.dietDays.isEmpty{
                        Text("Diyet planı yok.")
                            .foregroundColor(.gray)
                    }
                    else {
                        ScrollView{
                            ForEach(viewModel.dietDays.sorted(by: { $0.dayOfWeek < $1.dayOfWeek })) { plan in
                                    NavigationLink {
                                        DietListForMemberView(workoutdays: plan)
                                            .navigationBarBackButtonHidden(true)
                                    } label: {
                                        DietDaysRowViewForMember(plan: plan)
                                    }
                            }
                        }
                        
                        
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
               

                .onAppear {
                    viewModel.dietPlanId = workout.id
                    withAnimation(Animation.easeInOut(duration: 0.5)) {
                        viewModel.getDietPlans()
                    }
                    
                }
            }
        }
    }



    #Preview {
        GetDietPlansByMemberId( workout: WorkoutCevap(id: 9, title: "", description: "", formattedStartDate: "", formattedEndDate: "", status: 0, endDate: "", startDate: ""))
    }
