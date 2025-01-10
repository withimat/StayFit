//
//  AntrenorRegisterViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 19.10.2024.
//

import Foundation
import SwiftUI
import Combine

class AntrenorRegisterViewModel: ObservableObject {
    
 
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var password: String = ""
    @Published var birthDate: Date = Calendar.current.date(from: DateComponents(year: 1973, month: 1, day: 2)) ?? Date()
    @Published var monthlyRate: Double = 0
    @Published var gender: Gender? = nil
    @Published var bio: String = ""
    @Published var YearsOfExperience : Int = 0
    @Published var specializations : String = ""

    @Published var isLoading: Bool = false
    @Published var isRegistered: Bool = false
    @Published var errorMessage: String = ""
    
    var genderAsInt: Int? {
            return gender?.rawValue
        }
    
    
    
    func register() {
        guard validate() else { return }
        isLoading = true  
        errorMessage = ""

      
        let user = [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "phone": phone,
            "password": password,
            "birthDate": ISO8601DateFormatter().string(from: birthDate),
            "gender": genderAsInt as Any,
            "monthlyRate": monthlyRate,
            "bio": bio,
            "YearsOfExperience" : YearsOfExperience,
            "specializations" : specializations
        ] as [String: Any]

        guard let url = URL(string: "\(APIConfig.baseURL)/api/Auth/TrainerRegister") else {
            errorMessage = "Geçersiz URL"
            isLoading = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

      
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: user, options: [])
        } catch {
            errorMessage = "Veri işleme hatası: \(error.localizedDescription)"
            isLoading = false
            return
        }

       
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false  // Çağrı tamamlandı

                if let error = error {
                    self.errorMessage = "Ağ hatası: \(error.localizedDescription)"
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    self.errorMessage = "Sunucu hatası"
                    
                    return
                }

                
                self.isRegistered = true
                print("Kayıt başarılı")
            }
        }.resume()
    }

  
    func validate() -> Bool {
        errorMessage = ""
        
        if firstName.isEmpty || lastName.isEmpty {
            errorMessage = "Ad ve soyad boş bırakılamaz."
            return false
        }
        
        if !isValidEmail(email) {
            errorMessage = "Geçerli bir e-posta adresi girin."
            return false
        }
        
        if !isValidPhone(phone) {
                errorMessage = "Geçerli bir telefon numarası giriniz. (Örnek: +905555555555 veya 05555555555)"
                return false
            }
        
       
        if !isValidPassword(password) {
                return false
            }
        
        if gender == nil {
            errorMessage = "Lütfen cinsiyetinizi seçin."
            return false
        }
        
        if monthlyRate <= 0 {
            errorMessage = "Aylık ücret sıfırdan büyük olmalıdır."
            return false
        }
        
        if bio.trimmingCharacters(in: .whitespacesAndNewlines).count < 31 {
            errorMessage = "Bio en az 30 karakter olmalıdır."
            return false
        }
        
        
        
        return true
    }

    private func isValidPassword(_ password: String) -> Bool {
        if password.range(of: "[A-Z]", options: .regularExpression) == nil {
            errorMessage = "Şifre en az bir büyük harf içermelidir."
            return false
        }
        
        if password.range(of: "[a-z]", options: .regularExpression) == nil {
            errorMessage = "Şifre en az bir küçük harf içermelidir."
            return false
        }
        
        if password.count < 6 {
            errorMessage = "Şifre en az 6 karakter uzunluğunda olmalıdır."
            return false
        }
        
        return true
    }
    
    
    private func isValidPhone(_ phone: String) -> Bool {
        let phoneRegex = #"^(?:\+90)?5\d{9}$|^(05\d{9})$"#
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phone)
    }
   
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
