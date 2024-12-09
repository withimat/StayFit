//
//  StudentWorkoutView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 9.12.2024.
//

import SwiftUI

struct StudentWorkoutView: View {
    @ObservedObject var viewModel: StudentDetailViewModel
    let student : Student
    var body: some View {
        NavigationStack{
            VStack{
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
                .padding(.top)
                .padding(.horizontal)
                
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Antrenman Planları")
                        .fontWeight(.semibold)
                        .font(.headline)
                    
                    if viewModel.isLoading {
                        ProgressView("Antrenman planları yükleniyor...")
                    } else if viewModel.workoutPlan.isEmpty {
                        Text("Henüz antrenman planı yok.")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(viewModel.workoutPlan, id: \.id) { workout in
                            
            NavigationLink {
                
            WeeklyWorkoutPlanView( workout: workout)
                .navigationBarBackButtonHidden(true)
                            }
                        label: {
            VStack(alignment: .leading, spacing: 8) {
            HStack {
            Text(workout.title)
                .font(.headline)
                
               

            Spacer()
                Button {
                    withAnimation {
                       
                        if let index = viewModel.workoutPlan.firstIndex(where: { $0.id == workout.id }) {
                            viewModel.workoutPlan.remove(at: index)
                        }
                    }
                    
                    viewModel.deleteWorkoutPlan(id: workout.id)
                } label: {
                    Image(systemName: "trash")
                }

           }
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
                Spacer()
            }
            .navigationTitle("Antrenman")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(){
                viewModel.fetchWorkoutPlan(subscriptionId: "\(student.id)")
            }
        }
    }
}


struct StudentDietView: View {
    @ObservedObject var viewModel: StudentDetailViewModel
    let student : Student
    var body: some View {
        NavigationStack{
            VStack{
                HStack {
                    Spacer()
                    NavigationLink {
                        AntrenorDietPlanView(student: student)
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Yeni bir Diyet programı ekle")
                            .padding()
                            .font(.system(size: 15))
                            .clipShape(Rectangle())
                            .background(.gray)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal)
         
                
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Diyet Planları")
                        .fontWeight(.semibold)
                        .font(.headline)
                    
                    if viewModel.isLoading2 {
                        ProgressView("Diyet planları yükleniyor...")
                    } else if viewModel.dietPlan.isEmpty {
                        Text("Henüz diyet planı yok.")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(viewModel.dietPlan, id: \.id) { diet in
                            
            NavigationLink {
                DietDaysView(workout: diet)
                    .navigationBarBackButtonHidden(true)
                            }
                        label: {
            VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(diet.title)
                .font(.headline)
                
               

            Spacer()
                Button {
                    withAnimation {
                       
                        if let index = viewModel.dietPlan.firstIndex(where: { $0.id == diet.id }) {
                            viewModel.dietPlan.remove(at: index)
                        }
                    }
                    
                    viewModel.deleteDietPlan(id: diet.id)
                } label: {
                    Image(systemName: "trash")
                }

           }
           Text(diet.description)
               .font(.subheadline)
               .foregroundColor(.gray)
           HStack {
               Text("Başlangıç: \(diet.formattedStartDate)")
               Spacer()
               Text("Bitiş: \(diet.formattedEndDate)")
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
                Spacer()
            }
            .onAppear(){
                viewModel.fetchDietPlan(subscriptionId: "\(student.id)")
            }
        }
    }
}
