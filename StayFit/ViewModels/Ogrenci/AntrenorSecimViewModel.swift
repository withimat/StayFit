//
//  AntrenorSecimViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 2.11.2024.
//

import Foundation

import SwiftUI
import Combine

class GelenAntrenor: Codable, Identifiable {
    var subscriptionId: String
    var trainerId: String
    var firstName: String
    var lastName: String
    var amount: Int          
    var endDate: String
    var photoPath: String?
    
    enum CodingKeys: String, CodingKey {
        case subscriptionId = "subscriptionId"
        case trainerId = "trainerId"
        case firstName = "firstName"
        case lastName = "lastName"
        case amount = "amount"
        case endDate = "endDate"
        case photoPath = "photoPath"
    }
}


class AntrenorSecimViewModel: ObservableObject {
    @Published var person: GelenAntrenor? = nil
    
    init() {
        fetchPerson()
    }

    // Person verisini API'den çekme fonksiyonu
    func fetchPerson() {
        // UserDefaults üzerinden tokeni alıyoruz
        guard let token = UserDefaults.standard.string(forKey: "jwt") else {
            print("Token bulunamadı.")
            return
        }

        guard let url = URL(string: "http://localhost:5200/api/Subscriptions/GetMemberSubscribedTrainer") else {
            print("Geçersiz URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("İstek hatası: \(error)")
                return
            }

            guard let data = data else {
                print("Boş veri döndü.")
                return
            }

            // JSON verisini kontrol etmek için ekledik
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Sunucudan dönen JSON: \(jsonString)")
            }

            do {
                let decoder = JSONDecoder()
                let fetchedPerson = try decoder.decode(GelenAntrenor.self, from: data)
                DispatchQueue.main.async {
                    self?.person = fetchedPerson
                }
            } catch {
                print("Veri çözümleme hatası: \(error)")
            }
        }.resume()
    }

 
}
