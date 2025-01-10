//
//  LoginViewViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 1.10.2024.
//

import Foundation
import SwiftUICore

class TrainerLoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var isAuthenticated: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var userRole: String = ""
    @ObservedObject var authManager = AuthManager.shared

    init() {
        checkIfLoggedIn()
    }


    func login(role: String) {
        guard validate() else { return }

        Webservice().login(email: email, password: password) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let token):
                    authManager.login(token: token, role: role)
                    self.isAuthenticated = true
                    self.isLoggedIn = true
                    self.userRole = role
                    print("Başarılı giriş: \(token)")
                case .failure(let error):
                    self.errorMessage = "Giriş başarısız: \(error.localizedDescription)"
                }
            }
        }
    }

    func logout() {
        authManager.logout()

        DispatchQueue.main.async {
            self.isAuthenticated = false
            self.isLoggedIn = false
            self.userRole = ""
            print("Başarılı çıkış yapıldı, token ve rol silindi.")
        }
    }

    private func checkIfLoggedIn() {
        authManager.checkIfLoggedIn()
        DispatchQueue.main.async { [self] in
            self.isAuthenticated = authManager.isAuthenticated
            self.isLoggedIn = authManager.isAuthenticated
            self.userRole = authManager.userRole
        }
    }

  
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



class MemberLoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var isAuthenticated: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var userRole: String = ""
    @ObservedObject var authManager = AuthManager.shared

    init() {
        checkIfLoggedIn()
    }

    func login(role: String) {
        guard validate() else { return }

        Webservice2().login(email: email, password: password) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let token):
                    authManager.login(token: token, role: role)
                    self.isAuthenticated = true
                    self.isLoggedIn = true
                    self.userRole = role
                    print("Başarılı giriş: \(token)")
                case .failure(let error):
                    self.errorMessage = "Giriş başarısız: \(error.localizedDescription)"
                }
            }
        }
    }

    func logout() {
        authManager.logout()

        DispatchQueue.main.async {
            self.isAuthenticated = false
            self.isLoggedIn = false
            self.userRole = "" // Kullanıcı rolünü temizle
            print("Başarılı çıkış yapıldı, token ve rol silindi.")
        }
    }

    private func checkIfLoggedIn() {
        authManager.checkIfLoggedIn()
        DispatchQueue.main.async { [self] in
            self.isAuthenticated = authManager.isAuthenticated
            self.isLoggedIn = authManager.isAuthenticated
            self.userRole = authManager.userRole
        }
    }

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
