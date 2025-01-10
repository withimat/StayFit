//
//  RegisterViewViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 1.10.2024.
//

import Foundation

class RegisterViewViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var phone = ""
    @Published var birthDate = Calendar.current.date(from: DateComponents(year: 1973, month: 1, day: 2)) ?? Date()
    @Published var gender: Gender? = nil
    @Published var height = 180.0
    @Published var weight = 80.0
    @Published var errorMessage = ""
    @Published var isLoading = false  
    @Published var isRegistered = false

    var heightInt: Int {
        get { Int(height) }
        set { height = Double(newValue) }
    }

    var weightInt: Int {
        get { Int(weight) }
        set { weight = Double(newValue) }
    }
    
  

    init() {}

    func resetForm() {
        firstName = ""
        lastName = ""
        email = ""
        password = ""
        phone = ""
        birthDate = Calendar.current.date(from: DateComponents(year: 1973, month: 1, day: 2)) ?? Date()
        height = 180.0
        weight = 80.0
    }

    var genderAsInt: Int? {
            return gender?.rawValue
        }
    
    
    func isSpecificDate(_ date: Date) -> Bool {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        return components.year == 1973 && components.month == 1 && components.day == 2
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
            "height": heightInt,
            "weight": weightInt
        ] as [String: Any]

        guard let url = URL(string: "\(APIConfig.baseURL)/api/Auth/MemberRegister") else {
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
                self.isLoading = false

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
                self.resetForm()
                self.errorMessage = "Kayıt Yapıldı"
                print("Kayıt başarılı")
            }
        }.resume()
    }

    func validate() -> Bool {
        errorMessage = ""

        // Ad kontrolü
        if firstName.trimmingCharacters(in: .whitespaces).isEmpty {
            errorMessage = "İsim boş geçilemez."
            return false
        }

        // Soyad kontrolü
        if lastName.trimmingCharacters(in: .whitespaces).isEmpty {
            errorMessage = "Soyad boş geçilemez."
            return false
        }

        // Email kontrolü
        if email.trimmingCharacters(in: .whitespaces).isEmpty {
            errorMessage = "E-posta adresi boş geçilemez."
            return false
        }
        if !isValidEmail(email) {
            errorMessage = "E-posta adresi uygun formatta değil."
            return false
        }

        // Telefon kontrolü
        if phone.trimmingCharacters(in: .whitespaces).isEmpty {
            errorMessage = "Telefon numarası boş geçilemez."
            return false
        }
        if !isValidPhone(phone) {
            errorMessage = "Geçerli bir telefon numarası giriniz. (Örnek: +905555555555 veya 05555555555)"
            return false
        }

        // Şifre kontrolü
        if password.trimmingCharacters(in: .whitespaces).isEmpty {
            errorMessage = "Şifre boş bırakılamaz."
            return false
        }
        if !isValidPassword(password) {
            return false // Şifre hataları `isValidPassword` içinde atanır
        }

        // Boy kontrolü
        if height <= 0 {
            errorMessage = "Boy değeri boş veya 0 olamaz."
            return false
        }

        // Kilo kontrolü
        if weight <= 0 {
            errorMessage = "Kilo değeri boş veya 0 olamaz."
            return false
        }
        if gender != .erkek && gender != .kadın{
            errorMessage = "Cinsiyet seç "
            return false 
        }
        return true
    }
    
    
    private func isValidPhone(_ phone: String) -> Bool {
        let phoneRegex = #"^(?:\+90)?5\d{9}$|^(05\d{9})$"#
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phone)
    }
    private func isValidPassword(_ password: String) -> Bool {
        if password.count < 8 {
            errorMessage = "Şifre en az 8 karakter olmalıdır."
            return false
        }
        if password.range(of: "[A-Z]", options: .regularExpression) == nil {
            errorMessage = "Şifre en az bir büyük harf içermelidir."
            return false
        }
        if password.range(of: "[a-z]", options: .regularExpression) == nil {
            errorMessage = "Şifre en az bir küçük harf içermelidir."
            return false
        }
        if password.range(of: "[0-9]", options: .regularExpression) == nil {
            errorMessage = "Şifre en az bir rakam içermelidir."
            return false
        }
        return true
    }
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

}
