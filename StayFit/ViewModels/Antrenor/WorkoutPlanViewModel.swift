//
//  WorkoutPlanViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 18.11.2024.
//

import Foundation
import Alamofire

struct CreateWorkoutPlanDto: Codable {
    var subscriptionId: String
    var memberId: String
    var title: String
    var description: String
    var startDate: Date
    var endDate: Date
}


class WorkoutPlanViewModel: ObservableObject {
    @Published var subscriptionId = ""
    @Published var memberId = ""
    @Published var title = ""
    @Published var description = ""
    @Published var startDate = Date()
    @Published var endDate = Date()
    @Published var isSubmitting = false
    @Published var errorMessage: String?
    
    func resetFields() {
           self.title = ""
           self.description = ""
           self.startDate = Date()
           self.endDate = Date()
           self.errorMessage = nil
       }
    
    func createWorkoutPlan() {
        // API URL
        guard let url = URL(string: "http://localhost:5200/api/WorkoutPlans/CreateWorkoutPlan") else {
            self.errorMessage = "Invalid URL"
            return
        }

        // Prepare the model
        let workoutPlan = CreateWorkoutPlanDto(
            subscriptionId: subscriptionId,
            memberId: memberId,
            title: title,
            description: description,
            startDate: startDate,
            endDate: endDate
        )

        // Configure JSONEncoder for ISO 8601 date formatting
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .iso8601

        // Serialize to JSON
        guard let jsonData = try? jsonEncoder.encode(workoutPlan) else {
            self.errorMessage = "Failed to encode data"
            return
        }

        // Retrieve JWT token from UserDefaults
        guard let token = UserDefaults.standard.string(forKey: "jwt") else {
            self.errorMessage = "Missing authentication token"
            return
        }

        // Prepare the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization") // JWT token ekleme
        request.httpBody = jsonData

        // API Call
        self.isSubmitting = true
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isSubmitting = false

                if let error = error {
                    self?.errorMessage = "Request error: \(error.localizedDescription)"
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    // HTTP yanıt kodunu kontrol et
                    if httpResponse.statusCode != 200 {
                        // Hata durumunda statusCode'u ve yanıtı logla
                        self?.errorMessage = "Server error: Status code \(httpResponse.statusCode)"

                        // API'den gelen yanıtı al ve hata mesajını göster
                        if let data = data, let responseString = String(data: data, encoding: .utf8) {
                            print("Server Response: \(responseString)") // Sunucu yanıtını yazdır
                            self?.errorMessage = "Error: \(responseString) \(httpResponse.statusCode)"
                        }
                        return
                    }
                }
                
                self?.errorMessage = "Plan başarıyla gönderildi" // Başarılı işlem sonrası hata mesajı sıfırlanır
            }
        }.resume()
    }
}
