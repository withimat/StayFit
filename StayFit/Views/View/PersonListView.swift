//
//  PersonListView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 20.10.2024.
//


import SwiftUI

struct PersonListView: View {
    @StateObject private var viewModel = AntrenorListViewModel() // ViewModel'i izliyoruz
    @State private var odemetiklandi: Bool = false
    @Environment(\.dismiss) var dismiss
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "BG")
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(named: "beyaz")!,
            .font: UIFont(name: "Pacifico-Regular", size: 22)!
        ]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }

    var body: some View {
        NavigationView {
            VStack {
                Group {
                    Text("Lütfen Bir antrenör seçin ve devam edin")
                        .padding(.top, 16)
                        .font(.headline)
                }

                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.persons) { person in
                            NavigationLink(destination: PersonDetailView(person: person)
                                .navigationBarBackButtonHidden(true)
                            
                            ) {
                                PersonRowView(person: person)
                                    .padding()
                                    .background(Color.white) // Arkaplan rengi
                                    .cornerRadius(10) // Kenarları yuvarlatılmış kart görünümü
                                    .shadow(radius: 4) // Gölge eklemek
                                    .padding(.horizontal, 16)
                                    .padding(.top)
                            }
                        }
                    }
                }
                .navigationTitle("Trainer Listesi")
                .navigationBarTitleDisplayMode(.inline)
            }
            .toolbar{
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
}

#Preview {
    PersonListView()
}
struct PersonDetailView: View {
    let person: Person
    @State private var showAlert = false  // Alert kontrolü
    @State private var navigateToMainTab = false
    @Environment(\.dismiss) var dismiss
    func saveTrainerToUserDefaults(_ person:Person) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(person) {
            UserDefaults.standard.set(encoded, forKey: "selectedPerson")
        }
    }
    
    var body: some View {
        NavigationStack{
            ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            // Üst Başlık ve Fotoğraf
                            VStack(spacing: 12) {
                                Image(person.photoPath ?? "hoca")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 120)
                                    .clipShape(Circle())
                                    .shadow(radius: 8)

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
                                    saveTrainerToUserDefaults(person)
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

                            // Biyografi
                           

                            Spacer()
                        }
                        .padding(.bottom, 20)
                    }
            .navigationTitle("Kişi Detayı")
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Seçim Yapıldı"),
                    message: Text("Seçiminiz kaydedilmiştir.\(person.firstName.uppercased()) Hoca ile devam edeceksinzi.. Şimdi ana menüye yönlendirileceksiniz."),
                    dismissButton: .default(Text("Tamam"), action: {
                        navigateToMainTab = true  // Ana menüye geçiş başlat
                    })
                )
            }
            .navigationDestination(isPresented: $navigateToMainTab) {
                MainTabView()  // Ana menüye geçiş
            }
            .toolbar{
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


struct PersonRowView: View {
    let person: Person

    var body: some View {
        HStack(spacing: 16) {
            Image(person.photoPath ?? "hoca")
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70)
                .clipShape(Circle()) // Fotoğrafı yuvarlak yapar
                .shadow(radius: 5) // Gölge ekler

            VStack(alignment: .leading, spacing: 4) {
                Text("\(person.firstName) \(person.lastName)")
                    .font(.headline)
                    .foregroundColor(.primary) // Varsayılan metin rengi
                Text(person.bio)
                    .font(.subheadline)
                    .foregroundColor(.secondary) // Daha açık bir metin rengi
                    .lineLimit(2) // Maksimum 2 satırda sınırlandırma
            }
            Spacer() // HStack içeriğini sola yaslar
        }
        .padding(12)
        .padding(.horizontal, 16)
    }
}
