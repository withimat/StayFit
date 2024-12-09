//
//  DietListModelView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 7.12.2024.
//getDietsByDietDayIdDtos

import Foundation


struct DietMeal: Identifiable, Codable {
    var id: Int
    var dietDayId: Int? // Optional hale getirildi
    var mealType: Int
    var foodName: String
    var portion: Double
    var unit: String
    var calories: Double
    var carbs: Double
    var protein: Double
    var fat: Double
}

typealias DietArray = [DietMeal]

struct GetDietsResponse: Codable {
    var getDietsByDietDayIdDtos: [DietMeal]?
    let message: String?
    let success: Bool
}



class DietListModelView : ObservableObject {
    @Published var dietmeals: [DietMeal] = [] // List of exercises
    @Published var errorMessage: String? // To display error messages if any
    @Published var isLoading: Bool = false
    @Published var yenile: Bool = false
    @Published var dietId = 0
    let apiBaseURL = "http://localhost:5200/api/Diets"
    
    
    
    /// Fetch exercises (GET request)
    func fetchDiets(for DietDayId: Int) {
        guard let url = URL(string: "\(apiBaseURL)/GetDietSByDietDayId?dietDayId=\(DietDayId)") else {
            print("Invalid URL")
            return
        }
        
        // Retrieve the JWT token from UserDefaults
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
            if  let jsonString = String(data: data, encoding: .utf8) {
                print("Response JSON: \(jsonString)")
            }
            
            do {
                // Decode the response using `GetExercisesResponse`
                let response = try JSONDecoder().decode(GetDietsResponse.self, from: data)
                
                if response.success {
                    DispatchQueue.main.async {
                        self.dietmeals = response.getDietsByDietDayIdDtos ?? []
                        print(response)
                        self.errorMessage = nil // Clear error message on success
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errorMessage = response.message ?? "An unknown error occurred."
                        print(response)
                       
                        
                    }
                    print("Error message from server: \(response.message ?? "No message")")
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to decode response: \(error.localizedDescription)"
                }
                print("Error decoding response: \(error)")
            }
        }.resume()
    }
    
    
    func addDiets(_ diets: [DietMeal]) {
        guard let url = URL(string: "\(apiBaseURL)/CreateDietList") else {
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
            let jsonData = try JSONEncoder().encode(diets)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                DispatchQueue.main.async { [self] in
                    if let error = error {
                        self?.errorMessage = "Error: \(error.localizedDescription)"
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse else {
                        self?.errorMessage = "Invalid response"
                        return
                    }
                    print(httpResponse.statusCode)
                    if httpResponse.statusCode == 200 {
                        self?.dietmeals.append(contentsOf: diets)
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
    
    
    
    
    func deleteDietMeal(by id: Int) {
        guard let url = URL(string: "http://localhost:5200/api/Diets/DeleteDiet?dietId=\(id)") else {
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

                    self?.dietmeals.removeAll { $0.dietDayId == id }
                    self?.fetchDiets(for: self?.dietId ?? 0)
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
