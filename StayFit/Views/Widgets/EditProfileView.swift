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
    @StateObject private var password = PasswordResetViewModel()
    @State  var visible : Bool = false
    @State  var visibleString = "eye.slash.fill"
    @State  var visible2 : Bool = false
    @State  var visibleString2 = "eye.slash.fill"
 
    var body: some View {
        NavigationStack{
        VStack {
            Fotoyukleme()
            Form {
                Section(header: Text("Kişisel Bilgiler")) {
                    HStack{
                        Image(systemName: "pencil.and.scribble")
                            .frame(width: 15)
                        TextField("Ad", text: $profile.firstName)
                            .autocapitalization(.none) // Otomatik büyük harf kapalı
                                        .autocorrectionDisabled(true)
                       
                    }
                    
                    
                    HStack{
                        Image(systemName: "pencil.and.scribble")
                            .frame(width: 15)
                        TextField("Soyad", text: $profile.lastName)
                            .autocapitalization(.none) // Otomatik büyük harf kapalı
                                        .autocorrectionDisabled(true)
                    }
                    
                    
                    Text("Email: \(profile.email)")  // Yalnızca görüntülenebilir alan
                    Text("Telefon: \(profile.phone)")
                }
                
                Section(header: Text("Fiziksel Bilgiler")) {
                    HStack{
                        Image(systemName: "pencil.and.scribble")
                            .frame(width: 15)
                        TextField("Boy (cm)", value: $profile.height, format: .number)
                            .autocapitalization(.none) // Otomatik büyük harf kapalı
                                        .autocorrectionDisabled(true)
                    }
                    
                    HStack{
                        Image(systemName: "pencil.and.scribble")
                            .frame(width: 15)
                        TextField("Kilo (kg)", value: $profile.weight, format: .number)
                            .autocapitalization(.none) // Otomatik büyük harf kapalı
                                        .autocorrectionDisabled(true)
                    }
                    
                    
                    Text("Doğum Tarihi: \(profile.birthDate)")
                    Text("Cinsiyet: \(profile.gender)")
                }
                
                Section(header: Text("Şifreni Yenile")){
                    HStack(){
                        Image(systemName: "pencil.and.scribble")
                            .frame(width: 15)
                        
                        if visible == false {
                            SecureField("Eski Şifreniz",text: $password.currentPassword)
                                .autocapitalization(.none)
                        }
                            
                        else {
                            TextField("Eski Şifreniz",text: $password.currentPassword)
                                .autocapitalization(.none)
                        }
   
                        Button(action: {
                            if visible == false {
                                visible.toggle()
                                visibleString = "eye.fill"
                                
                                
                            } else {
                                visible.toggle()
                                visibleString = "eye.slash.fill"
                            }
                            
                        }, label: {
                            Image(systemName: visibleString)
                                .foregroundColor(.gray)
                                .font(.system(size: 18))
                        })
                            
                    }
                    
                    HStack(){
                        Image(systemName: "pencil.and.scribble")
                            .frame(width: 15)
                            
                        
                        if visible2 == false {
                            SecureField("Yeni Şifreniz",text: $password.newPassword)
                                .autocapitalization(.none)
                        }
                            
                        else {
                            TextField("Yeni Şifreniz",text: $password.newPassword)
                                .autocapitalization(.none)
                        }
   
                        Button(action: {
                            if visible2 == false {
                                visible2.toggle()
                                visibleString2 = "eye.fill"
                                
                                
                            } else {
                                visible2.toggle()
                                visibleString2 = "eye.slash.fill"
                            }
                            
                        }, label: {
                            Image(systemName: visibleString2)
                                .foregroundColor(.gray)
                                .font(.system(size: 18))
                        })
                            
                    }
                    
                    Button {
                        password.changePassword()
                        print(password.errorMessage ?? "yok")
                    } label: {
                        Text("Yeni Şifreyi kaydet")
                    }

                }
                
                Button("Değişiklikleri Kaydet") {
                    viewModel.updateProfile(profile)
                    presentationMode.wrappedValue.dismiss()
                  
                }
            }
            
        }
        .onAppear(){
            
        }
        .alert(isPresented: $password.showAlert) {
                    Alert(
                        title: Text(password.isSuccess ? "Başarılı" : "Hata"),
                        message: Text(password.alertMessage),
                        dismissButton: .default(Text("Tamam")) {
                            if password.isSuccess {
                                
                                password.currentPassword = ""
                                password.newPassword = ""
                            }
                        }
                    )
                }
        .navigationTitle("Profili Düzenle")
        .navigationBarTitleDisplayMode(.inline)
    }
    }
}


#Preview {
    // Sahte bir UserProfile verisi oluşturuyoruz
    @Previewable @State var dummyProfile = UserProfile(
        id: "1",
        createdDate: "2024-12-18",
        firstName: "John",
        lastName: "Doe",
        email: "john.doe@example.com",
        phone: "1234567890",
        height: 180,
        weight: 75,
        birthDate: "1990-01-01",
        gender: ""
    )
    
    EditProfileView(profile: $dummyProfile)
}
