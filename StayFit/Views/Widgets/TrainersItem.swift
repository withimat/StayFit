//
//  TrainersItem.swift
//  StayFit
//
//  Created by İmat Gökaslan on 8.10.2024.
//

import SwiftUI

struct TrainersItem: View {
    var trainer: Trainer
    var body: some View {
        ZStack(){
            Image(trainer.profileUrl!)
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                .frame(width: 150)
            
            
            VStack(alignment : .leading){
                HStack(alignment: .center) {
                    Text(trainer.kisiAd+" "+trainer.kisiSoyad)
                        .font(.system(size: 14))
                }
                HStack {
                    Text("Fitness ")
                        .font(.system(size: 10))
                    HStack(spacing:1){
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.system(size: 10))
                        Text("\(String(format: "%.1f", trainer.rate!))")
                            .font(.system(size: 10))
                    }
                    
                }
            }
            .padding(.horizontal,20)
            .padding(.vertical,5)
            .background(.white)
            .cornerRadius(20)
            .frame(height: 400)
            .offset(y:70)
            .shadow(radius: 5)
            
        }
        
        
        
    }
}

#Preview {
    TrainersItem(trainer: Trainer(id: "1", kisiAd: "İmat", profileUrl: "hoca", kisiSoyad: "Gökaslan", kisiTel: "05380354884", kisiBoy: 180, kisiKilo: 80, kisiEmail: "imattgokk@gmail.com", bio: "lorem ipsumk jdjnjnv djvbndjbvd jbvjdbv vjbdvjbj dvbjvbjv bjdv vkndvnd knvkd vnd kvkvnd knvkd nvdkv dkv ncjdn vjndjvnjvnj vjnd nvdkvn dkvndkn vkdnv knvdkvn kdnvkd nvkd vndmk dvvnd nvkdn", monthlyRate: 2000, rate: 4, yearsOfExperience: 5, createdDate: "04.08.2000"))
}
