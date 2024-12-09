//
//  RegisterView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 1.10.2024.

import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewmodel = RegisterViewViewModel()
    @State private var showingAlert: Bool = false
    @State private var isSuccess: Bool = false
    @State private var navigateToLogin: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    HStack {
                        if !viewmodel.errorMessage.isEmpty {
                            Text(viewmodel.errorMessage)
                                .foregroundStyle(.red)
                        }
                    }
                    .padding()
                    .offset(y: -10)

                    CustomTextField(ad: $viewmodel.firstName, icon: "person", placeholder: "Adınız")
                    CustomTextField(ad: $viewmodel.lastName, icon: "person", placeholder: "Soyadınız")
                    CustomTextField(ad: $viewmodel.email, icon: "envelope", placeholder: "Email")
                    CustomTextField(ad: $viewmodel.phone, icon: "phone", placeholder: "Telefon no")

                    HStack {
                        Image(systemName: "lock")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 35)
                        SecureField("Şifreniz", text: $viewmodel.password)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                    }
                    .padding()
                    .background(Color.white.opacity(viewmodel.password.isEmpty ? 0.1 : 0.5))
                    .cornerRadius(15)
                    .padding(.horizontal)

                    DatePicker(selection: $viewmodel.birthDate, displayedComponents: .date) {
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .padding(.leading, 4)
                            Text(" Doğum Tarihi")
                                .foregroundColor(.black.opacity(0.3))
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(viewmodel.isSpecificDate(viewmodel.birthDate) ? 0.1 : 0.5))
                    .cornerRadius(15)
                    .padding(.horizontal)

                    HStack {
                        Text("Kilo")
                            .foregroundColor(.black.opacity(0.3))
                        Slider(value: $viewmodel.weight, in: 0...150)
                            .foregroundColor(.black.opacity(0.3))
                            .padding()
                        Text(String(Int(viewmodel.weight)))
                    }
                    .padding(.horizontal, 20)
                    .background(Color.white.opacity(viewmodel.weight != 80 ? 0.5 : 0.1))
                    .cornerRadius(15)
                    .padding(.horizontal)

                    HStack {
                        Text("Boy")
                            .foregroundColor(.black.opacity(0.3))
                        Slider(value: $viewmodel.height, in: 0...220)
                            .foregroundColor(.black.opacity(0.3))
                            .padding()
                        Text(String(Int(viewmodel.height)))
                    }
                    .padding(.horizontal, 20)
                    .background(Color.white.opacity(viewmodel.height != 180 ? 0.5 : 0.1))
                    .cornerRadius(15)
                    .padding(.horizontal)

                    HStack {
                               Image(systemName: "person.fill")
                                   .foregroundColor(.white)
                                   .font(.system(size: 24))
                               Text("Cinsiyet")
                                   .foregroundColor(.black.opacity(0.3))
                               Spacer()

                               Picker("Cinsiyet", selection: $viewmodel.gender) {
                                   Text("").tag(nil as Gender?)
                                   Text("Kadın").tag(Gender.kadın as Gender?)
                                   Text("Erkek").tag(Gender.erkek as Gender?)
                               }
                           }
                           .accentColor(.white.opacity(0.8))
                           .padding()
                           .background(Color.white.opacity(viewmodel.gender != nil ? 0.5 : 0.1))
                           .cornerRadius(15)
                           .padding(.horizontal)

                    BigButton(title: "Kayıt Ol", action: {
                        viewmodel.register()

                        if viewmodel.validate() {
                            isSuccess = true
                            showingAlert = true
                        } else {
                            isSuccess = false
                            showingAlert = true
                        }
                    }, color: .white)
                    .alert(isPresented: $showingAlert) {
                        if isSuccess {
                            return Alert(
                                title: Text("Başarılı"),
                                message: Text("Kayıt başarıyla tamamlandı!"),
                                dismissButton: .default(Text("Tamam"), action: {
                                    navigateToLogin = true
                                })
                            )
                        } else {
                            return Alert(
                                title: Text("Hata"),
                                message: Text(viewmodel.errorMessage),
                                dismissButton: .default(Text("Tamam"))
                            )
                        }
                    }
                }
            }
            .background(Color("BG").opacity(0.7))
            .navigationTitle("Kayıt Formu")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $navigateToLogin) {
                LoginView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}



#Preview {
    RegisterView()
}
