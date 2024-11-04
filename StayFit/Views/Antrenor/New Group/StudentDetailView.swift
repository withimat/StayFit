//
//  StudentDetailView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 1.11.2024.
//

import SwiftUI


struct StudentDetailView: View {
    let student: Student
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            if let photoPath = student.photoPath, let url = URL(string: photoPath) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
            }
            
            
            Text("\(student.firstName) \(student.lastName)")
                .font(.title)
                .fontWeight(.bold)
            
            Text("ID: \(student.id)")
                .font(.subheadline)
            
            Text("End Date: \(student.endDate)")
                .font(.subheadline)
            
            Text("Amount: \(student.amount) TL")
                .font(.subheadline)
            
            Text("Height: \(student.height) cm")
                .font(.subheadline)
            
            Text("Weight: \(student.weight) kg")
                .font(.subheadline)
            
            Text("Gender: \(student.gender == 0 ? "Male" : "Female")")
                .font(.subheadline)
            
            Text("Birth Date: \(student.birthDate)")
                .font(.subheadline)
        }
        .padding()
        .navigationTitle("Detaylar")
    }
}

