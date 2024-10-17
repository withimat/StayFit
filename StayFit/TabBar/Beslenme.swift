//
//  Beslenme.swift
//  StayFit
//
//  Created by İmat Gökaslan on 7.10.2024.
//

import SwiftUI

struct Beslenme: View {
    @State var pickerSelect: Bool = true
    let daysOfWeek = ["Pazartesi", "Salı", "Çarşamba", "Perşembe", "Cuma", "Cumartesi", "Pazar"]
    @State private var selectedDay: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // Gün adını tam almak için (Pazartesi, Salı, vb.)
        formatter.locale = Locale(identifier: "tr_TR") // Türkçe gün adları için
        return formatter.string(from: Date())
    }()
    
    @State static var count : Int = 0
    @ObservedObject var dietProgram = BeslenmeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(){
                    
                    HStack(spacing:35){
                        NavigationLink {
                            SuplementList()
                                .navigationBarBackButtonHidden(true)
                                
                        } label: {
                            LottieItem(text: "Suplementler", lottie: "https://lottie.host/5dd23691-1a2a-4c25-abab-f1b88c9baa5d/oy5D94yaE7.json")
                        }
                        .foregroundColor(.yellow)
                        .shadow(radius: 10)
                        
                        
                        NavigationLink {
                            FitnessTipsView()
                                .navigationBarBackButtonHidden(true)
                                
                        } label: {
                            LottieItem(text: "Diyet Tüyoları", lottie: "https://lottie.host/e79fb253-0a30-4071-8a41-43993a3c97e6/TVHvgXSwuH.json")
                        }
                        .foregroundColor(.yellow)
                        .shadow(radius: 10)
                    }
                    
                    HStack {
                        HeadingView(color: Color.black,headingImage: "fork.knife"
                            , headingText: "Beslenme")
                        
                        HStack(){
                            Picker("Gün Seçin", selection: $selectedDay) {
                                ForEach(daysOfWeek, id: \.self) { day in
                                    HStack {
                                        
                                        Text(day).tag(day)
                                    }
                                    
                                }
                            }
                            .pickerStyle(DefaultPickerStyle())
                           
                        }
                    }
                    .padding()
                    
                    
                   
                        
                       
                            if let meals = dietProgram.program[selectedDay] {
                                // Her bir öğünü listele
                                ForEach(meals)  { meal in
                                    HStack {
                                    
                                        DiyetItem(diyet: meal)
                                            .padding(.top,-15)
                                            .padding(.bottom,50)
                                        .padding(.horizontal,50)
                                    }
                                    .padding()
                                      
                                }
                            } else {
                                // Eğer seçilen gün için öğün yoksa
                                Text("Bu gün için diyet programı bulunamadı.")
                                    .font(.subheadline)
                                    .foregroundColor(.red)
                                    .padding(.horizontal) // Yatay boşluk ekleme
                            }
                            
                        
                      
                    
                    

                    
                        
                
                    
                    Spacer()
                }
                .padding(.top)
                .navigationTitle("Beslenme")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    Beslenme()
}
