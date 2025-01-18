//
//  SecimEkrani.swift
//  StayFit
//  
//  Created by İmat Gökaslan on 13.10.2024.
//

import SwiftUI
struct SecimEkrani: View {
    @EnvironmentObject var authManager: AuthManager
    @State var isAnimating: Bool = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    // Arka Plan Görselleri
                    Image("stayy")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height+200)
                        .ignoresSafeArea()
                        .offset(y:-80)
                    
                    Rectangle()
                        .foregroundColor(.BG)
                        .opacity(0.3)
                        .ignoresSafeArea()
                    
                    // İçerik
                    VStack(spacing: geometry.size.height * 0.05) { // Dinamik boşluk
                        Image("cover2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width * 0.7) // Genişlik cihaz boyutuna göre
                            .cornerRadius(20)
                            .padding(.vertical)
                        
                        // Seçim Butonları
                        HStack(spacing: geometry.size.width * 0.1) { // Dinamik boşluk
                            // Öğrenci Seçimi
                            Spacer()
                            NavigationLink {
                                LoginView()
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                LottieItem(
                                    text: "Öğrenci",
                                    lottie: "https://lottie.host/2e20be73-aead-4cb9-a49f-0bc900ae620f/guUtIiN8UJ.json"
                                )
                                .frame(width: geometry.size.width * 0.3) // Buton genişliği
                                .foregroundColor(.white)
                            }
                            
                            Spacer()
                            NavigationLink {
                                AntrenorLoginView()
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                LottieItem(
                                    text: "Antrenör",
                                    lottie: "https://lottie.host/2386d88f-e4e3-45c7-871c-f4b81d091602/Qng1wbwGBz.json"
                                )
                                .frame(width: geometry.size.width * 0.3) // Buton genişliği
                                .foregroundColor(.white)
                            }
                            Spacer()
                            
                        }
                        
                        // Alt Metin
                        Text("Lütfen bir seçim yapınız..")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .font(.system(size: geometry.size.width * 0.06)) // Dinamik yazı boyutu
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}


#Preview {
    
    SecimEkrani()
        .environmentObject(AuthManager())
        
}
