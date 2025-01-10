//
//  AntrenorEditProfileViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 2.11.2024.
//

import Foundation


class AntrenorEditProfileViewModel: ObservableObject {
    func updateProfile(_ profile: AntrenorProfile) {
        guard let url = URL(string: "\(APIConfig.baseURL)/api/Trainers/UpdateTrainerProfile") else {
            print("Geçersiz URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        

        if let token = UserDefaults.standard.string(forKey: "jwt") {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
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
