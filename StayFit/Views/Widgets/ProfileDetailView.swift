//
//  ProfileDetailView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 26.10.2024.
//

import SwiftUI


struct ProfileDetailsView: View {
    @State var profile: UserProfile
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
                    profileInfoRow(label: "Kayıt Tarihi", value: formatDate(isoDate: profile.createdDate))
                    profileInfoRow(label: "Doğum Tarihi", value: formatDate(isoDate: profile.birthDate))
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
                            .foregroundColor(.white)
                           
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
    func formatDate(isoDate: String) -> String {
            let dateFormatter = ISO8601DateFormatter()
            dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

            // ISO 8601 tarihini Date formatına dönüştür
            if let date = dateFormatter.date(from: isoDate) {
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "dd/MM/yyyy"
                return outputFormatter.string(from: date)
            }

            return "Geçersiz tarih"
        }
}


#Preview {
    AntrenorProfileDetailsView(profile: AntrenorProfile(id: "", createdDate: "12/20/24", firstName: "İmat", lastName: "Gokaslan", email: "imatt@gmail.com", phone: "5380354884", birthDate: "15/18/23", gender: "Kadın", monthlyRate: 5000, bio: "Yoga Eğitmeni"))
}


struct AntrenorProfileDetailsView: View {
    @State var profile: AntrenorProfile
   
    var body: some View {
        
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
                        profileInfoRow(label: "Doğum Tarihi", value: formatDate(isoDate: profile.birthDate))
                        profileInfoRow(label: "Biyografi", value: profile.bio)
                        profileInfoRow(label: "Cinsiyet", value: profile.gender)
                        profileInfoRow(label: "Kayıt Tarihi", value: formatDate(isoDate: profile.createdDate))
                    }
                    .padding(.horizontal)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    .padding(.horizontal, 16)
                    .offset(y:-40)

                    Spacer()  // Boş alan eklenir
                }
                .navigationTitle("Antrenör Profilim")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            EditAntrenorProfileView(profile: $profile)
                        } label: {
                            Text("Düzenle")
                                .foregroundColor(.white)
                               
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
    func formatDate(isoDate: String) -> String {
            let dateFormatter = ISO8601DateFormatter()
            dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

            // ISO 8601 tarihini Date formatına dönüştür
            if let date = dateFormatter.date(from: isoDate) {
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "dd/MM/yyyy"
                return outputFormatter.string(from: date)
            }

        return isoDate
        }
}
