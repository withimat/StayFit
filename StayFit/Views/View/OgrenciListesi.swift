//
//  OgrenciListesi.swift
//  StayFit
//
//  Created by İmat Gökaslan on 1.10.2024.
//hbbbkhbkj

import SwiftUI

struct OgrenciListesi: View {
    @State private var searchText = ""
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVStack{
                    ForEach(User.MOCK_USER){ user in
                        NavigationLink {
                            OgrenciDetay(user: user)
                        } label: {
                            HStack(alignment: .center){
                                Image(user.profileUrl ?? "")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 140,height: 140)
                                    .clipShape(Circle())
                                    .padding(5)
                                
                                VStack(alignment: .center){
                                    HStack(alignment: .center) {
                                        Spacer()
                                        Text(user.kisiAd.uppercased())
                                            .fontWeight(.semibold)
                                        Text(user.kisiSoyad.uppercased())
                                            .fontWeight(.semibold)
                                        Spacer()
                                    }
                                    
                                    Text("Ögrenci")
                                }
                                
                                Spacer()
                                
                                
                                
                                
                                
                            }
                            .background(Color("acikmavi").opacity(0.7))
                            .cornerRadius(10)
                            .padding(.trailing,15)
                        .padding(.leading,15)
                        }

                    }
                }
                .searchable(text: $searchText , prompt: "Öğrenci ara")
                
            }
           
            .navigationTitle("Ögrenci Listesi")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    OgrenciListesi()
}
