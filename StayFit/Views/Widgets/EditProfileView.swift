//
//  EditProfileView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 26.10.2024.
//

import SwiftUI

struct EditProfileView: View {
    @Binding var profile: UserProfile
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = EditProfileViewModel()
    
    var body: some View {
        VStack {
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
                
                Section(header: Text("Fiziksel Bilgiler")) {
                    HStack{
                        Image(systemName: "pencil.and.scribble")
                            .frame(width: 15)
                        TextField("Boy (cm)", value: $profile.height, format: .number)
                    }
                   
                    HStack{
                     Image(systemName: "pencil.and.scribble")
                            .frame(width: 15)
                      TextField("Kilo (kg)", value: $profile.weight, format: .number)
                    }
                
                        
                    Text("Doğum Tarihi: \(profile.birthDate)")
                    Text("Cinsiyet: \(profile.gender)")
                }
                
                Button("Kaydet") {
                    viewModel.updateProfile(profile)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            
        }
        .navigationTitle("Profili Düzenle")
        .navigationBarTitleDisplayMode(.inline)
    }
}



