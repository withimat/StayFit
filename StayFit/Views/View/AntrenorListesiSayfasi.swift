//
//  AntrenorListesiSayfasi.swift
//  StayFit
//
//  Created by İmat Gökaslan on 2.11.2024.
//

import SwiftUI

struct AntrenorListesiSayfasi : View {
    @StateObject private var viewModel = AntrenorListViewModel()
    @State private var odemetiklandi: Bool = false
    @Environment(\.dismiss) var dismiss
    init() {
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
        NavigationView {
            VStack {
                Group {
                    Text("Lütfen Bir antrenör seçin ve devam edin")
                        .padding(.top, 16)
                        .font(.headline)
                }

                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.persons) { person in
                            NavigationLink(destination: AntrenorListesiDetaySayfasi(person: person)
                                .navigationBarBackButtonHidden(true)
                            
                            ) {
                                PersonRowView(person: person)
                                    .padding()
                                    .background(Color.white) // Arkaplan rengi
                                    .cornerRadius(10) // Kenarları yuvarlatılmış kart görünümü
                                    .shadow(radius: 4) // Gölge eklemek
                                    .padding(.horizontal, 16)
                                    .padding(.top)
                            }
                        }
                    }
                }
                .navigationTitle("Trainer Listesi")
                .navigationBarTitleDisplayMode(.inline)
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
        }
    }
}

#Preview {
    AntrenorListesiSayfasi()
}
