//
//  AntrenorAnasayfaViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 1.11.2024.
//

import Foundation

struct Student: Identifiable, Decodable {
    let id: String
    let memberId: String
    let endDate: String
    let amount: Int
    let height: Int
    let weight: Int
    let firstName: String
    let lastName: String
    let gender: Int
    let birthDate: String
}

class AntrenorAnasayfaViewModel : ObservableObject {
    @Published var students: [Student] = []

        func fetchStudents() {
            guard let token = UserDefaults.standard.string(forKey: "jwt") else {
                print("Token bulunamadı.")
                return
            }

            guard let url = URL(string: "http://localhost:5200/api/Subscriptions/GetTrainerSubscribers") else {
                print("Geçersiz URL")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("İstek hatası: \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    print("Boş veri döndü.")
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let decodedStudents = try decoder.decode([Student].self, from: data)

                    DispatchQueue.main.async {
                        self.students = decodedStudents
                    }
                } catch {
                    print("Veri çözümleme hatası: \(error)")
                }
            }

            task.resume()
        }
    }
