//
//  WeeklyWorkoutPlanViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 22.11.2024.
// 

import Foundation

struct WorkoutPlan: Codable{

    let WorkoutPlanId: Int
    var title: String
    var dayOfWeek: Int
}


struct WorkoutDays: Codable, Identifiable {
    var id: Int
    var title: String
    var dayOfWeek: Int
    var isCompleted: Bool
    var createdDate: String?
    var formattedCreatedDate: String?
    var updatedDate: String?
    var formattedUpdatedDate: String?
}
struct WorkoutDayResponse: Codable {
    let getWorkoutDaysByWorkoutPlanIdDtos: [WorkoutDays]
    let message: String
    let success: Bool
}




class WeeklyWorkoutPlanViewModel: ObservableObject {
     @Published var workoutPlanId = 0
     @Published var title = ""
     @Published var dayOfWeek: DayOfWeek = .monday
     @Published var isSubmitting = false
     @Published var errorMessage: String?
     @Published var workoutDays: [WorkoutDays] = []
     @Published var isLoading = false
     @Published var yenile : Bool = false
   
    
     
     func resetFields() {
         
         self.title = ""
         self.dayOfWeek = .monday
         self.errorMessage = nil
     }

    
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
                       } else {
                           self?.errorMessage = response.message
                           
                       }
                   } catch {
                       self?.errorMessage = "Hiç Egzersiz Yok!!Öğrencin seni bekliyor.."
                   }
               }
           }.resume()
       }
    
    
    
    func deleteWorkoutDay(by id: Int) {
        guard let url = URL(string: "\(APIConfig.baseURL)/api/WorkoutDays/DeleteWorkoutDay/\(id)") else {
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
                DispatchQueue.main.async {
                    // Silinen workout day'i listeden kaldır
                    self?.workoutDays.removeAll { $0.id == id }
                    self?.errorMessage = nil
                }
            } else {
                DispatchQueue.main.async {
                    self?.errorMessage = "Egzersiz silme başarısız. Durum kodu: \(httpResponse.statusCode)"
                }
            }
        }.resume()
    }

    
    
     // Create workout plan
    func createWorkoutPlan() {
       
        guard let url = URL(string: "\(APIConfig.baseURL)/api/WorkoutDays/CreateWorkoutDay") else {
            self.errorMessage = "Invalid URL"
            return
        }

        let workoutPlan = WorkoutPlan(
            WorkoutPlanId: workoutPlanId,
            title: title,
            dayOfWeek: dayOfWeek.rawValue
        )

        guard let jsonData = try? JSONEncoder().encode(workoutPlan) else {
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
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
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
                    if httpResponse.statusCode != 200 {
                        if let data = data {
                            do {
                                // Decode the response to extract the message
                                let responseJSON = try JSONDecoder().decode([String: AnyDecodable].self, from: data)
                                if let message = responseJSON["message"]?.value as? String {
                                    self?.errorMessage = message
                                } else {
                                    self?.errorMessage = "Unknown error occurred."
                                }
                            } catch {
                                self?.errorMessage = "Failed to parse server response."
                            }
                        }
                        return
                    }
                }

                self?.errorMessage = "Antrenman Planı başarıyla gönderildi!"
               
                
            }
        }.resume()
    }
    
    
    // Complete workout day
    func completeWorkoutDay(workoutDayId2: Int) {
            guard let url = URL(string: "\(APIConfig.baseURL)/api/WorkoutDays/WorkoutDayCompleted?workoutDayId=\(workoutDayId2)") else {
                DispatchQueue.main.async {
                    self.errorMessage = "Invalid URL"
                }
                return
            }

            guard let token = UserDefaults.standard.string(forKey: "jwt") else {
                DispatchQueue.main.async {
                    self.errorMessage = "Missing authentication token"
                }
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
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
                        if httpResponse.statusCode == 200 {
                            self?.errorMessage = "Tebrikler!! Bugünü tamamladınız..."
                            print(self!.errorMessage ??  "success ama baska bir yazı")
                           
                        } else {
                            if let data = data {
                                do {
                                    let responseJSON = try JSONDecoder().decode([String: String].self, from: data)
                                    if let message = responseJSON["message"] {
                                        self?.errorMessage = message
                                    } else {
                                        self?.errorMessage = "Unknown error occurred."
                                    }
                                } catch {
                                    self?.errorMessage = "Sadece o günün programının tamamlandı butonuna tıklayabilirsin."
                                }
                            } else {
                                self?.errorMessage = "Server returned status code \(httpResponse.statusCode)."
                            }
                        }
                    }
                }
            }.resume()
        }

 }

enum DayOfWeek: Int, Codable, CaseIterable {
    case monday = 1
    case tuesday = 2
    case wednesday = 3
    case thursday = 4
    case friday = 5
    case saturday = 6
    case sunday = 0

    var displayName: String {
        switch self {
        case .sunday: return "Pazar"
        case .monday: return "Pazartesi"
        case .tuesday: return "Salı"
        case .wednesday: return "Çarşamba"
        case .thursday: return "Perşembe"
        case .friday: return "Cuma"
        case .saturday: return "Cumartesi"
        }
    }
    
    /// Pazartesi bazlı sıralama
    var sortOrder: Int {
        switch self {
        case .monday: return 0
        case .tuesday: return 1
        case .wednesday: return 2
        case .thursday: return 3
        case .friday: return 4
        case .saturday: return 5
        case .sunday: return 6
        }
    }
}



import Foundation

struct AnyDecodable: Decodable {
    let value: Any

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            value = intValue
        } else if let doubleValue = try? container.decode(Double.self) {
            value = doubleValue
        } else if let stringValue = try? container.decode(String.self) {
            value = stringValue
        } else if let boolValue = try? container.decode(Bool.self) {
            value = boolValue
        } else {
            throw DecodingError.typeMismatch(
                AnyDecodable.self,
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Unsupported type"
                )
            )
        }
    }
}
