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
    
    @ObservedObject var viewModel = BeslenmeViewModel()
    
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
                    
                    
                    VStack {
                        if viewModel.isLoading {
                            ProgressView("Yükleniyor...") // Yükleme göstergesi
                        } else if let errorMessage = viewModel.errorMessage {
                            Text("Hata: \(errorMessage)")
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                                .padding()
                        } else {
                            ForEach(viewModel.dietPlan, id: \.id) { diet in
                                NavigationLink {
                                    GetDietPlansByMemberId(workout: diet)
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                    WorkoutRowView(workout: diet)
                                }
                                
                                
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top)
                
            }
            .navigationTitle("Beslenme Planı")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.fetchdietPlan() // Yenile butonu
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
            .onAppear {
                viewModel.fetchdietPlan()
                
            }
        }
    }
}

#Preview {
    Beslenme()
}
