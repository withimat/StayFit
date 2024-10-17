//
//  SecimEkrani.swift
//  StayFit
//......
//  Created by İmat Gökaslan on 13.10.2024.
//

import SwiftUI

struct SecimEkrani: View {
    @EnvironmentObject var authManager: AuthManager
    var body: some View {
        NavigationStack{
            ZStack {
                
                Rectangle()
                    .background(.black)
                    .ignoresSafeArea()
                VStack(spacing: 40) {
                    Text("Lütfen bir seçim yapınız..")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .font(.system(size: 25))
                    HStack(spacing:20){
                        Spacer()
                        NavigationLink {
                            LoginView()
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            LottieItem(text: "Ögrenci", lottie: "https://lottie.host/2e20be73-aead-4cb9-a49f-0bc900ae620f/guUtIiN8UJ.json")
                                .foregroundColor(.white)
                                
                        }

                        Spacer()
                        
                        NavigationLink {
                            AntrenorLoginView()
                                .navigationBarBackButtonHidden(true)
                        } label: {
                              LottieItem(text: "Antrenör", lottie: "https://lottie.host/2386d88f-e4e3-45c7-871c-f4b81d091602/Qng1wbwGBz.json")
                                  .foregroundColor(.white)
                        }

                      Spacer()
                    }
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
