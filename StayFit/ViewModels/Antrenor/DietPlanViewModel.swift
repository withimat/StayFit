//
//  DietPlanViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 4.12.2024.
//

import Foundation
import Alamofire

struct CreateDietPlanDto: Codable {
    var subscriptionId: String
    var memberId: String
    var title: String
    var description: String
    var startDate: Date
    var endDate: Date
}


class DietPlanViewModel: ObservableObject {
    @Published var subscriptionId = ""
    @Published var memberId = ""
    @Published var title = ""
    @Published var description = ""
    @Published var startDate = Date()
    @Published var endDate = Date()
    @Published var isSubmitting = false
    @Published var errorMessage: String?
    @Published var dietPlans: [WorkoutPlan] = []
    
    func resetFields() {
           self.title = ""
           self.description = ""
           self.startDate = Date()
           self.endDate = Date()
           self.errorMessage = nil
       }
    
    
    
    
    func createWorkoutPlan() {
       
        guard let url = URL(string: "\(APIConfig.baseURL)/api/DietPlans/CreateDietPlan") else {
            self.errorMessage = "Invalid URL"
            return
        }

        let DietPlan = CreateDietPlanDto(
            subscriptionId: subscriptionId,
            memberId: memberId,
            title: title,
            description: description,
            startDate: startDate,
            endDate: endDate
        )

        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .iso8601

        guard let jsonData = try? jsonEncoder.encode(DietPlan) else {
            self.errorMessage = "Failed to encode data"
            return
        }

        guard let token = UserDefaults.standard.string(forKey: "jwt") else {
            self.errorMessage = "Missing authentication token"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization") // JWT token ekleme
        request.httpBody = jsonData

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
                        
                        self?.errorMessage = "Server error: Status code \(httpResponse.statusCode)"

                        if let data = data, let responseString = String(data: data, encoding: .utf8) {
                            print("Server Response: \(responseString)")
                            self?.errorMessage = "Error: \(responseString) \(httpResponse.statusCode)"
                        }
                        return
                    }
                }
                
                self?.errorMessage = "Plan başarıyla gönderildi"
            }
        }.resume()
    }
    
    
    
    
}
