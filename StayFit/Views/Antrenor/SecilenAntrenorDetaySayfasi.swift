//
//  SecilenAntrenorDetaySayfasi.swift
//  StayFit
//
//  Created by İmat Gökaslan on 2.11.2024.
//

import SwiftUI

struct SecilenAntrenorDetaySayfasi: View {
    let person: GelenAntrenor
    var body: some View {
        VStack(spacing: 20) {
            if let photoPath = person.photoPath, let url = URL(string: photoPath) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
            }

            Text("\(person.firstName) \(person.lastName)")
                .font(.title)
                .fontWeight(.bold)

            Text("Abonelik Ücreti: \(person.amount) tl ")
                .font(.headline)

            
            Text("Abonelik Bitiş Tarihi: \(person.endDate)")
                    .font(.subheadline)
            

            Spacer()
        }
        .padding()
        .navigationTitle("Antrenör Detayları")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SecilenAntrenorDetaySayfasi(person: GelenAntrenor(subscriptionId: "12", trainerId: "121", firstName: "İmat", lastName: "GÖKASLAN", amount: 4000, endDate: "11/12/2024",photoPath: "https://minieticaretdodo.blob.core.windows.net/user-images/selectedImage-10.jpg"))
}
