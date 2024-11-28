//
//  WeeklyProgressesModelView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 25.11.2024.
//

import Foundation
import UIKit
// MARK: - Model


// MARK: - ViewModel
class WeeklyProgressViewModel: ObservableObject {
    @Published var subscriptionId: String = ""
    @Published var height: String = ""
    @Published var weight: String = ""
    @Published var fat: String = ""
    @Published var bmi: String = ""
    @Published var waistCircumference: String = ""
    @Published var neckCircumference: String = ""
    @Published var chestCircumference: String = ""
    @Published var selectedImages: [UIImage] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func addImage(_ image: UIImage) {
        selectedImages.append(image)
    }
    
    func removeImage(at index: Int) {
        selectedImages.remove(at: index)
    }
    
    func submitForm() {
        isLoading = true
        errorMessage = nil
        
        guard let url = URL(string: "http://localhost:5200/api/WeeklyProgresses/CreateWeeklyProgress") else {
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
        
        // Eklenecek text parametreler
        let parameters: [String: String] = [
            "subscriptionId": subscriptionId,
            "height": height,
            "weight": weight,
            "fat": fat,
            "bmi": bmi,
            "waistCircumference": waistCircumference,
            "neckCircumference": neckCircumference,
            "chestCircumference": chestCircumference
        ]
        
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.append("\(value)\r\n")
        }
        
        // Görselleri ekleme
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
                
                guard let data = data else {
                    self?.errorMessage = "No data received"
                    return
                }
                
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Raw Response:", responseString)
                    
                    // JSON'dan mesaj öğesini ve hata mesajlarını ayıkla
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            if let errorMessage = json["error"] as? [String: Any],
                               let errorDetail = errorMessage["message"] as? String {
                                // Error içindeki mesaj
                                self?.errorMessage = errorDetail
                            } else if let message = json["message"] as? String {
                                // Genel mesaj
                                self?.errorMessage = message
                            } else {
                                self?.errorMessage = "Eksik veya Hatalı Bilgi Girdiniz.."
                            }
                        } else {
                            self?.errorMessage = "Yanlış Formatta Bilgi Yollandı"
                        }
                    } catch {
                        self?.errorMessage = "Error parsing response: \(error.localizedDescription)"
                    }
                }
            }
        }.resume()

    }

}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
