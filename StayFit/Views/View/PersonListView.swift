//
//  PersonListView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 20.10.2024.
//


import SwiftUI


struct AntrenorListesiDetaySayfasi: View {
    let person: Person
    @State private var showAlert = false  // Alert kontrolü
    @State private var navigateToMainTab = false
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = AntrenorListViewModel()
    
    var body: some View {
        NavigationStack{
            ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            // Üst Başlık ve Fotoğraf
                            VStack(spacing: 12) {
                                if let photoPath = person.photoPath, let url = URL(string: photoPath) {
                                    AsyncImage(url: url) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView() // Yükleme sırasında gösterilecek
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 120, height: 120)
                                                .clipShape(Circle())
                                                .shadow(radius: 8)
                                        case .failure(_):
                                            Image("hoca") // Hata durumunda yedek görsel
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 120, height: 120)
                                                .clipShape(Circle())
                                                .shadow(radius: 8)
                                        @unknown default:
                                            Image("hoca") // Beklenmedik durumlarda yedek görsel
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 120, height: 120)
                                                .clipShape(Circle())
                                                .shadow(radius: 8)
                                        }
                                    }
                                } else {
                                    Image("hoca") // Eğer photoPath boşsa yedek görsel
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 120, height: 120)
                                        .clipShape(Circle())
                                        .shadow(radius: 8)
                                }

                                Text("\(person.firstName) \(person.lastName)")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 20)

                            // İletişim Bilgileri
                            VStack(alignment: .leading, spacing: 8) {
                                Text("İletişim Bilgileri")
                                    .font(.title2)
                                    .fontWeight(.semibold)

                                HStack {
                                    Image(systemName: "envelope")
                                    Text(person.email)
                                }
                                HStack {
                                    Image(systemName: "phone")
                                    Text(person.phone)
                                }
                            }
                            .padding(.horizontal)

                            // Kişisel Bilgiler
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Kişisel Bilgiler")
                                    .font(.title2)
                                    .fontWeight(.semibold)

                                HStack {
                                    Image(systemName: "person.fill")
                                    Text("Cinsiyet: \(person.gender)")
                                    
                                }

                                if let birthDate = formatDate(person.birthDate) {
                                    HStack {
                                        Image(systemName: "calendar")
                                        Text("Doğum Tarihi: \(birthDate)")
                                    }
                                }

                                if let createdDate = formatDate(person.createdDate) {
                                    HStack {
                                        Image(systemName: "clock")
                                        Text("Oluşturulma Tarihi: \(createdDate)")
                                    }
                                }
                            }
                            .padding(.horizontal)

                            // Fiyat Bilgisi ve Ödeme Butonu
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Fiyat ve Ödeme")
                                    .font(.title2)
                                    .fontWeight(.semibold)

                                HStack {
                                    Image(systemName: "creditcard")
                                    Text("Ücret: \(person.monthlyRate) TL / Seans")
                                        .font(.headline)
                                        .foregroundColor(.green)
                                }

                                VStack(alignment: .leading, spacing: 10) {
                                    HStack {
                                        Text("Biyografi")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                        Spacer()
                                    }

                                    Text(person.bio)
                                        .font(.body)
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                Button(action: {
                                    viewModel.sendSubscriptionRequest(personID: person.id)
                                    showAlert = true
                                }) {
                                    Text("Ödeme Yap")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity, minHeight: 50)
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                }
                            }
                            .padding(.horizontal)

                            Spacer()
                        }
                        .padding(.bottom, 20)
                    }
                    .navigationTitle("Kişi Detayı")
                    .navigationBarTitleDisplayMode(.inline)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Seçim Yapıldı"),
                            message: Text("Seçiminiz kaydedilmiştir. \(person.firstName.uppercased()) Hoca ile devam edeceksiniz. Şimdi ana menüye yönlendirileceksiniz."),
                            dismissButton: .default(Text("Tamam"), action: {
                                navigateToMainTab = true  // Ana menüye geçiş başlat
                            })
                        )
                    }
                    .navigationDestination(isPresented: $navigateToMainTab) {
                        MainTabView()  // Ana menüye geçiş
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Image(systemName: "chevron.left")
                                .imageScale(.large)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    dismiss()
                                }
                        }
                    }
        }
    }

    // Tarih formatlama fonksiyonu
    private func formatDate(_ dateString: String) -> String? {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: dateString) else { return nil }

        let outputFormatter = DateFormatter()
        outputFormatter.dateStyle = .medium
        outputFormatter.timeStyle = .none
        return outputFormatter.string(from: date)
    }
}
