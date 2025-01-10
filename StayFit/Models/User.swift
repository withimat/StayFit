//
//  User.swift
//  StayFit
//
//  Created by İmat Gökaslan on 1.10.2024.
//

import Foundation
/*
class User: Codable, Identifiable, Hashable {
    var id: String
    var kisiAd: String
    var profileUrl: String?
    var kisiSoyad: String
    var kisiTel: String
    var kisiBoy: Double
    var kisiKilo: Double
    let kisiEmail: String
    
    // Init metodu ile sınıfın özellikleri başlatılıyor
    init(id: String , kisiAd: String, profileUrl: String?, kisiSoyad: String, kisiTel: String, kisiBoy: Double, kisiKilo: Double, kisiEmail: String) {
        self.id = id
        self.kisiAd = kisiAd
        self.profileUrl = profileUrl
        self.kisiSoyad = kisiSoyad
        self.kisiTel = kisiTel
        self.kisiBoy = kisiBoy
        self.kisiKilo = kisiKilo
        self.kisiEmail = kisiEmail
    }
    
    // Hashable protokolü için gerekli fonksiyonlar
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
*/

class registerUser : Codable , Identifiable {
    
}

extension User {
    static var MOCK_USER: [User] = [
        .init(id: "1", kisiAd: "imat", profileUrl: "hoca", kisiSoyad: "GÖKASLAN", kisiTel: "05380354884", kisiBoy: 180, kisiKilo: 80, kisiEmail: "imattgokk@gmail.com"),
        
    ]
}
