//
//  SecilenAntrenorDetaySayfasi.swift
//  StayFit
//
//  Created by İmat Gökaslan on 2.11.2024.
//

import SwiftUI
import Lottie

struct SecilenAntrenorDetaySayfasi: View {
    let person: GelenAntrenor
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(spacing: 20){
                    VStack {
                        Text("Gelişim Ekle")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .padding()
                        HStack(spacing:25){
                            Spacer()
                            NavigationLink {
                                WeeklyProgressView(antrenor: person)
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                LottieItem(text: "Manuel ekle", lottie: "https://lottie.host/cb1c8830-29fc-44f7-aa17-45dcf713e58d/UUU1HaxwQu.json")
                                    .frame(height: 150)
                            }
                            
                            NavigationLink {
                                WeeklyProgressIAView(antrenor: person)
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                LottieItem(text: "Yapay Zeka ile ", lottie: "https://lottie.host/248099fd-2c28-43ec-b2b0-83bba10cb00c/T7u4E3L6aH.json")
                            }
                            Spacer()
                            
                        }
                        .padding(.bottom,20)
                    }
                    .background(.blue.opacity(0.4))
                    .cornerRadius(10)
                    .padding(.top,35)
                    .padding(.horizontal,10)
                    
                    
                    HStack {
                        Text("Antrenor Bilgileri")
                            .font(.system(size: 25))
                            .fontWeight(.semibold)
                            .padding(.leading,20)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        VStack(spacing: 20) {
                            Spacer()
                            if let photoPath = person.photoPath, let url = URL(string: photoPath) {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 150, height: 150)
                                        .clipShape(Circle())
                                } placeholder: {
                                    ProgressView()
                                }
                            } else {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
                                    .clipShape(Circle())
                            }
                            
                            HStack {
                                Spacer()
                                VStack(spacing:20){
                                    Text("\(person.firstName) \(person.lastName)")
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    Text("Abonelik Ücreti: \(person.amount) tl ")
                                        .font(.subheadline)
                                    
                                    
                                    Text("Abonelik Bitiş Tarihi: \(person.endDate)")
                                        .font(.subheadline)
                                    
                                  
                                    
                                    
                                }
                                .cornerRadius(10)
                                Spacer()
                            }
                            Spacer()
                        }
                        .background(.blue.opacity(0.5))
                        .padding(.horizontal,5)
                        .cornerRadius(20)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Antrenor Sayfası")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SecilenAntrenorDetaySayfasi(person: GelenAntrenor(subscriptionId: "12", trainerId: "121", firstName: "İmat", lastName: "GÖKASLAN", amount: 4000, endDate: "11/12/2024",photoPath: "https://minieticaretdodo.blob.core.windows.net/user-images/selectedImage-10.jpg"))
}
