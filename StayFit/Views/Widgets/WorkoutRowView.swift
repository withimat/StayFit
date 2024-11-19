//
//  WorkoutRowView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 22.11.2024.
//

import SwiftUI

struct WorkoutRowView: View {
    let workout: WorkoutCevap// Modelin adı `Workout` olduğunu varsayıyoruz

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(workout.title)
                .font(.headline)
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
        .padding(.vertical, 5)
    }
}


