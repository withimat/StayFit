//
//  MainTabView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 1.10.2024.
//

import SwiftUI


struct MainTabView: View {
    @State var activeTab: Tab = .anasayfa
    
    var body: some View {
        VStack(spacing: 0) {
       
            activeTab.view
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all, edges: .bottom)
            

            
            CustomTabBar(activeTab: $activeTab)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MainTabView()
}


/*
 struct MainTabView : View {
     @State private var selectedTab = 0
     var body: some View {
         TabView(selection : $selectedTab){
             Text("Feed")
                 .tabItem {
                     Label("Akış", systemImage: "house")
                 }
                 .tag(0)
             
             Text("Antrenman Programı")
                 .tabItem {
                     Label("Antrenman", systemImage: "figure.gymnastics")
                 }
                 .tag(1)
             
             
             Text("Beslenme")
                 .tabItem {
                     Label("Beslenme", systemImage: "list.bullet.clipboard.fill")
                     
                 }
                 .tag(2)
             
             
             
             ProfileView()
                 .tabItem {
                     Label("Profil", systemImage: "person.fill")
                     }
                 .tag(3)
                 
           
         }
         .accentColor(.orange)
         
         
     }
 }

 
 */
