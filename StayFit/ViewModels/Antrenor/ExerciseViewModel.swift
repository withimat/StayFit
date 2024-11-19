//
//  ExerciseViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 22.11.2024.
//

import Foundation
import Combine
struct Exercise: Codable, Identifiable {
    var id: Int
    var workoutDayId: Int
    var isCompleted: Bool
    var priority: Int
    var name: String
    var description: String
    var setCount: Int
    var repetitionCount: Int
    var durationMinutes: Int
    var exerciseLevel: Int
    var exerciseCategory: Int
}

class ExerciseViewModel: ObservableObject {
    @Published var exercises: [Exercise] = []
    private var cancellables = Set<AnyCancellable>()
    
    func postWorkouts() {
        guard let jwtToken = UserDefaults.standard.string(forKey: "jwt") else {
            print("JWT token bulunamadı.")
            return
        }
        
        let url = URL(string: "https://api.yourbackend.com/workouts")! // API URL'nizi ekleyin
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let data = try JSONEncoder().encode(exercises)
            request.httpBody = data
        } catch {
            print("Veriler JSON'a dönüştürülemedi: \(error.localizedDescription)")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: [Exercise].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("API Hatası: \(error.localizedDescription)")
                case .finished:
                    print("API'ye başarıyla gönderildi.")
                }
            }, receiveValue: { response in
                print("Gelen cevap: \(response)")
            })
            .store(in: &cancellables)
    }
}
