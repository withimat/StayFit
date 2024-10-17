//
//  StayFitApp.swift
//  StayFit
//
//  Created by İmat Gökaslan on 1.10.2024.
//

import SwiftUI

@main
struct StayFitApp: App {
    // AuthManager Singleton’ını izlemek için StateObject
    @StateObject private var authManager = AuthManager.shared

    var body: some Scene {
        WindowGroup {
            ContentView2()
                .environmentObject(authManager) 
        }
    }
}

struct ContentView2: View {
    @EnvironmentObject var authManager: AuthManager

       var body: some View {
           VStack {
               if authManager.userRole == "trainer" {
                   // Trainer'a özel görünüm
                   AntrenorTabView()  // Trainer görünümünü burada tanımlayabilirsin
               } else if authManager.userRole == "student" {
                  MainTabView()
               } else {
                   SecimEkrani()
               }
           }
           .onAppear {
              
            
           }
       }
}
