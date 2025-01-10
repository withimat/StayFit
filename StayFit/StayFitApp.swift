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
    @ObservedObject private var authManager = AuthManager.shared

    var body: some Scene {
        WindowGroup {
            ContentView2()
                .environmentObject(authManager) 
        }
    }
}

struct APIConfig {
    static let baseURL = "http://localhost:5200"
}


struct ContentView2: View {
    @ObservedObject var authManager = AuthManager.shared
    
    var body: some View {
        VStack {
            if authManager.token == nil || authManager.userRole.isEmpty {
               
                SecimEkrani()
            } else {
                // Eğer token ve userRole varsa, role göre yönlendirme yapılır
                if authManager.userRole == "trainer" {
                    AntrenorTabView()
                } else if authManager.userRole == "student" {
                    MainTabView()
                } else {
                
                    Text("Geçersiz rol")
                }
            }
        }
        .onAppear {
            
        }
    }
}
