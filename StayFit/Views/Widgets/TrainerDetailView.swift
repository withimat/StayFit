//
//  TrainerDetailView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 8.10.2024.
//

import SwiftUI

struct TrainerDetailView: View {
    var trainer: Trainer
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack {
                            HStack(spacing: 50) {
                                Image(trainer.profileUrl!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                                    .frame(width: 120)
                                    .padding(.leading)
                                
                                VStack(spacing: 20) {
                                    HStack(spacing: 5) {
                                        Text(trainer.kisiAd)
                                            .font(.system(size: 23))
                                            .bold()
                                        Text(trainer.kisiSoyad)
                                            .font(.system(size: 23))
                                            .bold()
                                    }
                                }
                                .padding(.trailing, 20)
                            }
                            
                            
                            ZStack(alignment:.top) {
                                Rectangle()
                                    .foregroundColor(.gray.opacity(0.4))

                                
                                
                                VStack(alignment:.leading,spacing: 20){
                                    VStack(alignment:.leading){
                                        Text("Hakkında")
                                            .font(.system(size: 18))
                                            .fontWeight(.semibold)
                                            .padding(.leading,15)
                                            .padding(.top,15)
                                        Text(trainer.bio!)
                                            .padding(.leading,15)
                                            .padding(.top,5)
                                            .padding(.bottom,15)
                                            .padding(.trailing,10)
                                    }
                                    .background(.orange.opacity(0.5))
                                    .cornerRadius(20)
                                    .padding(.top)
                                    
                                    
                                    HStack(alignment: .center){
                                        Spacer()
                                        VStack{
                                            Text("\(trainer.yearsOfExperience!)")
                                                .font(.system(size: 18))
                                                .fontWeight(.semibold)
                                                .frame(width: 80,height: 50)
                                            
                                                .padding(.top)
                                            Text("Deneyim")
                                                .padding(.horizontal)
                                                .padding(.bottom)
                                        }
                                        .background(.gray.opacity(0.7))
                                        .cornerRadius(10)
                                        
                                        Spacer()
                                        
                                        
                                        VStack{
                                            Text(trainer.createdDate!)
                                                .lineLimit(1)
                                                .font(.system(size: 13))
                                                .fontWeight(.semibold)
                                                .frame(width: 80,height: 50)
                                                
                                                .padding(.top)
                                            Text("Kayıt Tarihi")
                                                .padding(.horizontal)
                                                .padding(.bottom)
                                        }
                                        .background(.gray.opacity(0.7))
                                        .cornerRadius(10)
                                        
                                        Spacer()
                                       
                                    }
                                  
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    VStack(alignment: .leading){
                                        HStack{
                                            Text("Tel:")
                                                .font(.system(size: 18))
                                                .fontWeight(.semibold)
                                                .padding(.leading)
                                                .padding(.top,15)
                                            Text(trainer.kisiTel)
                                                .font(.system(size: 18))
                                                .foregroundColor(.white)
                                                .fontWeight(.semibold)
                                                .padding(.top,15)
                                                Spacer()
                                           
                                        }
                                        
                                        VStack(alignment: .leading) {
                                            HStack(){
                                                Text("Email:")
                                                    .font(.system(size: 18))
                                                    .fontWeight(.semibold)
                                                    .padding(.leading,15)
                                                    .padding(.top,5)
                                                    .padding(.bottom,15)
                                                   
                                                
                                                Text(trainer.email)
                                                    .font(.system(size: 18))
                                                    .foregroundColor(.white)
                                                    .fontWeight(.semibold)
                                                    .padding(.top,5)
                                                    .padding(.bottom,15)
                                                    .padding(.trailing)
                                                Spacer()
                                                    
                                            }
                                        }
                                        .frame(width: geometry.size.width*8/10)
                                        
                                    }
                                    .background(.blue.opacity(0.5))
                                    .blur(radius: 0.2)
                                    .cornerRadius(10)
                                    

                                    
                                    
                                   
                                    
                                    HStack(alignment: .center){
                                        
                                        Button(action: {
                                            
                                        }, label: {
                                            Text("Aylık \(Int(trainer.monthlyRate!)) tl")
                                            
                                                .padding()
                                        })
                                        .buttonStyle(BorderedButtonStyle())
                                        .foregroundColor(.white)
                                        .background(.red.opacity(0.4))
                                        .cornerRadius(20)
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            
                                        }, label: {
                                            Text("Bilgi Al")
                                            
                                                .padding()
                                        })
                                        .buttonStyle(BorderedButtonStyle())
                                        .foregroundColor(.white)
                                        .background(.green.opacity(0.4))
                                        .cornerRadius(20)
                                        
                                    }
                                    
                                    HStack{
                                        VStack {
                                            HeadingView(color: .gray, headingImage: "search", headingText: "Görüşler")
                                            Image(systemName: "star.square.on.square")
                                        }
                                        Spacer()
                                        VStack {
                                            Text("Hepsini Gör")
                                                .font(.title2)
                                            .foregroundColor(.green.opacity(0.55))
                                            HStack {
                                                Text("\(String(format: "%.1f", trainer.rate!))")
                                                Image(systemName: "star.fill")
                                                    .foregroundColor(.yellow)
                                            }
                                            
                                        }
                                    }
                                    .padding(.horizontal)
                                
                                    
                                }
                                .padding(10)
                                
                            
                                
                            }
                            .frame(width: geometry.size.width*9 / 10, height: geometry.size.height*8 / 10) //
                            .shadow(radius: 0)
                            .cornerRadius(20)
                            

                            
                            
                            
                        }
                        
                        
                        
                        Spacer()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    
                    
                }
            }
            
        }
    }
}


#Preview {
    TrainerDetailView(trainer: Trainer(id: "1", kisiAd: "İmat", profileUrl: "hoca", kisiSoyad: "Gökaslan", kisiTel: "05380354884", kisiBoy: 180, kisiKilo: 80, kisiEmail: "imattgokk@gmail.com", bio: "lorem ipsumk jdjnjnv djvbndjbvd jbvjdbv vjbdvjbj dvbjvbjv bjdv vkndvnd knvkd vnd kvkvnd knvkd nvdkv dkv ncjdn vjndjvnjvnj vjnd nvdkvn dkvndkn vkdnv knvdkvn kdnvkd nvkd vndmk dvvnd nvkdn", monthlyRate: 2000, rate: 4, yearsOfExperience: 5, createdDate: "04.08.2000"))
}
