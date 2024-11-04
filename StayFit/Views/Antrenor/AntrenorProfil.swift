//
//  AntrenorProfil.swift
//  StayFit
//
//  Created by İmat Gökaslan on 19.10.2024.
//
import SwiftUI

struct AntrenorProfil: View {
    @EnvironmentObject var authManager: AuthManager  // Oturum yönetimi
    @ObservedObject var viewModel = AntrenorProfilModelView()  // ViewModel ile profil yönetimi
    @State private var shouldNavigateToLogin = false  // Giriş ekranına yönlendirme kontrolü
    
    var body: some View {
        NavigationStack {
            VStack {
                if let profile = viewModel.antrenorProfile {
                    ScrollView {
                        VStack(alignment: .center, spacing: 10) {
                            AntrenorProfileDetailsView(profile: profile)
                                
                            HStack {
                                Button("Çıkış Yap") {
                                    authManager.logout()
                                    shouldNavigateToLogin = true
                                }
                            }
                            .offset(y:-30)
                        }
                        
                    }
                } else {
                    if viewModel.antrenorProfile == nil {
                        ProgressView("Profil yükleniyor...")
                        Button(action: {
                            authManager.logout()  // Oturumu kapat
                            shouldNavigateToLogin = true  // Giriş ekranına yönlendir
                        }) {
                            Text("Çıkış Yap")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(Color.red)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        .padding(.top, 20)
                    }
                }

                // Çıkış yap butonu
                
            }
            .onAppear {
                viewModel.fetchAntrenorProfile()  // API çağrısı ile profil bilgilerini getir
            }
            .navigationDestination(isPresented: $shouldNavigateToLogin) {
                SecimEkrani()  // Çıkış sonrası seçim ekranına yönlendirme
            }
            .navigationTitle("Antrenör Profilim")
            
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    
}

#Preview {
    AntrenorProfil()
}
