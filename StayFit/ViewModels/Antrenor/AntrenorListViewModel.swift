//  AntrenorListViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 20.10.2024.
//

import Foundation

struct Person: Identifiable, Decodable ,Encodable{
    var id: String
    var createdDate: String // String olarak al, UI'de formatla
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
    var photoPath: String?
    var bio: String
    var monthlyRate: Int
    var rate: Int
    var yearsOfExperience: Int
    var birthDate: String // String olarak al, UI'de formatla
    var gender: String
}

class AntrenorListViewModel: ObservableObject {
    @Published var persons: [Person] = []
    @Published var goal = ""
    init() {
        fetchPersons()
    }

    func fetchPersons() {
        guard let url = URL(string: "\(APIConfig.baseURL)/api/Trainers/GetAllTrainersIncludeUser") else {
            print("Geçersiz URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("İstek hatası: \(error)")
                return
            }

            guard let data = data else {
                print("Boş veri döndü.")
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedPersons = try decoder.decode([Person].self, from: data)

                DispatchQueue.main.async {
                    self.persons = decodedPersons
                }
            } catch {
                print("Veri çözümleme hatası: \(error)")
            }
        }

        task.resume()
    }
    
    func sendSubscriptionRequest(personID: String,goal:String) {
        guard let token = UserDefaults.standard.string(forKey: "jwt") else {
            print("Token bulunamadı.")
            return
        }

        guard let url = URL(string: "\(APIConfig.baseURL)/api/Subscriptions/CreateSubscription?trainerId=\(personID)&goal=\(goal)") else {
            print("Geçersiz URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("İstek hatası: \(error.localizedDescription)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Durum Kodu: \(httpResponse.statusCode)")
            }

            if let data = data {
                let responseString = String(data: data, encoding: .utf8)
                print("Dönen veri: \(responseString ?? "Veri yok")")
            }
        }

        task.resume()
    }
}
