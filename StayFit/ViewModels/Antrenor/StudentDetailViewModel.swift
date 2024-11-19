//
//  StudentDetailViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 20.11.2024.
//

import Foundation
class StudentDetailViewModel: ObservableObject {
    @Published var workoutPlan: [WorkoutCevap] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchWorkoutPlan(subscriptionId: String) {
        // API URL
        guard let url = URL(string: "http://localhost:5200/api/WorkoutPlans/GetWorkoutPlansBySubscriptionId?subscriptionId=\(subscriptionId)") else {
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
                    let response = try JSONDecoder().decode(WorkoutPlanResponse2.self, from: data)

                    if response.success {
                        self?.workoutPlan = response.getWorkoutPlansBySubscriptionIdDtos
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
