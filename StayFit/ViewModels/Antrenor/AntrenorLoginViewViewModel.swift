//
//  AntrenorLoginViewViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 13.10.2024.
//

import Foundation


class AntrenorLoginViewViewModel : ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var isAuthenticated : Bool = false
    @Published var isLoggedIn: Bool = false
    init() {}
    
    func login(){
        guard validate() else {
            return
        }
        
        let defaults = UserDefaults.standard
        
        Webservice().login(email: email, password: password){ result in
            switch result {
            case .success(let token):
                defaults.setValue(token, forKey: "jsonwebtoken")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                    print("başarılıııı")
                    print(token)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
        self.isLoggedIn = true
    }
    
    
    func validate() -> Bool {
        errorMessage = ""
        
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            errorMessage = "Lütfen tüm alanları doldurun"
            return false
        }
        
        guard email.contains("@") && email.contains(".com") else{
            errorMessage = "Lütfen geçerli bir email adresi giriniz...."
            return false
        }
        
        return true
    }
    
    
}
