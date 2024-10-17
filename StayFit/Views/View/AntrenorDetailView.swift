//
//  AntrenorDetailView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 1.10.2024.
//

import SwiftUI

struct AntrenorDetailView: View {
    var trainer: Trainer
    @State private var showAlert = false  // Alert kontrolü
    @State private var navigateToMainTab = false  // Yönlendirme kontrolü
    
    func saveTrainerToUserDefaults(_ trainer: Trainer) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(trainer) {
            UserDefaults.standard.set(encoded, forKey: "selectedTrainer")
        }
    }

    init(trainer: Trainer) {
        self.trainer = trainer
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "BG")
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(named: "beyaz")!,
            .font: UIFont(name: "Pacifico-Regular", size: 22)!
        ]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .center) {
                    // Antrenör bilgileri
                    HStack {
                        Spacer()
                        Text(trainer.kisiAd.uppercased())
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text(trainer.kisiSoyad.uppercased())
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.top)
                    .padding(.horizontal)

                    Image(trainer.profileUrl!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220)
                        .cornerRadius(20)
                        .padding()

                    HStack {
                        Spacer()
                        Text(trainer.bio!)
                            .padding()
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .background(.red.opacity(0.3))
                    .cornerRadius(20)
                    .padding(.horizontal, 5)

                    VStack {
                        HStack {
                            Image(systemName: "checkmark.seal")
                            Text(" \(String(describing: trainer.yearsOfExperience!))+ yıl Fitness antrenörlüğü deneyimi")
                            Spacer()
                        }
                        .padding(10)

                        HStack {
                            Image(systemName: "figure.walk")
                            Text("  Fonksiyonel antrenman")
                            Spacer()
                        }
                        .padding(10)

                        HStack {
                            Image(systemName: "bolt")
                            Text("  Hedef odaklı antrenman planları")
                            Spacer()
                        }
                        .padding(10)
                    }
                    .background(.gray)
                    .cornerRadius(20)
                    .padding()

                    HStack {
                        Spacer()
                        Text("$ \(String(format: "%.0f", trainer.monthlyRate!)) ")
                            .padding()
                            .background(.gray.opacity(0.4))
                            .cornerRadius(10)
                        Spacer()
                        Text("Book")
                            .padding()
                            .background(.green.opacity(0.4))
                            .cornerRadius(10)
                        Spacer()
                    }
                    .padding(.bottom)

                    // Buton ile seçim yapılması
                    Button(action: {
                        saveTrainerToUserDefaults(trainer) 
                        showAlert = true  // Alert göster
                    }) {
                        Text("\(trainer.kisiAd.uppercased()) Hocayla devam etmek istiyorsan tıkla")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color("turuncu").opacity(0.8))
                            .cornerRadius(10)
                    }

                    Spacer()
                }
                .navigationTitle("StayFit")
                .navigationBarTitleDisplayMode(.inline)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Seçim Yapıldı"),
                    message: Text("Seçiminiz kaydedilmiştir.\(trainer.kisiAd) Hoca ile devam edeceksinzi.. Şimdi ana menüye yönlendirileceksiniz."),
                    dismissButton: .default(Text("Tamam"), action: {
                        navigateToMainTab = true  // Ana menüye geçiş başlat
                    })
                )
            }
            .navigationDestination(isPresented: $navigateToMainTab) {
                MainTabView()  // Ana menüye geçiş
            }
        }
    }
}


#Preview {
    AntrenorDetailView(trainer: Trainer(id: "1", kisiAd: "İmat", profileUrl: "hoca", kisiSoyad: "GÖKASLAN", kisiTel: "5380354884", kisiBoy: 180, kisiKilo: 80, kisiEmail: "imattgokk@gmail.com", bio: "Deneyimli Fitness Eğitmeni.+4 yıllık eğitim ile hedeflerinize ulasmada en etkili yyöntem.", monthlyRate: 5000, rate: 4, yearsOfExperience: 7, createdDate: "08.09.2000"))
}
