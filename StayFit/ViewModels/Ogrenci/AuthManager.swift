//
//  AuthManager.swift
//  StayFit
//
//  Created by İmat Gökaslan on 19.10.2024.
//

import Foundation
class AuthManager: ObservableObject {
    static let shared = AuthManager()  // Singleton yapısı
    
    @Published var isAuthenticated: Bool = false
    @Published var token: String? = nil
    @Published var userRole: String = ""
    init() {
    checkIfLoggedIn()
    }

    /// Kullanıcı çıkışı (Token silinir)
    func logout() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "jwt")
        defaults.removeObject(forKey: "rol")
        DispatchQueue.main.async {
            self.isAuthenticated = false
            self.token = nil
            self.userRole = "" // Rolü sıfırla
            print("Çıkış yapıldı, token silindi.")
        }
    }

    /// Uygulama açıldığında oturum kontrolü
     func checkIfLoggedIn() {
        let defaults = UserDefaults.standard
        if let savedToken = defaults.string(forKey: "jwt") ,
           let savedRole = defaults.string(forKey: "rol"){
            print(savedToken)
            print(savedRole)
            self.token = savedToken
            self.userRole = savedRole
            self.isAuthenticated = true
        }
    }
}
