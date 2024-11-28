//
//  WeeklyProgressResultView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 25.11.2024.
//

import SwiftUI

struct WeeklyProgressResultView: View {
    @StateObject private var viewModel = WeeklyProgressResultModelView()
      let subscriptionId: String
      
      var body: some View {
          ZStack {
              if viewModel.isLoading {
                  ProgressView("Loading...")
              } else {
                  ScrollView {
                      VStack(spacing: 16) {
                          if let error = viewModel.errorMessage {
                              Text(error)
                                  .foregroundColor(.red)
                                  .padding()
                          } else if viewModel.progresses.isEmpty {
                              Text("No progress data available")
                                  .foregroundColor(.gray)
                                  .padding()
                          } else {
                              Text(viewModel.message)
                                  .font(.headline)
                                  .padding(.bottom)
                              
                              ForEach(viewModel.progresses, id: \.id) { progress in
                                  WeeklyProgressCard(progress: progress)
                              }
                          }
                      }
                      .padding()
                  }
              }
          }
          .onAppear {
              print("gelen subsid : \(subscriptionId)")
              print("***************")
              viewModel.fetchProgresses(subscriptionId: subscriptionId)
              print("gelen subsid : \(subscriptionId)")
          }
      }
  }
    
    
#Preview {
    WeeklyProgressResultView(subscriptionId: "12")
}

// MARK: - Progress Card View
struct WeeklyProgressCard: View {
    let progress: WeeklyProgressModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Progress Details")
                .font(.headline)
            
            Group {
                InfoRow(title: "Height", value: "\(progress.height) cm")
                InfoRow(title: "Weight", value: String(format: "%.1f kg", progress.weight))
                InfoRow(title: "Fat", value: String(format: "%.1f%%", progress.fat))
                InfoRow(title: "BMI", value: String(format: "%.1f", progress.bmi))
                InfoRow(title: "Waist", value: String(format: "%.1f cm", progress.waistCircumference))
                InfoRow(title: "Neck", value: String(format: "%.1f cm", progress.neckCircumference))
                InfoRow(title: "Chest", value: String(format: "%.1f cm", progress.chestCircumference))
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

// MARK: - Helper View
struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .bold()
        }
    }
}
