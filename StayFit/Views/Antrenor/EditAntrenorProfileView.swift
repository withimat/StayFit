//
//  EditAntrenorProfileView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 2.11.2024.
//

import SwiftUI

struct EditAntrenorProfileView: View {
    @Binding var profile:  AntrenorProfile  // Binding kullanarak bilgileri geri döndürüyoruz
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = AntrenorEditProfileViewModel()
    var body: some View {
        VStack{
            Fotoyukleme()
            Form {
                Section(header: Text("Kişisel Bilgiler")) {
                    HStack{
                        Image(systemName: "pencil.and.scribble")
                            .frame(width: 15)
                        TextField("Ad", text: $profile.firstName)
                    }
                    HStack{
                        Image(systemName: "pencil.and.scribble")
                            .frame(width: 15)
                        TextField("Soyad", text: $profile.lastName)
                    }
                    Text("Email: \(profile.email)")  // Yalnızca görüntülenebilir alan
                    Text("Telefon: \(profile.phone)")
                }
                Section(header: Text("Diğer Bilgiler")){
                    HStack{
                        Image(systemName: "pencil.and.scribble")
                            .frame(width: 15)
                        TextField("Bio", text: $profile.bio)
                    }
                    HStack{
                        Image(systemName: "pencil.and.scribble")
                            .frame(width: 15)
                        TextField("Aylık Ücret : ", value: $profile.monthlyRate, format: .number)
                    }
                    
                    Text("Doğum Tarihi: \(profile.birthDate)")
                    Text("Cinsiyet: \(profile.gender)")
                }
                Button("Kaydet") {
                    viewModel.updateProfile(profile)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // 0.1 saniye bekle
                       dismiss()
                    }
                }

            }
            
        }
        .navigationTitle("Antrenor Profili Düzenle")
        .navigationBarTitleDisplayMode(.inline)
    }
}




#Preview {
    EditAntrenorProfileView(profile: .constant(AntrenorProfile(id: "12", createdDate: "11/22/23", firstName: "İmat", lastName: "GÖKASLAN", email: "imattgokk@gmail.com", phone: "5380354884", birthDate: "15/08/2000", gender: "Erkek", monthlyRate: 4000, bio: "Vücut Geliştirme Antrenörü")))
}
