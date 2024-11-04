//
//  ProfileDetailView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 26.10.2024.
//

import SwiftUI


struct ProfileDetailsView: View {
    @State var profile: UserProfile  // Kullanıcı profilini parametre olarak alıyoruz
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                ZStack {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.indigo, .black, .blue]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .blur(radius: 1)
                        .frame(height: 250)
                        .edgesIgnoringSafeArea(.top)

                    VStack(spacing: 10) {
                        // Profil Fotoğrafı
                        if let photoPath = profile.photoPath {
                            AsyncImage(url: URL(string: photoPath)) { image in
                                image.resizable()
                                    .clipShape(Circle())
                                    .frame(width: 100, height: 100)
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                    .shadow(radius: 5)
                            } placeholder: {
                                ProgressView()
                            }
                        } else {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        }
                        
                        // İsim ve Bilgi
                        Text("\(profile.firstName) \(profile.lastName)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                    }
                    
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    profileInfoRow(label: "Email adresi", value: profile.email)
                    profileInfoRow(label: "Telefon Numarası", value: profile.phone)
                    profileInfoRow(label: "Kayıt Tarihi", value: profile.createdDate)
                    profileInfoRow(label: "Doğum Tarihi", value: profile.birthDate)
                    profileInfoRow(label: "Boy", value: String(profile.height))
                    profileInfoRow(label: "Kilo", value: String(profile.weight))
                    profileInfoRow(label: "Cinsiyet", value: profile.gender)
                    
                }
                .padding(.horizontal)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 5)
                .padding(.horizontal, 16)
                .offset(y:-40)
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        EditProfileView(profile: $profile) 
                    } label: {
                        Text("Düzenle")
                    }
                }
            }
        
        }
    }
    
    // Bilgi satırı için yardımcı fonksiyon
    private func profileInfoRow(label: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label.uppercased())
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.body)
        }
    }
    
    // Tarih formatlamak için yardımcı fonksiyon
    private func formatDate(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            return displayFormatter.string(from: date)
        }
        return dateString
    }
}


#Preview {
    ProfileDetailsView(profile: UserProfile(
        id: "1234",
        createdDate: "2023-01-01",
        firstName: "İmat",
        lastName: "Gökaslan",
        email: "imattgokk@example.com",
        phone: "11234567890",
        photoPath: nil,
        height: 180,  // Varsayılan height değeri eklendi
        weight: 75,   // Varsayılan weight değeri eklendi
        birthDate: "1990-01-01",
        gender: "Erkek"
    ))
}

struct AntrenorProfileDetailsView: View {
    @State var profile: AntrenorProfile  // Kullanıcı profilini parametre olarak alıyoruz
    @State private var isEditViewActive = false  // Düzenleme ekranına geçiş durumu
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    
                    // Üst Kısım: Profil Fotoğrafı ve Bilgiler
                    ZStack {
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [.indigo, .black, .blue]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .blur(radius: 1)
                            .frame(height: 250)
                            .edgesIgnoringSafeArea(.top)

                        VStack(spacing: 10) {
                            // Profil Fotoğrafı
                            if let photoPath = profile.photoPath {
                                AsyncImage(url: URL(string: photoPath)) { image in
                                    image.resizable()
                                        .clipShape(Circle())
                                        .frame(width: 100, height: 100)
                                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                        .shadow(radius: 5)
                                } placeholder: {
                                    ProgressView()
                                }
                            } else {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.gray)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            }
                            
                            // İsim ve Bilgi
                            Text("\(profile.firstName) \(profile.lastName)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        profileInfoRow(label: "Email adresi", value: profile.email)
                        profileInfoRow(label: "Telefon Numarası", value: profile.phone)
                        profileInfoRow(label: "Doğum Tarihi", value: formatDate(profile.birthDate))
                        profileInfoRow(label: "Biyografi", value: profile.bio)
                        profileInfoRow(label: "Cinsiyet", value: profile.gender)
                        profileInfoRow(label: "Kayıt Tarihi", value: formatDate(profile.createdDate))
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    .padding(.horizontal, 16)
                    .offset(y: -40)

                    Spacer()  // Boş alan eklenir
                }
            }
            .overlay(alignment: .topTrailing) {  // Butonu sağ üst köşeye eklemek için
                Button {
                    isEditViewActive = true  // Düzenleme ekranına yönlendirme tetiklenir
                } label: {
                    Text("Düzenle")
                        .foregroundColor(.blue)
                        .padding(8)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        .padding([.trailing, .top], 16)
                }
            }
            .navigationDestination(isPresented: $isEditViewActive) {
                EditAntrenorProfileView(profile: $profile)
                   
            }
            .navigationTitle("Antrenör Profilim")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // Bilgi satırı için yardımcı fonksiyon
    private func profileInfoRow(label: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label.uppercased())
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.body)
        }
    }
    
    // Tarih formatlamak için yardımcı fonksiyon
    private func formatDate(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "dd/MM/yyyy"  // Gün, Ay, Yıl formatı
            return displayFormatter.string(from: date)
        }
        return dateString
    }
}
