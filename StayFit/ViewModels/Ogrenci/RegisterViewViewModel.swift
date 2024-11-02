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
    @Published var isLoading = false  // API çağrısı sırasında loading durumu
    @Published var isRegistered = false  // Kayıt işlemi başarı durumunu takip eder

    // Height ve Weight için Int dönüştürücüler
    var heightInt: Int {
        get { Int(height) }
        set { height = Double(newValue) }
    }

    var weightInt: Int {
        get { Int(weight) }
        set { weight = Double(newValue) }
    }
    
  

    init() {}

    /// Form verilerini sıfırlar
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
    
    
    /// Doğum tarihinin belirli bir tarihle eşleşip eşleşmediğini kontrol eder
    func isSpecificDate(_ date: Date) -> Bool {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        return components.year == 1973 && components.month == 1 && components.day == 2
    }

    /// Kullanıcı kayıt fonksiyonu
    func register() {
        guard validate() else { return }
        isLoading = true  // API çağrısı başlıyor
        errorMessage = "" // Önceki hata mesajı temizleniyor

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

        guard let url = URL(string: "http://localhost:5200/api/Auth/MemberRegister") else {
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

                // Başarılı kayıt
                self.isRegistered = true
                self.resetForm()  // Kayıt sonrası form temizlenir
                self.errorMessage = "Kayıt Yapıldı"
                print("Kayıt başarılı")
            }
        }.resume()
    }

    /// Kullanıcı verilerini doğrulayan fonksiyon
    func validate() -> Bool {
        errorMessage = ""
        guard !firstName.trimmingCharacters(in: .whitespaces).isEmpty,
              !lastName.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !phone.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Lütfen tüm alanları doldurunuz..."
            return false
        }

        guard email.contains("@") && email.contains(".com") else {
            errorMessage = "Geçerli bir email adresi giriniz."
            return false
        }

        guard password.count >= 8 else {
            errorMessage = "Lütfen en az 8 haneli parola girin."
            return false
        }

        return true
    }
}
