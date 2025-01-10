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
                          if viewModel.progresses.isEmpty {
                              Text("Gelişim Verisi Bulunamadı")
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
    WeeklyProgressCard(progress: WeeklyProgressModel(id: 12, height: 180, weight: 80, fat: 30, bmi: 10, waistCircumference: 10, neckCircumference: 10, chestCircumference: 10, creator: 1, formattedCreatedDate: "11/22/23"))
}

// MARK: - Progress Card View
struct WeeklyProgressCard: View {
    let progress: WeeklyProgressModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Progress Details")
                    .font(.headline)
                Spacer()
                Text(progress.formattedCreatedDate)
                    .foregroundColor(.gray)
                    .font(.system(size: 15))
            }
            .padding(.vertical)
            
            Group {
                InfoRow(title: "Boy", value: "\(progress.height) cm")
                InfoRow(title: "Kilo", value: String(format: "%.1f kg", progress.weight))
                InfoRow(title: "Yağ Oranı", value: String(format: "%.1f%%", progress.fat))
                InfoRow(title: "Vüxut Kitle İndeksi", value: String(format: "%.1f", progress.bmi))
                InfoRow(title: "Bel ", value: String(format: "%.1f cm", progress.waistCircumference))
                InfoRow(title: "Boyun", value: String(format: "%.1f cm", progress.neckCircumference))
                InfoRow(title: "Göğüs", value: String(format: "%.1f cm", progress.chestCircumference))
            }
            HStack{
                Spacer()
                if progress.creator == 1{
                    Text("Yapay zeka tarafından oluşturuldu.")
                        .bold()
                        .padding()
                }
                Spacer()
            }
            
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(.horizontal)
        
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
