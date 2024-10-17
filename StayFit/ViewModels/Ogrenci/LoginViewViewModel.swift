//
//  LoginViewViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 1.10.2024.
//

import Foundation

class LoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var isAuthenticated: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var userRole: String = ""  // Kullanıcı rolü eklendi

    init() {
        checkIfLoggedIn()
    }

    /// Kullanıcı giriş işlemi
    func login(role: String) {
        guard validate() else { return }

        let defaults = UserDefaults.standard
        
        Webservice().login(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let token):
                    defaults.setValue(token, forKey: "jwt")
                    defaults.setValue(role, forKey: "rol")  // Rolü kaydet
                    self.isAuthenticated = true
                    self.isLoggedIn = true
                    self.userRole = role  // Kullanıcı rolünü güncelle
                    print("Başarılı giriş: \(token)")
                case .failure(let error):
                    self.errorMessage = "Giriş başarısız: \(error.localizedDescription)"
                }
            }
        }
    }

    /// Kullanıcı çıkış işlemi (token ve rol silinir)
    func logout() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "jwt")
        defaults.removeObject(forKey: "rol")  // Rolü sil

        DispatchQueue.main.async {
            self.isAuthenticated = false
            self.isLoggedIn = false
            self.userRole = ""  // Kullanıcı rolünü temizle
            print("Başarılı çıkış yapıldı, token ve rol silindi.")
        }
    }

    /// Kullanıcının hâlâ oturum açık mı kontrolü
    private func checkIfLoggedIn() {
        let defaults = UserDefaults.standard
        if let token = defaults.string(forKey: "jwt"),
           let role = defaults.string(forKey: "rol") {
            isAuthenticated = true
            isLoggedIn = true
            userRole = role// Rolü kaydet
            print("hala oturum acık.\n\(token)")
        }
    }

    /// Form doğrulama fonksiyonu
    func validate() -> Bool {
        errorMessage = ""

        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Lütfen tüm alanları doldurun"
            return false
        }

        guard email.contains("@") && email.contains(".com") else {
            errorMessage = "Lütfen geçerli bir email adresi giriniz"
            return false
        }

        return true
    }
}
