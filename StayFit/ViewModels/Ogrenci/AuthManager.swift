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
            self.userRole = ""
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


/*
class AuthManager: ObservableObject {
    static let shared = AuthManager()  // Singleton yapısı
    
    @Published var isAuthenticated: Bool = false
    @Published var token: String? = nil
    @Published var userRole: String = ""
    
    private let sessionTimeout: TimeInterval = 30 * 60  // 30 dakika
    
    init() {
        checkIfLoggedIn()
    }

    /// Kullanıcı çıkışı (Token silinir)
    func logout() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "jwt")
        defaults.removeObject(forKey: "rol")
        defaults.removeObject(forKey: "loginTime")  // Giriş zamanı da silinir
        DispatchQueue.main.async {
            self.isAuthenticated = false
            self.token = nil
            self.userRole = ""
            print("Çıkış yapıldı, token silindi.")
        }
    }

    /// Uygulama açıldığında oturum kontrolü
    func checkIfLoggedIn() {
        let defaults = UserDefaults.standard
        if let savedToken = defaults.string(forKey: "jwt"),
           let savedRole = defaults.string(forKey: "rol"),
           let savedLoginTime = defaults.value(forKey: "loginTime") as? TimeInterval {
            
            let currentTime = Date().timeIntervalSince1970
            
            // Eğer 30 dakika geçmişse token ve role boşaltılır
            if currentTime - savedLoginTime > sessionTimeout {
                self.logout()
            } else {
                print(savedToken)
                print(savedRole)
                self.token = savedToken
                self.userRole = savedRole
                self.isAuthenticated = true
            }
        }
    }

    /// Giriş işlemi başarılı olduğunda çağrılacak fonksiyon
    func login(token: String, role: String) {
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: "jwt")
        defaults.set(role, forKey: "rol")
        defaults.set(Date().timeIntervalSince1970, forKey: "loginTime")  // Giriş zamanını kaydet
        self.token = token
        self.userRole = role
        self.isAuthenticated = true
        print("Giriş başarılı")
    }
}

*/
