//
//  CustomTextField.swift
//  StayFit
//
//  Created by İmat Gökaslan on 1.10.2024.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var ad : String
    @State var icon : String?
    @State var placeholder: String?
    var body: some View {
        HStack(){
            Image(systemName: icon!)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 35)
            TextField(placeholder!,text: $ad)
                .autocapitalization(.none)
                .autocorrectionDisabled()
               
                
        }
        .padding()
        .background(Color.white.opacity(ad == "" ? 0.1 : 0.5))
        .cornerRadius(15)
        .padding(.horizontal)
        
    }
}

#Preview {
    CustomTextField(ad: .constant(""),icon: "envelope",placeholder: "email")
}
