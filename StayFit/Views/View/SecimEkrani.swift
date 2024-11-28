//
//  SecimEkrani.swift
//  StayFit
//  Token: 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
//  Created by İmat Gökaslan on 13.10.2024.
//

import SwiftUI

struct SecimEkrani: View {
    @EnvironmentObject var authManager: AuthManager
    @State var isAnimating: Bool = false
    var body: some View {
        NavigationStack{
            ZStack {
                Image("stayy")
                VStack(spacing: 40) {
                    Image("cover2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width-110)
                        .cornerRadius(20)
                        .padding(.vertical)
                        
                    
                    HStack(spacing:40){
                        
                        NavigationLink {
                            LoginView()
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            LottieItem(text: "Ögrenci", lottie: "https://lottie.host/2e20be73-aead-4cb9-a49f-0bc900ae620f/guUtIiN8UJ.json")
                                .foregroundColor(.white)
                                
                        }

                       
                        
                        NavigationLink {
                            AntrenorLoginView()
                                .navigationBarBackButtonHidden(true)
                        } label: {
                              LottieItem(text: "Antrenör", lottie: "https://lottie.host/2386d88f-e4e3-45c7-871c-f4b81d091602/Qng1wbwGBz.json")
                                  .foregroundColor(.white)
                        }

                    
                    }
                    
                    Text("Lütfen bir seçim yapınız..")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .font(.system(size: 25))
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
