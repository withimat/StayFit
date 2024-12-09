//
//  Antrenman.swift
//  StayFit
//cscs
//  Created by İmat Gökaslan on 9.10.2024.
//sdscscs

import SwiftUI

struct Antrenman: View {
    @StateObject private var viewModel = AntrenmanViewModel() // ViewModel'ı bağladık

       var body: some View {
           NavigationView {
               VStack {
                   if viewModel.isLoading {
                       ProgressView("Yükleniyor...")
                   } else if let errorMessage = viewModel.errorMessage {
                       Text("Hata: \(errorMessage)")
                           .foregroundColor(.red)
                           .multilineTextAlignment(.center)
                           .padding()
                   } else {
                       ScrollView {
                           ForEach(viewModel.workoutPlan, id: \.id) { workout in
                               NavigationLink {
                                   WeeklyWorkoutGetView(workout: workout)
                                       .navigationBarBackButtonHidden(true)
                               } label: {
                                   MemberWorkoutRowView(workout: workout)
                                       .padding(.top)
                               }
                               
                               
                           }
                       }
                   }
               }
               .navigationTitle("Antrenman Planı")
               .navigationBarTitleDisplayMode(.inline)
               .toolbar {
                   ToolbarItem(placement: .navigationBarTrailing) {
                       Button(action: {
                           viewModel.fetchWorkoutPlan() // Yenile butonu
                       }) {
                           Image(systemName: "arrow.clockwise")
                       }
                   }
               }
               .onAppear {
                   viewModel.fetchWorkoutPlan() // Görünüm yüklendiğinde veri çekiliyor
               }
           }
       }
   }


#Preview {
    Antrenman()
}

