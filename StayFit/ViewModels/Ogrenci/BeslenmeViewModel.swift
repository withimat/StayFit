//
//  BeslenmeViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 12.10.2024.
//

import Foundation

import SwiftUI


class BeslenmeViewModel: ObservableObject {
    
    // Günlere göre öğünleri tutan sözlük
    @Published var program: [String: [Meal]] = [
        "Pazartesi": [
            Meal(id: "1", name: "Kahvaltı", description: "Yulaf ezmesi ve taze meyveler"),
            Meal(id: "2", name: "Ara Öğün", description: "Badem ve ceviz"),
            Meal(id: "3", name: "Öğle Yemeği", description: "Izgara tavuk ve bulgur pilavı"),
            Meal(id: "4", name: "Akşam Yemeği", description: "Sebze çorbası ve yoğurt"),
            Meal(id: "4", name: "Akşam Yemeği", description: "Sebze çorbası ve yoğurt")
        ],
        "Salı": [
            Meal(id: "5", name: "Kahvaltı", description: "Tam buğday ekmeği ve omlet"),
            Meal(id: "6", name: "Ara Öğün", description: "Muz ve fıstık ezmesi"),
            Meal(id: "7", name: "Öğle Yemeği", description: "Fırında balık ve salata"),
            Meal(id: "8", name: "Akşam Yemeği", description: "Mercimek çorbası ve peynir")
        ],
        "Çarşamba": [
            Meal(id: "9", name: "Kahvaltı", description: "Simit ve beyaz peynir"),
            Meal(id: "10", name: "Ara Öğün", description: "Havuç ve humus"),
            Meal(id: "11", name: "Öğle Yemeği", description: "Kısır ve yoğurt"),
            Meal(id: "12", name: "Akşam Yemeği", description: "Tavuk şiş ve sebze")
        ],
        "Perşembe": [
            Meal(id: "13", name: "Kahvaltı", description: "Chia puding ve meyveler"),
            Meal(id: "14", name: "Ara Öğün", description: "Kuru kayısı ve ceviz"),
            Meal(id: "15", name: "Öğle Yemeği", description: "Sebzeli kinoa salatası"),
            Meal(id: "16", name: "Akşam Yemeği", description: "Fırında sebze ve tofu")
        ],
        "Cuma": [
            Meal(id: "17", name: "Kahvaltı", description: "Süzme yoğurt ve granola"),
            Meal(id: "18", name: "Ara Öğün", description: "Elma ve fıstık ezmesi"),
            Meal(id: "19", name: "Öğle Yemeği", description: "Izgara köfte ve pilav"),
            Meal(id: "20", name: "Akşam Yemeği", description: "Makarna ve domates sosu")
        ],
        "Cumartesi": [
            Meal(id: "21", name: "Kahvaltı", description: "Pankek ve maple şurubu"),
            Meal(id: "22", name: "Ara Öğün", description: "Meyve salatası"),
            Meal(id: "23", name: "Öğle Yemeği", description: "Tavuk Caesar salata"),
            Meal(id: "24", name: "Akşam Yemeği", description: "Balık köftesi ve sebze")
        ],
        "Pazar": [
            Meal(id: "25", name: "Kahvaltı", description: "Yumurta ve avokado tostu"),
            Meal(id: "26", name: "Ara Öğün", description: "Ceviz ve kuru üzüm"),
            Meal(id: "27", name: "Öğle Yemeği", description: "Sebzeli makarna"),
            Meal(id: "28", name: "Akşam Yemeği", description: "Fırında somon ve brokoli")
        ]
    ]
}
