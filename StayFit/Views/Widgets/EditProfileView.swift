//
//  EditProfileView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 26.10.2024.
//

import SwiftUI


struct EditProfileView: View {
    @Binding var profile: UserProfile  // Binding kullanarak bilgileri geri döndürüyoruz
    @Environment(\.presentationMode) var presentationMode  // Sayfayı kapatmak için
    
    var body: some View {
        VStack{
            Fotoyukleme()
            Form {
                Section(header: Text("Kişisel Bilgiler")) {
                    TextField("Ad", text: $profile.firstName)
                    TextField("Soyad", text: $profile.lastName)
                    TextField("Telefon", text: $profile.phone)
                }
                
                Section(header: Text("Fiziksel Bilgiler")) {
                    TextField("Boy (cm)", value: $profile.height, format: .number)
                    TextField("Kilo (kg)", value: $profile.weight, format: .number)
                    TextField("Doğum Tarihi", text: $profile.birthDate)
                    Picker("Cinsiyet", selection: $profile.gender) {
                        Text("Erkek").tag("Erkek")
                        Text("Kadın").tag("Kadın")
                        Text("Diğer").tag("Diğer")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Button("Kaydet") {
                    // Güncellemeyi kaydet ve geri dön
                    presentationMode.wrappedValue.dismiss()
                }
            }
            
        }
        .navigationTitle("Profili Düzenle")
        .navigationBarTitleDisplayMode(.inline)
    }
}




struct EditAntrenorProfileView: View {
    @Binding var profile:  AntrenorProfile  // Binding kullanarak bilgileri geri döndürüyoruz
    @Environment(\.presentationMode) var presentationMode  // Sayfayı kapatmak için
    
    var body: some View {
        VStack{
            Fotoyukleme()
            Form {
                Section(header: Text("Kişisel Bilgiler")) {
                    TextField("Ad", text: $profile.firstName)
                    TextField("Soyad", text: $profile.lastName)
                    TextField("Telefon", text: $profile.phone)
                }
                
                Section(header: Text("Diğer Bilgiler")) {
                    TextField("Aylık Ders Ücreti", value: $profile.monthlyRate, format: .number)
                    TextField("Biyografi", text: $profile.bio)
                    TextField("Doğum Tarihi", text: $profile.birthDate)
                    Picker("Cinsiyet", selection: $profile.gender) {
                        Text("Erkek").tag("Erkek")
                        Text("Kadın").tag("Kadın")
                        Text("Diğer").tag("Diğer")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Button("Kaydet") {
                    // Güncellemeyi kaydet ve geri dön
                    presentationMode.wrappedValue.dismiss()
                }
            }
            
        }
        .navigationTitle("Antrenor Profili Düzenle")
        .navigationBarTitleDisplayMode(.inline)
    }
}


