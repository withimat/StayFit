//
//  CustomText.swift
//  StayFit
//
//  Created by İmat Gökaslan on 8.10.2024.
//

import SwiftUI

struct CustomText: View {
    @State private var greeting: String = ""
    
    var body: some View {
        VStack(spacing:0) {
            Text(greeting)
                .font(.system(size: 14))
                .fontWeight(.semibold)
        }
        .onAppear {
            updateGreeting()
        }
    }
    
    func updateGreeting() {
        let currentHour = Calendar.current.component(.hour, from: Date())
        
        switch currentHour {
        case 6..<11:
            greeting = "Günaydın.."
        case 11..<17:
            greeting = "İyi Günler.."
        case 17..<21:
            greeting = "İyi Akşamlar.."
        default:
            greeting = "İyi Geceler.."
        }
    }
}
#Preview {
    CustomText()
}
