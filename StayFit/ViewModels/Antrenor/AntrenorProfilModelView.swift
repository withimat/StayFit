//
//  AntrenorProfilModelView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 28.10.2024.
//

import Foundation


struct AntrenorProfile: Codable {
    var id: String
    var createdDate: String
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
    var photoPath: String?
    var birthDate: String
    var gender: String
    var monthlyRate: Double
    var bio: String
}

class AntrenorProfilModelView: ObservableObject {
    @Published var antrenorProfile: AntrenorProfile?

    func fetchAntrenorProfile() {
        guard let token = UserDefaults.standard.string(forKey: "jwt") else {
            print("Token bulunamadı")
            return
        }

        guard let url = URL(string: "\(APIConfig.baseURL)/api/Trainers/GetTrainerProfile") else {
            print("Geçersiz URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("İstek hatası: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Veri bulunamadı")
                return
            }

            do {
                let profile = try JSONDecoder().decode(AntrenorProfile.self, from: data)
                DispatchQueue.main.async {
                    self?.antrenorProfile = profile
                }
            } catch {
                print("JSON çözümleme hatası: \(error.localizedDescription)")
            }
        }.resume()
    }
}
