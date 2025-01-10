//
//  AuthManager.swift
//  StayFit
//
//  Created by İmat Gökaslan on 19.10.2024.
//

import Foundation
/*
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
*/

class AuthManager: ObservableObject {
    static let shared = AuthManager() // Singleton yapısı

    @Published var isAuthenticated: Bool = false
    @Published var token: String? = nil
    @Published var userRole: String = ""

    private let sessionTimeout: TimeInterval = 90 * 60 
    private var timer: Timer?

    init() {
        checkIfLoggedIn()
        startSessionTimer()
    }

    deinit {
        timer?.invalidate()
    }


    func logout() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "jwt")
        defaults.removeObject(forKey: "rol")
        defaults.removeObject(forKey: "loginTime")
        DispatchQueue.main.async {
            self.isAuthenticated = false
            self.token = nil
            self.userRole = ""
            print("Çıkış yapıldı, token silindi.")
        }
        timer?.invalidate()
    }

 
    
    func login(token: String, role: String) {
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: "jwt")
        defaults.set(role, forKey: "rol")
        defaults.set(Date().timeIntervalSince1970, forKey: "loginTime")
        self.token = token
        self.userRole = role
        self.isAuthenticated = true
        print("Giriş başarılı")
        startSessionTimer()
    }

    /// Kullanıcının hâlâ oturum açık mı kontrolü
    func checkIfLoggedIn() {
        let defaults = UserDefaults.standard
        if let token = defaults.string(forKey: "jwt"),
           let role = defaults.string(forKey: "rol"),
           let loginTime = defaults.object(forKey: "loginTime") as? TimeInterval {
            
            let currentTime = Date().timeIntervalSince1970
            if currentTime - loginTime < sessionTimeout {
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                    self.token = token
                    self.userRole = role
                    print("Hâlâ oturum açık: \(token), Rol: \(role)")
                }
                startSessionTimer()
            } else {
                print("Oturum süresi doldu.")
                logout()
            }
        } else {
            DispatchQueue.main.async {
                self.isAuthenticated = false
                self.token = nil
                self.userRole = ""
                print("Oturum açık değil.")
            }
        }
    }

   
    private func startSessionTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.checkSessionTimeout()
        }
    }

    /// Oturum süresini kontrol eder ve gerekirse çıkış yapar
    private func checkSessionTimeout() {
        let defaults = UserDefaults.standard
        if let loginTime = defaults.object(forKey: "loginTime") as? TimeInterval {
            let currentTime = Date().timeIntervalSince1970
            if currentTime - loginTime >= sessionTimeout {
                print("Oturum süresi doldu. Çıkış yapılıyor...")
                self.logout()
            }
        }
    }
}



/*
func checkIfLoggedIn() {
    let defaults = UserDefaults.standard
    if let savedToken = defaults.string(forKey: "jwt"),
       let savedRole = defaults.string(forKey: "rol"){
        print(savedToken)
        print(savedRole)
        self.token = savedToken
        self.userRole = savedRole
        self.isAuthenticated = true
    }
    
}
 */
