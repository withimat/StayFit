//
//  AntrenorListesi.swift
//  StayFit
//
//  Created by İmat Gökaslan on 1.10.2024.
//

import SwiftUI

struct AntrenorListesi: View {
    @State private var searchText = ""
    @State private var odemetiklandi: Bool = false
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "BG")
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "beyaz")!,.font : UIFont(name: "Pacifico-Regular" , size: 22)!]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
    var body: some View {
            NavigationStack{
                ScrollView{
                    Text("Lütfen Bir antrenör seçin ve devam edin ")
                        .padding()
                    LazyVStack{
                        ForEach(Trainer.MOCK_TRAINERS){ trainer in
                            
                            NavigationLink {
                                AntrenorDetailView(trainer: trainer )
                                    
                            } label: {
                                VStack {
                                    
                                    HStack(alignment: .center){
                                        Image(trainer.profileUrl ?? "")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100,height: 100)
                                            .clipShape(Circle())
                                        
                                        VStack(spacing:10){
                                            HStack {
                                                Spacer()
                                                Text(trainer.kisiAd.uppercased())
                                                    .foregroundColor(.black)
                                                
                                                Text(trainer.kisiSoyad.uppercased())
                                                    .foregroundColor(.black)
                                                Spacer()
                                            }
                                            
                                            Text("Fitness Antrenörü")
                                                .foregroundColor(.black)
                                            
                                            
                                            
                                            
                                            
                                        }
                                        
                                        Spacer()
                                        
                                        VStack(){
                                            Spacer()
                                            Text("\(Int(trainer.monthlyRate!)) $")
                                                .foregroundColor(.white)
                                                .frame(width: 60,height: 40)
                                                .background(Color("yesil"))
                                                .cornerRadius(10)
                                            Spacer()
                                        }
                                        .padding(.trailing,15)
                                        
                                        
                                        if odemetiklandi {
                                            Button(action: {
                                                
                                            }, label: {
                                                Text("Button")
                                            })
                                        }
                                        
                                        
                                    }
                                    .background(.gray)
                                    .cornerRadius(10)
                                    .padding(.trailing,15)
                                    .padding(.leading,15)
                                }
                                
                            }
                            
                            
                           
                        }
                    }
                    
                }
                .navigationTitle("Antrenör Listesi")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
            }
        }
    }


#Preview {
    AntrenorListesi()
}
