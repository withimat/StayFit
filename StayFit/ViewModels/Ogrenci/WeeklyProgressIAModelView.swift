//
//  WeeklyProgressIAModelView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 25.11.2024.
//

import Foundation
import UIKit


class WeeklyProgressIAModelView : ObservableObject {
    @Published var subscriptionId: String = ""
    @Published var height: String = ""
    @Published var weight: String = ""
    @Published var selectedImages: [UIImage] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func addImage(_ image: UIImage) {
        selectedImages.append(image)
    }
    
    func resetField() {
        height = ""
        weight = ""
        selectedImages = []
    }
    func removeImage(at index: Int) {
        selectedImages.remove(at: index)
    }
    
    func submitForm() {
        isLoading = true
        errorMessage = nil
        
        guard let url = URL(string: "\(APIConfig.baseURL)/api/WeeklyProgresses/CreateWeeklyProgressByAI") else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        if let token = UserDefaults.standard.string(forKey: "jwt") {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        let parameters: [String: String] = [
            "subscriptionId": subscriptionId,
            "height": height,
            "weight": weight,
        ]
        
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.append("\(value)\r\n")
        }
        
        for (index, image) in selectedImages.enumerated() {
            guard let imageData = image.jpegData(compressionQuality: 0.5) else { continue }
            let filename = "image\(index).jpg"
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"files\"; filename=\"\(filename)\"\r\n")
            body.append("Content-Type: image/jpeg\r\n\r\n")
            body.append(imageData)
            body.append("\r\n")
        }
        
        body.append("--\(boundary)--\r\n")
        
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.errorMessage = "Network Error: \(error.localizedDescription)"
                    return
                }
                
                // HTTP yanıtı
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                    print("HTTP Headers: \(httpResponse.allHeaderFields)")
                }
                
                guard let data = data else {
                    self?.errorMessage = "No data received"
                    return
                }
                
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Raw Response:", responseString)
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                      
                        if let errors = json["errors"] as? [String: [String]] {
                            
                            let errorMessages = errors.flatMap { key, value in
                                value.map { "\(key): \($0)" }
                            }.joined(separator: "\n")
                            self?.errorMessage = errorMessages
                        } else if let message = json["message"] as? String {
                           
                            self?.errorMessage = message
                        } else {
                            
                            self?.errorMessage = "No recognizable message in response"
                        }
                        print("Parsed JSON Response:", json)
                    } else {
                        self?.errorMessage = "Unexpected response format"
                    }
                } catch {
                    self?.errorMessage = "Error parsing response: \(error.localizedDescription)"
                }

            }
        }.resume()

    }

}
