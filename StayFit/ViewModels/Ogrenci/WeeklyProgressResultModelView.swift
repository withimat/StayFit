//
//  WeeklyProgressResultModelView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 25.11.2024.
//

import Foundation
// MARK: - Models
struct WeeklyProgressModel: Codable {
    let id: Int
    let height: Int
    let weight: Float
    let fat: Float
    let bmi: Float
    let waistCircumference: Float
    let neckCircumference: Float
    let chestCircumference: Float
}

struct ApiResponse: Codable {
    let success: Bool
    let message: String
    let getWeeklyProgressesBySubsIdDtos: [WeeklyProgressModel]?
    
    enum CodingKeys: String, CodingKey {
        case success
        case message
        case getWeeklyProgressesBySubsIdDtos
    }
}

// MARK: - ViewModel
class WeeklyProgressResultModelView: ObservableObject {
    @Published var progresses: [WeeklyProgressModel] = []
    @Published var errorMessage: String?
    @Published var isSuccess: Bool = false
    @Published var isLoading: Bool = false
    @Published var message: String = ""
    
    func fetchProgresses(subscriptionId: String) {
        guard let url = URL(string: "http://localhost:5200/api/WeeklyProgresses/GetWeeklyProgressesBySubsId?SubscriptionId=\(subscriptionId)") else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let token = UserDefaults.standard.string(forKey: "jwt") {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let error = error {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    self.errorMessage = "No data received from server"
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let apiResponse = try decoder.decode(ApiResponse.self, from: data)
                    self.isSuccess = apiResponse.success
                    self.message = apiResponse.message
                    
                    if apiResponse.success {
                        if let progresses = apiResponse.getWeeklyProgressesBySubsIdDtos {
                            self.progresses = progresses
                        }
                    } else {
                        self.errorMessage = apiResponse.message
                    }
                } catch {
                    print("Decode error: \(error)")
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Received JSON: \(jsonString)")
                    }
                    self.errorMessage = "Failed to decode response: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
