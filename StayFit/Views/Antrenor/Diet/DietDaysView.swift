//
//  DietDaysView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 5.12.2024.
//

import SwiftUI

struct DietDaysView: View {
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
                    ScrollView {
                        ForEach(viewModel.dietDays.sorted(by: {
                            let firstSortOrder = DayOfWeek(rawValue: $0.dayOfWeek)?.sortOrder ?? Int.max
                            let secondSortOrder = DayOfWeek(rawValue: $1.dayOfWeek)?.sortOrder ?? Int.max
                            return firstSortOrder < secondSortOrder
                        })) { plan in
                            NavigationLink {
                                DietListView(workoutdays: plan)
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                DietDaysRowView(plan: plan, viewModel: viewModel)
                            }
                        }
                    }

                    
                    
                }
                Spacer()
                Form {
                    Section(header: Text("Yeni Diet Planı")) {
                        TextField("Başlık", text: $viewModel.title)
                        
                        Picker("Gün Seçimi", selection: $viewModel.dayOfWeek) {
                            ForEach(DayOfWeek.allCases, id: \.self) { day in
                                Text(day.displayName).tag(day)
                            }
                        }
                    }
                    
                    Section {
                        Button(action: {
                            viewModel.createDietPlan()
                            withAnimation(Animation.easeInOut(duration: 2)) {
                                viewModel.dietPlanId = workout.id
                                viewModel.getDietPlans()
                                viewModel.resetFields()
                            }
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
                    if viewModel.errorMessage == "Diyet planı başarıyla gönderildi!" {
                        withAnimation(Animation.easeInOut(duration: 1)) {
                            viewModel.resetFields()
                            viewModel.dietPlanId = workout.id
                            viewModel.getDietPlans()
                        }
                    }
                    else {
                       
                            viewModel.errorMessage = ""
                            viewModel.getDietPlans()
                    }
                }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }

            .onAppear {
                withAnimation(Animation.easeInOut(duration: 2)) {
                    viewModel.dietPlanId = workout.id
                    
                    viewModel.getDietPlans()
                    
                }
            }
        }
    }
}



#Preview {
    DietDaysView( workout: WorkoutCevap(id: 9, title: "", description: "", formattedStartDate: "", formattedEndDate: "", status: 0, endDate: "", startDate: ""))
}
