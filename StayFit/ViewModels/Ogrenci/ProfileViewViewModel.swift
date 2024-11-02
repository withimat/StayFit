//
//  ProfileViewViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 1.10.2024.
//

import Foundation

struct UserProfile : Codable {
    var id: String
    var createdDate: String
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
    var photoPath: String?
    var height: Int
    var weight: Int
    var birthDate: String
    var gender: String
}



class ProfileViewViewModel : ObservableObject{
    @Published var userProfile: UserProfile?

        func fetchUserProfile() {
            guard let token = UserDefaults.standard.string(forKey: "jwt") else {
                print("Token bulunamadı")
                return
            }


            guard let url = URL(string: "http://localhost:5200/api/Members/GetMemberProfile") else {
                print("Geçersiz URL")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")


            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                if let error = error {
                    print("İstek hatası: \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    print("Veri bulunamadı")
                    return
                }


                do {
                    let profile = try JSONDecoder().decode(UserProfile.self, from: data)
                    DispatchQueue.main.async {
                        self?.userProfile = profile
                    }
                } catch {
                    print("JSON çözümleme hatası: \(error.localizedDescription)")
                }
            }.resume()
        }

}

