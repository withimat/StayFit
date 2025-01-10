//
//  EditAntrenorProfileView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 2.11.2024.
//

import SwiftUI

struct EditAntrenorProfileView: View {
    @Binding var profile:  AntrenorProfile
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = AntrenorEditProfileViewModel()
    @StateObject private var password = PasswordResetViewModel()
    @State  var visible : Bool = false
    @State  var visibleString = "eye.fill"
    @State  var visible2 : Bool = false
    @State  var visibleString2 = "eye.slash.fill"
    var body: some View {
        NavigationStack {
            VStack{
                Fotoyukleme()
                Form {
                    Section(header: Text("Kişisel Bilgiler")) {
                        HStack{
                            Image(systemName: "pencil.and.scribble")
                                .frame(width: 15)
                            TextField("Ad", text: $profile.firstName)
                                .autocapitalization(.none)
                                .autocorrectionDisabled(true)
                        }
                        HStack{
                            Image(systemName: "pencil.and.scribble")
                                .frame(width: 15)
                            TextField("Soyad", text: $profile.lastName)
                                .autocapitalization(.none)
                                .autocorrectionDisabled(true)
                        }
                        Text("Email: \(profile.email)")  // Yalnızca görüntülenebilir alan
                        Text("Telefon: \(profile.phone)")
                    }
                    Section(header: Text("Diğer Bilgiler")){
                        HStack{
                            Image(systemName: "pencil.and.scribble")
                                .frame(width: 15)
                            TextField("Bio", text: $profile.bio)
                                .autocapitalization(.none)
                                .autocorrectionDisabled(true)
                        }
                        HStack{
                            Image(systemName: "pencil.and.scribble")
                                .frame(width: 15)
                            TextField("Aylık Ücret : ", value: $profile.monthlyRate, format: .number)
                                .autocapitalization(.none)
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
                                TextField("Eski Şifreniz",text: $password.currentPassword)
                                    .autocapitalization(.none)
                                
                            }
                                
                            else {
                                
                                SecureField("Eski Şifreniz",text: $password.currentPassword)
                                    .autocapitalization(.none)
                            }
       
                            Button(action: {
                                if visible == false {
                                    visible.toggle()
                                    visibleString = "eye.slash.fill"
                                    
                                    
                                } else {
                                    visible.toggle()
                                    visibleString = "eye.fill"
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
                        } label: {
                            HStack{
                                
                                Text("Şifeni Kaydet")
                                    .padding(.leading)
                                   
                                Spacer()
                            }
                            
                           
                        }

                    }
                    
                    
                    
                    Button("Kaydet") {
                        
                        viewModel.updateProfile(profile)
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                }
                
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
            .navigationTitle("Antrenor Profili Düzenle")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}




#Preview {
    EditAntrenorProfileView(profile: .constant(AntrenorProfile(id: "12", createdDate: "11/22/23", firstName: "İmat", lastName: "GÖKASLAN", email: "imattgokk@gmail.com", phone: "5380354884", birthDate: "15/08/2000", gender: "Erkek", monthlyRate: 4000, bio: "Vücut Geliştirme Antrenörü")))
}
