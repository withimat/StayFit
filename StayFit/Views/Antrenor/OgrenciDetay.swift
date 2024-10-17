//
//  OgrenciDetay.swift
//  StayFit
//
//  Created by İmat Gökaslan on 20.10.2024.
//

import SwiftUI

struct OgrenciDetay: View {
    let user : User
    @State var hedef: String = "Yağ yakımı için diyet ve antrenman programı istiyorum."
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                   VStack(spacing:20){
                        HStack{
                            Image(user.profileUrl!)
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 140)
                           
                        }
                        .padding(.horizontal)
                        
                       VStack(spacing:10) {
                           HStack {
                               Text("İletişim Bilgileri")
                                   .font(.system(size: 18))
                                   .fontWeight(.semibold)
                               Spacer()
                           }
                           .padding(.leading)
                           HStack{
                               Text("Email:")
                               
                               HStack {Spacer()
                                   Text(user.email)
                                       .multilineTextAlignment(.center)
                                       .font(.system(size: 18))
                                       .lineLimit(1)
                                   .fontWeight(.medium)
                                   Spacer()
                               }
                               Spacer()
                           }
                           .padding(.leading)
                           HStack{
                               Text("Telefon:")
                             
                               HStack {
                                   Spacer()
                                   Text(user.kisiTel)
                                       .font(.system(size: 18))
                                       .fontWeight(.medium)
                                   .lineLimit(1)
                                   Spacer()
                               }
                               Spacer()
                           }
                           .padding(.leading)
                       }
                       
                       VStack {
                           HStack {
                               Text("Fiziksel Bilgiler")
                                   .font(.system(size: 18))
                                   .fontWeight(.semibold)
                               Spacer()
                           }
                           .padding(.leading)
                           HStack{
                               Text("Boy:")
                               HStack {Spacer()
                                   Text("\(Int(user.kisiBoy)) cm ")
                                       .multilineTextAlignment(.center)
                                       .font(.system(size: 18))
                                       .lineLimit(1)
                                   .fontWeight(.medium)
                                   Spacer()
                               }
                               Spacer()
                           }
                           .padding(.leading)
                           HStack{
                               Text("Kilo:")
                               HStack {
                                   Spacer()
                                   Text("\(Int(user.kisiKilo)) kg ")
                                       .multilineTextAlignment(.center)
                                       .font(.system(size: 18))
                                       .lineLimit(1)
                                   .fontWeight(.medium)
                                   Spacer()
                               }
                               Spacer()
                           }
                           .padding(.leading)
                       }
                       
                       VStack {
                           HStack {
                               Text("Öğrencinin Hedefi")
                                   .font(.system(size: 18))
                               .fontWeight(.semibold)
                               Spacer()
                           }
                           .padding(.leading)
                           HStack{
                               Text(hedef)
                               Spacer()
                           }
                           .padding(.leading)
                       }
                    
                       
                    }
                    .navigationBarTitle(user.kisiAd.uppercased()+" "+user.kisiSoyad.uppercased())
                    .toolbarTitleDisplayMode(.inline)
                }
            }
            .background(Color("acikmavi"))
        
        }
        
    }
}

#Preview {
    OgrenciDetay(user: User(id: "0", kisiAd: "İmat", profileUrl: "hoca", kisiSoyad: "Gokaslan", kisiTel: "1234567890", kisiBoy: 180, kisiKilo: 80, kisiEmail: "imattgokk@gmail.com"))
}
