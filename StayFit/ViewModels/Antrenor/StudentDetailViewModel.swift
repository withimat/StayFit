//
//  StudentDetailViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 20.11.2024.
//

import Foundation



class StudentDetailViewModel: ObservableObject {
    
    @Published var workoutPlan: [WorkoutCevap] = []
    @Published var dietPlan : [WorkoutCevap] = []
    @Published var isLoading = false
    @Published var isLoading2 = false
    @Published var errorMessage: String?
    @Published var errorMessage2: String?
    @Published var isSubmitting = false
    @Published var workoutPlans: [WorkoutPlan] = []
    @Published var workoutPlans2: [WorkoutPlan] = []
    @Published var studentid = "0"

    func fetchWorkoutPlan(subscriptionId: String) {
       
        guard let url = URL(string: "\(APIConfig.baseURL)/api/WorkoutPlans/GetWorkoutPlansBySubscriptionId?subscriptionId=\(subscriptionId)") else {
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
    
    
    func deleteWorkoutPlan(id: Int) {
            
            guard let url = URL(string: "\(APIConfig.baseURL)/api/WorkoutPlans/DeleteWorkoutPlanById/\(id)") else {
                self.errorMessage = "Invalid URL"
                return
            }

            guard let token = UserDefaults.standard.string(forKey: "jwt") else {
                self.errorMessage = "Missing authentication token"
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization") // JWT token ekleme

            self.isSubmitting = true
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                DispatchQueue.main.async {
                    self?.isSubmitting = false

                    if let error = error {
                        self?.errorMessage = "Request error: \(error.localizedDescription)"
                        return
                    }

                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode != 200 {
                            self?.errorMessage = "Server error: Status code \(httpResponse.statusCode)"
                            return
                        }
                    }
                  
                    self?.workoutPlans2.removeAll { $0.WorkoutPlanId == id }
                    self?.errorMessage = "Plan başarıyla silindi"
                }
            }.resume()
        }
    
    
    func updateWorkoutPlan(workoutPlan: WorkoutCevap) {
       
        guard let url = URL(string: "\(APIConfig.baseURL)/api/WorkoutPlans/UpdateWorkoutPlan") else {
            self.errorMessage = "Invalid URL"
            return
        }

      
        guard let token = UserDefaults.standard.string(forKey: "jwt") else {
            self.errorMessage = "Missing authentication token"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")


        do {
            let jsonData = try JSONEncoder().encode(workoutPlan)
            request.httpBody = jsonData
        } catch {
            self.errorMessage = "Failed to encode data: \(error.localizedDescription)"
            return
        }

   
        self.isSubmitting = true
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isSubmitting = false

                if let error = error {
                    self?.errorMessage = "Request error: \(error.localizedDescription)"
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode != 200 {
                        self?.errorMessage = "Server error: Status code \(httpResponse.statusCode)"
                        return
                    }
                }

               
                if let index = self?.workoutPlan.firstIndex(where: { $0.id == workoutPlan.id }) {
                    self?.workoutPlan[index] = workoutPlan
                }
                self?.errorMessage = "Plan başarıyla güncellendi"
            }
        }.resume()
    }
    
    
    func fetchDietPlan(subscriptionId: String) {
      
        guard let url = URL(string: "\(APIConfig.baseURL)/api/DietPlans/GetDietPlansBySubscriptionId?subscriptionId=\(subscriptionId)") else {
            self.errorMessage2 = "Invalid URL"
            return
        }

        guard let token = UserDefaults.standard.string(forKey: "jwt") else {
            self.errorMessage2 = "Missing authentication token"
            return
        }

    
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

       
        self.isLoading2 = true
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading2 = false

                if let error = error {
                    self?.errorMessage2 = "Request error: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    self?.errorMessage2 = "No data received"
                    return
                }

                do {
                    let response = try JSONDecoder().decode(DietPlanResponse2.self, from: data)

                    if response.success {
                        self?.dietPlan = response.getDietPlansBySubscriptionIdDtos
                    } else {
                        self?.errorMessage2 = response.message
                    }
                } catch {
                    self?.errorMessage2 = "Failed to decode response: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
    
    func deleteDietPlan(id: Int) {
           
            guard let url = URL(string: "\(APIConfig.baseURL)/api/DietPlans/DeleteDietPlan?dietPlanId=\(id)") else {
                self.errorMessage = "Invalid URL"
                return
            }

            guard let token = UserDefaults.standard.string(forKey: "jwt") else {
                self.errorMessage = "Missing authentication token"
                return
            }

    
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

            self.isSubmitting = true
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                DispatchQueue.main.async {
                    self?.isSubmitting = false

                    if let error = error {
                        self?.errorMessage = "Request error: \(error.localizedDescription)"
                        return
                    }

                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode != 200 {
                            self?.errorMessage = "Server error: Status code \(httpResponse.statusCode)"
                            return
                        }
                    }
                    
               
                    self?.workoutPlans.removeAll { $0.WorkoutPlanId == id }
                    self?.errorMessage = "Plan başarıyla silindi"
                }
            }.resume()
        }
    
    
}
