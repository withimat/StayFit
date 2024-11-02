//
//  AntrenorListesiRow.swift
//  StayFit
//
//  Created by İmat Gökaslan on 2.11.2024.
//

import SwiftUI


struct PersonRowView : View {
    let person: Person
    @ObservedObject var viewmodel = AntrenorListViewModel()
    
    var body: some View {
        HStack(spacing: 16) {
            if let photoPath = person.photoPath, let url = URL(string: photoPath) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView() // Yükleme sırasında gösterilecek
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    case .failure(_):
                        Image("hoca") // Hata durumunda yedek görsel
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    @unknown default:
                        Image("hoca") // Beklenmedik durumlarda yedek görsel
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                }
            } else {
                Image("hoca") // Eğer photoPath boşsa yedek görsel
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                    .shadow(radius: 5)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(person.firstName) \(person.lastName)")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(person.bio)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            Spacer()
        }
        .onAppear {
            viewmodel.fetchPersons()
        }
        .padding(12)
        .padding(.horizontal, 16)
    }
}
