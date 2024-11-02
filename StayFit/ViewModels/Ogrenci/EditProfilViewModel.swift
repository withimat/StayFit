//
//  EditProfilViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 2.11.2024.
//

import Foundation


class EditProfileViewModel: ObservableObject {
    func updateProfile(_ profile: UserProfile) {
        guard let url = URL(string: "http://localhost:5200/api/Members/UpdateMemberProfile") else {
            print("Geçersiz URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // JWT token ayarı
        if let token = UserDefaults.standard.string(forKey: "jwt") {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        // Tüm profili JSON olarak göndermek için JSONEncoder kullanıyoruz
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601 // Tarih formatlama gerekiyorsa
            request.httpBody = try encoder.encode(profile)
        } catch {
            print("JSON kodlama hatası: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Güncelleme hatası: \(error)")
            } else {
                print("Profil başarıyla güncellendi")
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("Sunucu yanıtı: \(responseString)")
                }
            }
        }.resume()
    }
}
