//
//  AntrenmanItem.swift
//  StayFit
//
//  Created by İmat Gökaslan on 9.10.2024.
//

import SwiftUI
import Lottie

struct LottieItem: View {
    @State var text : String
    @State var lottie : String
    var body: some View {
        VStack(spacing:0){
            
            // URL'deki Lottie animasyonunu göstermek için LottieView'i çağırıyoruz
            if let animationUrl = URL(string: lottie) {
                LottieView(animationUrl: animationUrl)
                    .cornerRadius(10)
                    .frame(width: 100, height: 100)
                    .padding(.top)
                    .padding(.bottom)
            } else {
                Text("Görüntülenemiyor..:(")
            }
            
            Text(text)
                .font(.system(size: 20))
                .bold()
                .padding(.bottom)
            
        }
        .frame(width: 150)
        .background(.gray.opacity(0.4))
        .cornerRadius(20)
    }
}
#Preview {
    LottieItem(text: "Antrenman", lottie: "https://lottie.host/2386d88f-e4e3-45c7-871c-f4b81d091602/Qng1wbwGBz.json")
}
