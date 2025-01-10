//
//  ResetPasswordViewModel.swift
//  StayFit https://stayfitapi20241214032348.azurewebsites.net/api/Auth/UpdatePassword
//
//  Created by İmat Gökaslan on 18.12.2024.
//
import Foundation
import SwiftUI
import Combine
class PasswordResetViewModel: ObservableObject {
    @Published var currentPassword = ""
    @Published var newPassword = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isSuccess = false
    @Published var showAlert = false
    @Published var alertMessage = ""

    func changePassword() {
        isLoading = true

        guard let url = URL(string: "\(APIConfig.baseURL)/api/Auth/UpdatePassword") else {
            errorMessage = "Geçersiz URL"
            isLoading = false
            return
        }

        let token = UserDefaults.standard.string(forKey: "jwt") ?? ""

        let parameters: [String: Any] = [
            "currentPassword": currentPassword,
            "newPassword": newPassword
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            errorMessage = "Veri serileştirme hatası"
            isLoading = false
            return
        }

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false

                if let error = error {
                    self?.alertMessage = error.localizedDescription
                    self?.showAlert = true
                    print("Hata: \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    self?.alertMessage = "Veri alınamadı"
                    self?.showAlert = true
                    return
                }

                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let errors = jsonResponse["errors"] as? [String: [String]] {

                        // Hata mesajlarını birleştir
                        let errorMessages = errors.flatMap { $0.value }.joined(separator: "\n")
                        self?.alertMessage = errorMessages
                        self?.showAlert = true
                    } else {
                        // Başarılı yanıt işleme
                        let response = try JSONDecoder().decode(PasswordChangeResponse.self, from: data)
                        if response.success {
                            self?.isSuccess = true
                            self?.alertMessage = response.message
                        } else {
                            self?.alertMessage = response.message
                        }
                        self?.showAlert = true
                    }
                } catch {
                    self?.alertMessage = "Yanıt işlenirken hata oluştu: \(error.localizedDescription)"
                    self?.showAlert = true
                    print("Decode hatası: \(error)")
                }
            }
        }.resume()
    }
}

struct PasswordChangeResponse: Codable {
    let success: Bool
    let message: String
}
