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

        guard let url = URL(string: "\(APIConfig.baseURL)/api/WeeklyProgresses/CreateWeeklyProgress") else {
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

                if let rawResponse = String(data: data, encoding: .utf8) {
                    print("Raw Server Response: \(rawResponse)")
                }

                do {
                    if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        // JSON içeriğini işlemek
                        if let errors = jsonObject["errors"] as? [String: [String]] {
                            // Hataları birleştir
                            let errorMessages = errors.values.flatMap { $0 }.joined(separator: "\n")
                            self?.errorMessage = errorMessages
                        } else if let message = jsonObject["message"] as? String {
                            self?.errorMessage = message
                        } else {
                            self?.errorMessage = "Eksik veya hatalı bilgi girdiniz."
                        }
                    } else {
                        self?.errorMessage = "Yanlış formatta bir cevap alındı."
                    }
                } catch {
                    self?.errorMessage = "Error parsing response: \(error.localizedDescription)"
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
