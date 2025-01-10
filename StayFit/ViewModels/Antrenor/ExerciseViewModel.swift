//
//  ExerciseViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 22.11.2024.
//

import Foundation
import Combine

struct Exercise: Codable , Identifiable{
    var id: Int
    var workoutDayId: Int
    var priority: Int
    var name: String
    var description: String
    var setCount: Int
    var repetitionCount: Int
    var durationMinutes: Int
    var exerciseLevel: Int
    var exerciseCategory: Int
}

typealias ExerciseArray = [Exercise]

struct GetExercisesResponse: Codable {
    let getExercisesByWorkoutDayIdDtos: [Exercise]?
    let messages: String?
    let success: Bool
}


class ExerciseViewModel: ObservableObject {
    @Published var exercises: [Exercise] = [] // List of exercises
    @Published var errorMessage: String? // To display error messages if any
    @Published var isLoading: Bool = false
    @Published var yenile: Bool = false
    @Published var WorkoutId = 0
    let apiBaseURL = "\(APIConfig.baseURL)/api/Exercises"
   
    func fetchExercises(for workoutDayId: Int) {
        guard let url = URL(string: "\(apiBaseURL)/GetExercisesByWorkoutDayId?workoutDayId=\(workoutDayId)") else {
            print("Invalid URL")
            return
        }
        
        guard let token = UserDefaults.standard.string(forKey: "jwt") else {
            print("JWT token is missing")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        isLoading = true
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Error fetching exercises: \(error.localizedDescription)"
                }
                print("Error fetching exercises: \(error)")
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received from the server."
                }
                print("No data received")
                return
            }
            
            do {
                
            
                let response = try JSONDecoder().decode(GetExercisesResponse.self, from: data)
                
                if response.success {
                    DispatchQueue.main.async {
                        self.exercises = response.getExercisesByWorkoutDayIdDtos ?? []
                        print(response.getExercisesByWorkoutDayIdDtos!)
                        self.errorMessage = nil
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errorMessage = response.messages ?? "An unknown error occurred."
                        print(response)
                        print(response.messages!)
                    }
                    print("Error message from server: \(response.messages ?? "No message")")
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to decode response: \(error.localizedDescription)"
                }
                print("Error decoding response: \(error)")
            }
        }.resume()
    }
    
  
        
        func addExercises(_ exercises: [Exercise]) {
            guard let url = URL(string: "\(apiBaseURL)/CreateExercise") else {
                self.errorMessage = "Invalid URL"
                return
            }
            
            guard let token = UserDefaults.standard.string(forKey: "jwt") else {
                self.errorMessage = "JWT token is missing"
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            do {
                let jsonData = try JSONEncoder().encode(exercises)
                request.httpBody = jsonData
                
                URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                    DispatchQueue.main.async {
                        if let error = error {
                            self?.errorMessage = "Error: \(error.localizedDescription)"
                            return
                        }
                        
                        guard let httpResponse = response as? HTTPURLResponse else {
                            self?.errorMessage = "Invalid response"
                            return
                        }
                        
                        if httpResponse.statusCode == 200 {
                            self?.exercises.append(contentsOf: exercises)
                            self?.errorMessage = nil
                        } else {
                            self?.errorMessage = "Server error: \(httpResponse.statusCode)"
                        }
                    }
                }.resume()
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Error encoding exercise: \(error.localizedDescription)"
                }
            }
        }
    
    
    func deleteWorkoutDay(by id: Int) {
        guard let url = URL(string: "\(APIConfig.baseURL)/api/Exercises/DeleteExercise?excersiceId=\(id)") else {
            self.errorMessage = "Geçersiz URL"
            return
        }
        
        guard let token = UserDefaults.standard.string(forKey: "jwt") else {
            self.errorMessage = "JWT token eksik"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        isLoading = true
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    self?.errorMessage = "Egzersiz silme hatası: \(error.localizedDescription)"
                }
                print("Error deleting workout day: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    self?.errorMessage = "Geçersiz sunucu yanıtı"
                }
                return
            }
            
            if httpResponse.statusCode == 200 {
                DispatchQueue.main.async { [self] in

                    self?.exercises.removeAll { $0.workoutDayId == id }
                    self?.fetchExercises(for: self?.WorkoutId ?? 0)
                    self?.errorMessage = nil
                }
            } else {
                DispatchQueue.main.async {
                    self?.errorMessage = "Egzersiz silme başarısız. Durum kodu: \(httpResponse.statusCode)"
                }
            }
        }.resume()
    }

    
    
}
