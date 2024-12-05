//
//  DietDaysViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 5.12.2024.
//

import Foundation

struct DietPlan: Codable{

    let dietPlanId: Int
    var title: String
    var dayOfWeek: Int
}
struct DietDays: Codable, Identifiable {
    var id: Int
    var title: String
    var dayOfWeek: Int
    var isCompleted: Bool
    var createdDate: String?
    var formattedCreatedDate: String?
    var updatedDate: String?
    var formattedUpdatedDate: String?
}


struct DietDayResponse: Codable {
    let getDietDaysByDietPlanDtos: [DietDays]
    let message: String
    let success: Bool
}



class DietDaysViewModel : ObservableObject {
    @Published var dietPlanId = 0
    @Published var title = ""
    @Published var dayOfWeek: DayOfWeek = .monday
    @Published var isSubmitting = false
    @Published var errorMessage: String?
    @Published var dietDays: [DietDays] = []
    @Published var isLoading = false
   
    // Reset fields
    func resetFields() {
        self.dietPlanId = 0
        self.title = ""
        self.dayOfWeek = .monday
        self.errorMessage = nil
    }

   
   func getDietPlans() {
          guard let url = URL(string: "http://localhost:5200/api/DietDays/GetDietDaysByDietPlanId?dietPlanId=\(dietPlanId)") else {
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
                      let response = try JSONDecoder().decode(DietDayResponse.self, from: data)
                      print(response)
                      if response.success {
                          
                          self?.dietDays = response.getDietDaysByDietPlanDtos
                      } else {
                          self?.errorMessage = response.message
                          
                      }
                  } catch {
                      self?.errorMessage = "Hiç Diyet Planı Yok!!Öğrencin seni bekliyor.."
                  }
              }
          }.resume()
      }
   
   
   
   func deleteDietDay(by id: Int) {
       guard let url = URL(string: "http://localhost:5200/api/DietDays/DeleteDietDay?dietDayId=\(id)") else {
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
                   self?.errorMessage = "diyet silme hatası: \(error.localizedDescription)"
               }
               print("Error deleting diyet day: \(error)")
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
                   self?.dietDays.removeAll { $0.id == id }
                   self?.errorMessage = nil
               }
           } else {
               DispatchQueue.main.async {
                   self?.errorMessage = "Diyet silme başarısız. Durum kodu: \(httpResponse.statusCode)"
               }
           }
       }.resume()
   }

   
   
    // Create workout plan
    func createDietPlan() {
        // API URL
        guard let url = URL(string: "http://localhost:5200/api/DietDays/CreateDietDay") else {
            self.errorMessage = "Invalid URL"
            return
        }

        // Prepare the model
        let workoutPlan = DietPlan(
            dietPlanId: dietPlanId,
            title: title,
            dayOfWeek: dayOfWeek.rawValue
        )

        // Serialize to JSON
        guard let jsonData = try? JSONEncoder().encode(workoutPlan) else {
            self.errorMessage = "Failed to encode data"
            return
        }

        // Retrieve JWT token from UserDefaults
        guard let token = UserDefaults.standard.string(forKey: "jwt") else {
            self.errorMessage = "Missing authentication token"
            return
        }

        // Prepare the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData

        // API Call
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
                        if let data = data, let responseString = String(data: data, encoding: .utf8) {
                            print("Server Response: \(responseString)")
                            self?.errorMessage = "Error: \(responseString)"
                        }
                        return
                    }
                }

                self?.errorMessage = "Diyet planı başarıyla gönderildi!"
            }
        }.resume()
    }
}
