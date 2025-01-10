//
//  ProfileView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 1.10.2024.
//

import SwiftUI
/*
 
 init() {
     let appearance = UINavigationBarAppearance()
     appearance.backgroundColor = UIColor(named: "BG")
     appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "beyaz")!,.font : UIFont(name: "Pacifico-Regular" , size: 22)!]
     UINavigationBar.appearance().standardAppearance = appearance
     UINavigationBar.appearance().scrollEdgeAppearance = appearance
     UINavigationBar.appearance().compactAppearance = appearance
 }
 */


struct ProfileView: View {
    @StateObject var viewmodel = ProfileViewViewModel()
    @EnvironmentObject var authManager: AuthManager
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
                if let profile = viewmodel.userProfile {
                    ScrollView {
                        VStack(alignment: .center, spacing: 10) {
                            ProfileDetailsView(profile: profile)
                                .offset(y:-30)
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
                                .offset(y:-35)

                            }
                            .offset(y:-50)
                        }
                        
                    }
                } else {
                    ProgressView("Profil bilgileri yükleniyor...")
                    Button("Çıkış Yap") {
                        authManager.logout()
                        shouldNavigateToLogin = true
                    }
                }
            }
            .offset(y:-7)
            .onAppear {
                viewmodel.fetchUserProfile()  // Görünüm her yüklendiğinde çağrılır
            }
            
            .navigationTitle("Profil")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $shouldNavigateToLogin) {
                SecimEkrani()
            }
        }
    }

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
    ProfileView()
        .environmentObject(AuthManager())
}

/*
struct ProfileView: View {
    @StateObject var viewmodel = ProfileViewViewModel()
 
    @EnvironmentObject var authManager: AuthManager
    @State private var shouldNavigateToLogin = false
    var body: some View {
        NavigationStack {
            
                VStack {
                    // Profil Kartı
                    HStack {
                        Spacer()
                        Button(action: {
                            viewmodel.showEditScreen.toggle()
                        }, label: {
                            Text(viewmodel.showEditScreen ? "Düzenlemeden çık" : "Düzenle")
                                .foregroundColor(Color("BG"))
                        })
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 15) {
                        // İsim ve Soyisim
                        HStack {
                            Text("Adınız      : ")
                                .font(.system(size: 20))
                            if viewmodel.showEditScreen {
                                TextField("Adınızı girin", text: $viewmodel.tfKisiAd)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .foregroundColor(Color("BG"))
                                    .font(.title2)
                            } else {
                                Text(viewmodel.tfKisiAd)
                                    .foregroundColor(Color("BG"))
                                    .font(.title2)
                            }
                        }
                        
                        HStack {
                            Text("Soyadınız: ")
                                .font(.system(size: 20))
                            if viewmodel.showEditScreen {
                                TextField("Soyadınızı girin", text: $viewmodel.tfKisiSoyad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .foregroundColor(Color("BG"))
                                    .font(.title2)
                            } else {
                                Text(viewmodel.tfKisiSoyad)
                                    .foregroundColor(Color("BG"))
                                    .font(.title2)
                            }
                        }
                        
                        // Telefon ve Email
                        HStack {
                            Text("Tel            : ")
                                .font(.system(size: 20))
                            if viewmodel.showEditScreen {
                                TextField("Telefon numaranızı girin", text: $viewmodel.tfKisiTel)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .foregroundColor(Color("BG"))
                                    .font(.title2)
                            } else {
                                Text(viewmodel.tfKisiTel)
                                    .foregroundColor(Color("BG"))
                                    .font(.title2)
                            }
                        }
                        
                        HStack {
                            Text("Email       : ")
                                .font(.system(size: 20))
                            if viewmodel.showEditScreen {
                                TextField("Email adresinizi girin", text: $viewmodel.tfKisiemail)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .foregroundColor(Color("BG"))
                                    .font(.title2)
                            } else {
                                Text(viewmodel.tfKisiemail)
                                    .foregroundColor(Color("BG"))
                                    .font(.title2)
                            }
                        }
                        
                        // Cinsiyet
                        HStack {
                            Text("Cinsiyet  : ")
                                .font(.system(size: 20))
                            if viewmodel.showEditScreen {
                                TextField("Cinsiyetinizi girin", text: $viewmodel.Secilencinsiyet)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .foregroundColor(Color("BG"))
                                    .font(.title2)
                            } else {
                                Text(viewmodel.Secilencinsiyet)
                                    .foregroundColor(Color("BG"))
                                    .font(.title2)
                            }
                        }
                        
                        // Fiziksel Özellikler
                        VStack(alignment: .leading) {
                            Text("Fiziksel Özellikler")
                                .font(.title)
                            
                            HStack {
                                Text("Boy    : ")
                                    .font(.system(size: 20))
                                if viewmodel.showEditScreen {
                                    TextField("Boyunuzu girin", text: $viewmodel.tfKisiBoy)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .foregroundColor(Color("BG"))
                                        .font(.title2)
                                } else {
                                    Text(viewmodel.tfKisiBoy)
                                        .foregroundColor(Color("BG"))
                                        .font(.title2)
                                }
                            }
                            
                            HStack {
                                Text("Kilo    : ")
                                    .font(.system(size: 20))
                                if viewmodel.showEditScreen {
                                    TextField("Kilonuzu girin", text: $viewmodel.tfKisiKilo)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .foregroundColor(Color("BG"))
                                        .font(.title2)
                                } else {
                                    Text(viewmodel.tfKisiKilo)
                                        .foregroundColor(Color("BG"))
                                        .font(.title2)
                                }
                            }
                        }
                        .padding(.top, 20)
                    }
                    .padding(.leading)
                    
                    // "Kaydet" butonu
                    Button("Çıkış Yap") {
                                    authManager.logout()  // Çıkış işlemi
                                    shouldNavigateToLogin = true  // Yönlendirme tetiklenir
                                }
                    
                    Spacer()
                }
                .navigationTitle("Stay Fit")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    viewmodel.bilgi_yukle()
                    print()
                }
                .navigationDestination(isPresented: $shouldNavigateToLogin) {
                            SecimEkrani()  // Çıkış yaptıktan sonra seçim ekranına yönlendir
                        }
        }
    }
}

#Preview {
    ProfileView()
}

*/
