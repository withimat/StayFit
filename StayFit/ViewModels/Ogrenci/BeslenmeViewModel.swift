//
//  BeslenmeViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 12.10.2024.
//

import Foundation
import SwiftUI


class BeslenmeViewModel: ObservableObject {
    @Published var dietPlan: [WorkoutCevap] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchdietPlan() {
       
        guard let url = URL(string: "\(APIConfig.baseURL)/api/DietPlans/GetDietPlansByMemberId") else {
            self.errorMessage = "Invalid URL"
            return
        }

        guard let token = UserDefaults.standard.string(forKey: "jwt") else {
            self.errorMessage = "Missing authentication token"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        self.isLoading = true
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
               
                
                self?.isLoading = false

                if let error = error {
                    self?.errorMessage = "Request error: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    self?.errorMessage = "No data received"
                    return
                }

                do {
                    let response = try JSONDecoder().decode(DietPlanResponse.self, from: data)
                    print(response)
                    if response.success {
                        self?.dietPlan = response.getDietPlansByMemberIdDtos
                        print(response)
                        
                    } else {
                        self?.errorMessage = response.message
                    }
                } catch {
                    self?.errorMessage = "Failed to decode response: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
    
    
    
}
