//
//  diyet.swift
//  StayFit
//
//  Created by İmat Gökaslan on 12.10.2024.
//
import Foundation

class Meal: Identifiable {
    var id : String?             // Benzersiz ID
    var name: String?             // Öğün adı (Örn: Kahvaltı, Öğle Yemeği)
    var description: String?     // Öğün açıklaması (isteğe bağlı)

    init(id: String,name: String, description: String? = nil) {
        self.name = name
        self.description = description
    }
}


