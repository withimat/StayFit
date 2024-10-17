//  AntrenorListViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 20.10.2024.
//

import Foundation

struct Person : Identifiable, Decodable ,Encodable{
    let id: UUID
    let createdDate: String // String olarak al, UI'de formatla
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
    let photoPath: String?
    let bio: String
    let monthlyRate: Int
    let rate: Int
    let yearsOfExperience: Int
    let birthDate: String // String olarak al, UI'de formatla
    let gender: String
}

import Foundation

class AntrenorListViewModel: ObservableObject {
        @Published var persons: [Person] = []

        init() {
            fetchPersons()
        }

        func fetchPersons() {
            guard let url = URL(string: "http://localhost:5200/api/Trainers/GetAllTrainersIncludeUser") else {
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
    }
