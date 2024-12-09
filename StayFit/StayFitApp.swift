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
            if authManager.token == nil || authManager.userRole.isEmpty {
                // Eğer token yoksa ya da userRole boşsa, seçim ekranına yönlendirilir
                SecimEkrani()
            } else {
                // Eğer token ve userRole varsa, role göre yönlendirme yapılır
                if authManager.userRole == "trainer" {
                    AntrenorTabView()
                } else if authManager.userRole == "student" {
                    MainTabView()
                } else {
                    // Default olarak seçilen bir durum olabilir, burada diğer roller için bir şeyler yapılabilir.
                    Text("Geçersiz rol")
                }
            }
        }
        .onAppear {
            
        }
    }
}
