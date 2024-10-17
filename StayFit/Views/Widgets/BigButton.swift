//
//  BigButton.swift
//  StayFit
//
//  Created by İmat Gökaslan on 1.10.2024.
//
import SwiftUI

struct BigButton: View {
    let title: String
    let action: () -> Void
    let color: Color
    
    var body: some View {
        HStack(spacing: 15) {
            Button(action: action, label: {
                Text(title)
                    .fontWeight(.heavy)
                    .foregroundColor(color)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 150)
                    .background(Color.black.opacity(0.4))
                    .clipShape(Capsule())
                    .cornerRadius(10)
            })
        }
        .padding(.top)
    }
}

// PreviewProvider kullanımı
struct BigButton_Previews: PreviewProvider {
    static var previews: some View {
        BigButton(title: "Press Me", action: {
            print("Button Pressed")
        }, color: .white)
    }
}
