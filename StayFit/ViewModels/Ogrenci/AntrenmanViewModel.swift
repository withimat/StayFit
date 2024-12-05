//
//  AntrenmanViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 13.10.2024.
//

import Foundation
import SwiftUI


struct WorkoutCevap: Codable {
    var id: Int
    var title: String
    var description: String
    var formattedStartDate: String
    var formattedEndDate: String
    var status: Int
    var endDate: String
    var startDate: String
}

struct WorkoutPlanResponse2: Codable {
    var getWorkoutPlansBySubscriptionIdDtos: [WorkoutCevap] // Yeni dizi adı
    var success: Bool
    var message: String
}

struct WorkoutPlanResponse: Codable {
    var getWorkoutPlansByMemberIdDtos: [WorkoutCevap]
    var success: Bool
    var message: String
}

struct DietPlanResponse2: Codable {
    var getDietPlansBySubscriptionIdDtos: [WorkoutCevap]
    var success: Bool
    var message: String
}

struct DietPlanResponse: Codable {
    var getDietPlansByMemberIdDtos: [WorkoutCevap]
    var success: Bool
    var message: String
}



class AntrenmanViewModel: ObservableObject {
    @Published var workoutPlan: [WorkoutCevap] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchWorkoutPlan() {
        // API URL
        guard let url = URL(string: "http://localhost:5200/api/WorkoutPlans/GetWorkoutPlansByMemberId") else {
            self.errorMessage = "Invalid URL"
            return
        }

        // Retrieve JWT token from UserDefaults
        guard let token = UserDefaults.standard.string(forKey: "jwt") else {
            self.errorMessage = "Missing authentication token"
            return
        }

        // Prepare the request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        // API Call
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
                    let response = try JSONDecoder().decode(WorkoutPlanResponse.self, from: data)

                    if response.success {
                        self?.workoutPlan = response.getWorkoutPlansByMemberIdDtos
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
