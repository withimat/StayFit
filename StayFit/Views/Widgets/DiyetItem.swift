//
//  DiyetItem.swift
//  StayFit
//
//  Created by İmat Gökaslan on 8.10.2024.
//

import SwiftUI

struct DiyetItem: View {
    var diyet : Meal
    var body: some View {
        ZStack(){
            Image("diyet")
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                .frame(width: 140)
            
            
            VStack(){
                Text(diyet.name!)
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                Text(diyet.description!)
                    .font(.system(size: 15))
            }
            .frame(width: 90)
            .padding(.horizontal,30)
            .padding(.vertical,5)
            .background(.white)
            .cornerRadius(20)
            .offset(y:100)
            .shadow(radius: 5)
            
        }
        
        
        
        
        
    }
    
}

#Preview {
    DiyetItem(diyet: Meal(id: "1", name: "Kahvaltı", description: "50 gr Yulaf \n1 adet muz\n4 yumurta"))
}
