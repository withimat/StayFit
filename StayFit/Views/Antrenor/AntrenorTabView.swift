//
//  AntrenorTabView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 19.10.2024.
//

import SwiftUI

struct AntrenorTabView: View {
    init() {
        configureNavigationBar()
    }
    
    var body: some View {
        TabView {
            AntrenorAnasayfa()
                .tabItem {
                    Label("Anasayfa", systemImage: "house.fill")
                }
                .background(Color("BG")) // Arka plan rengini belirleme
                .ignoresSafeArea(.all, edges: .bottom)
            
            AntrenorProfil()
                .tabItem {
                    Label("Profil", systemImage: "person.fill")
                }
                .background(Color("BG"))
                .ignoresSafeArea(.all, edges: .bottom)
        }
        .accentColor(Color(.blue)) // Tab icon ve text renk ayarı
    }
    
    // NavigationBar ayarlarını modüler hale getirdik
    private func configureNavigationBar() {
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
}

#Preview {
    AntrenorTabView()
}
