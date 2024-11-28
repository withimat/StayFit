//
//  AntrenorProfil.swift
//  StayFit
//
//  Created by İmat Gökaslan on 19.10.2024.
//
import SwiftUI

struct AntrenorProfil: View {
    @EnvironmentObject var authManager: AuthManager
    @ObservedObject var viewModel = AntrenorProfilModelView()
    @State private var shouldNavigateToLogin = false 
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "BG")
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "beyaz")!,.font : UIFont(name: "Pacifico-Regular" , size: 22)!]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
    var body: some View {
        NavigationStack {
            VStack {
                if let profile = viewModel.antrenorProfile {
                    ScrollView {
                        VStack(alignment: .center, spacing: 10) {
                            AntrenorProfileDetailsView(profile: profile)
                            
                            
                            HStack {
                                Button {
                                    authManager.logout()
                                    shouldNavigateToLogin = true
                                } label: {
                                    Text("Çıkış Yap")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(.blue)
                                        .cornerRadius(15)
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

                
            }
            .onAppear {
                viewModel.fetchAntrenorProfile()
            }
            .navigationDestination(isPresented: $shouldNavigateToLogin) {
                SecimEkrani()
            }
            .navigationTitle("Profil")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    
}

#Preview {
    AntrenorProfil()
}
