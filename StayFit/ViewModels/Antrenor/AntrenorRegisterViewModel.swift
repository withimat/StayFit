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
    
    // Kullanıcıdan alınacak veriler
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var password: String = ""
    @Published var birthDate: Date = Calendar.current.date(from: DateComponents(year: 1973, month: 1, day: 2)) ?? Date()
    @Published var monthlyRate: Double = 0
    @Published var gender: Gender? = nil
    @Published var bio: String = ""

    // Durum yönetimi
    @Published var isLoading: Bool = false
    @Published var isRegistered: Bool = false
    @Published var errorMessage: String = ""
    
    var genderAsInt: Int? {
            return gender?.rawValue
        }
    
    
    /// Kullanıcı kayıt fonksiyonu
    func register() {
        guard validate() else { return }
        isLoading = true  
        errorMessage = ""

        // JSON nesnesi oluşturma
        let user = [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "phone": phone,
            "password": password,
            "birthDate": ISO8601DateFormatter().string(from: birthDate),
            "gender": genderAsInt as Any,
            "monthlyRate": monthlyRate,
            "bio": bio
        ] as [String: Any]

        guard let url = URL(string: "http://localhost:5200/api/Auth/TrainerRegister") else {
            errorMessage = "Geçersiz URL"
            isLoading = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // JSON encoding
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: user, options: [])
        } catch {
            errorMessage = "Veri işleme hatası: \(error.localizedDescription)"
            isLoading = false
            return
        }

        // API çağrısı
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

                // Başarılı kayıt
                self.isRegistered = true
                print("Kayıt başarılı")
            }
        }.resume()
    }

    /// Form doğrulama fonksiyonu
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
        
        if phone.isEmpty || phone.count < 10 {
            errorMessage = "Geçerli bir telefon numarası girin."
            return false
        }
        
        if password.isEmpty || password.count < 6 {
            errorMessage = "Şifre en az 6 karakter olmalıdır."
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
        
        if bio.isEmpty {
            errorMessage = "Lütfen bio bilgisi giriniz."
        }
        
        
        return true
    }

    /// E-posta doğrulama metodu
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
