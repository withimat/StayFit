//
//  WeeklyWorkoutGetViewmodel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 24.11.2024.
//

import Foundation


class WeeklyWorkoutGetViewmodel: ObservableObject {
    @Published var workoutPlanId = 0
    @Published var title = ""
    @Published var dayOfWeek: DayOfWeek = .monday
    @Published var isSubmitting = false
    @Published var errorMessage: String?
    @Published var workoutDays: [WorkoutDays] = []
    @Published var isLoading = false
    
    
    func getWorkoutPlans() {
        guard let url = URL(string: "\(APIConfig.baseURL)/api/WorkoutDays/GetWorkoutDaysByWorkoutPlanId?workoutPlanId=\(workoutPlanId)") else {
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
        
        isLoading = true
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                print(response!)
                print(request)
                if let error = error {
                    self?.errorMessage = "Request error: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    self?.errorMessage = "No data received"
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(WorkoutDayResponse.self, from: data)
                    print(response)
                    if response.success {
                        
                        self?.workoutDays = response.getWorkoutDaysByWorkoutPlanIdDtos
                        print(response)
                        print(response.getWorkoutDaysByWorkoutPlanIdDtos)
                        print(data)
                    } else {
                        self?.errorMessage = response.message
                    }
                } catch {
                    self?.errorMessage = "Decoding error: \(error.localizedDescription)"
                }
            }
        }
    }
}
