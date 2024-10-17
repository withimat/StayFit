//
//  Trainer.swift
//  StayFit
//
//  Created by İmat Gökaslan on 1.10.2024.
//

import Foundation


class User: Codable, Identifiable, Hashable {
    var id: String
    var kisiAd: String
    var profileUrl: String?
    var kisiSoyad: String
    var kisiTel: String
    var kisiBoy: Double
    var kisiKilo: Double
    let email : String
    
    // Init metodu ile sınıfın özellikleri başlatılıyor
    init(id: String, kisiAd: String, profileUrl: String?, kisiSoyad: String, kisiTel: String, kisiBoy: Double, kisiKilo: Double, kisiEmail: String) {
        self.id = id
        self.kisiAd = kisiAd
        self.profileUrl = profileUrl
        self.kisiSoyad = kisiSoyad
        self.kisiTel = kisiTel
        self.kisiBoy = kisiBoy
        self.kisiKilo = kisiKilo
        self.email = kisiEmail
    }
    
    // Hashable protokolü için gerekli fonksiyonlar
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class Trainer: User {
    var bio: String?
    var monthlyRate: Float?
    var rate: Float?
    var yearsOfExperience: Int?
    var createdDate: String?
    
    // Trainer için gerekli initializer
    init(id: String, kisiAd: String, profileUrl: String?, kisiSoyad: String, kisiTel: String, kisiBoy: Double, kisiKilo: Double, kisiEmail: String, bio: String?, monthlyRate: Float?, rate: Float?, yearsOfExperience: Int?, createdDate: String?) {
        
        // User sınıfının init metodu çağrılıyor
        super.init(id: id, kisiAd: kisiAd, profileUrl: profileUrl, kisiSoyad: kisiSoyad, kisiTel: kisiTel, kisiBoy: kisiBoy, kisiKilo: kisiKilo, kisiEmail: kisiEmail)
        
        // Trainer sınıfına özel özellikler atanıyor
        self.bio = bio
        self.monthlyRate = monthlyRate
        self.rate = rate
        self.yearsOfExperience = yearsOfExperience
        self.createdDate = createdDate
    }

    // Codable protokolü için gerekli initializer
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.bio = try container.decodeIfPresent(String.self, forKey: .bio)
        self.monthlyRate = try container.decodeIfPresent(Float.self, forKey: .monthlyRate)
        self.rate = try container.decodeIfPresent(Float.self, forKey: .rate)
        self.yearsOfExperience = try container.decodeIfPresent(Int.self, forKey: .yearsOfExperience)
        self.createdDate = try container.decodeIfPresent(String.self, forKey: .createdDate)
        
        // User sınıfından özelliklerin decoding işlemi
        try super.init(from: decoder)
    }
    
    // Codable protokolü için gerekli encoding fonksiyonu
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(bio, forKey: .bio)
        try container.encodeIfPresent(monthlyRate, forKey: .monthlyRate)
        try container.encodeIfPresent(rate, forKey: .rate)
        try container.encodeIfPresent(yearsOfExperience, forKey: .yearsOfExperience)
        try container.encodeIfPresent(createdDate, forKey: .createdDate)

        // User sınıfından özelliklerin encoding işlemi
        try super.encode(to: encoder)
    }

    // Codable protokolü için enum tanımı
    enum CodingKeys: String, CodingKey {
        case bio, monthlyRate, rate, yearsOfExperience, createdDate
    }
}


extension Trainer {
    static var MOCK_TRAINERS: [Trainer] = [
        .init(id: "1", kisiAd: "Ahmet", profileUrl: "no1", kisiSoyad: "Yılmaz", kisiTel: "05555555555", kisiBoy: 1.80, kisiKilo: 75.0, kisiEmail: "ahmetyilmaz@example.com", bio: "Deneyimli fitness eğitmeni.", monthlyRate: 150.0, rate: 4.8, yearsOfExperience: 10, createdDate: "2023-01-01"),
        .init(id: "2", kisiAd: "Mehmet", profileUrl: "hoca", kisiSoyad: "Kaya", kisiTel: "05553334444", kisiBoy: 1.85, kisiKilo: 78.0, kisiEmail: "mehmetkaya@example.com", bio: "Uzman pilates hocası.", monthlyRate: 120.0, rate: 4.5, yearsOfExperience: 8, createdDate: "2022-05-01"),
        .init(id: "3", kisiAd: "Ayşe", profileUrl: "logo", kisiSoyad: "Demir", kisiTel: "05554445555", kisiBoy: 1.65, kisiKilo: 60.0, kisiEmail: "aysedemir@example.com", bio: "Yoga eğitmeni.", monthlyRate: 130.0, rate: 4.9, yearsOfExperience: 12, createdDate: "2020-09-15"),
        .init(id: "4", kisiAd: "Elif", profileUrl: "diyet", kisiSoyad: "Çelik", kisiTel: "05556667777", kisiBoy: 1.70, kisiKilo: 65.0, kisiEmail: "elifcelik@example.com", bio: "Kardiyo uzmanı.", monthlyRate: 140.0, rate: 4.7, yearsOfExperience: 6, createdDate: "2021-06-10"),
        .init(id: "5", kisiAd: "Ali", profileUrl: "cover12", kisiSoyad: "Er", kisiTel: "05557778888", kisiBoy: 1.75, kisiKilo: 72.0, kisiEmail: "alier@example.com", bio: "Bodybuilding ve güç antrenörü.", monthlyRate: 160.0, rate: 4.6, yearsOfExperience: 9, createdDate: "2019-11-21")
    ]
}
