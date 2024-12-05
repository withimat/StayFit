//
//  WorkoutRowView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 22.11.2024.
//

import SwiftUI

struct WorkoutRowView: View {
    let workout: WorkoutCevap
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(workout.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                Button(action: {
                    
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .padding(10)
                        .background(Color.white.opacity(0.8))
                        .clipShape(Circle())
                        .shadow(radius: 3)
                }
                .onTapGesture {
                  
                }
            }
            .padding(.bottom, 5)

            Text(workout.description)
                .font(.body)
                .foregroundColor(.white.opacity(0.85))

            HStack {
                Text("Başlangıç: \(workout.formattedStartDate)")
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.7))
                Spacer()
                Text("Bitiş: \(workout.formattedEndDate)")
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.7))
            }
            .padding(.top, 5)

            Divider()
                .background(Color.white.opacity(0.5))
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.blue.gradient)) // Gradient background
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5) // Shadow for depth
        .padding(.horizontal)
    }
}
#Preview {
    WorkoutRowView(workout: WorkoutCevap(id: 0, title: "Diyet", description: "Su Diyeti", formattedStartDate: "11/11/22", formattedEndDate: "11/11/22", status: 0, endDate: "11/11/22", startDate: "11/11/22"))
}


struct MemberWorkoutRowView: View {
    let workout: WorkoutCevap

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(workout.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                
            }
            .padding(.bottom, 5)

            Text(workout.description)
                .font(.body)
                .foregroundColor(.white.opacity(0.85))

            HStack {
                Text("Başlangıç: \(workout.formattedStartDate)")
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.7))
                Spacer()
                Text("Bitiş: \(workout.formattedEndDate)")
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.7))
            }
            .padding(.top, 5)

            Divider()
                .background(Color.white.opacity(0.5))
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.blue.gradient)) // Gradient background
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5) // Shadow for depth
        .padding(.horizontal)
    }
}
