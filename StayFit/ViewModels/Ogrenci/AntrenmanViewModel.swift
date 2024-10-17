//
//  AntrenmanViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 13.10.2024.
//

import Foundation
class AntrenmanViewModel: ObservableObject {
    @Published var program: [String: Workout] = [
        "Pazartesi": Workout(
            id: "1",
            name: "Göğüs",
            description: "Bench Press, Incline Press, Cable Fly"
        ),
        "Salı": Workout(
            id: "2",
            name: "Bacak",
            description: "Barbell Squat, Leg Press, Lunges"
        ),
        "Çarşamba": Workout(
            id: "3",
            name: "Sırt",
            description: "Pull-Ups, Barbell Row, Lat Pulldown"
        ),
        "Perşembe": Workout(
            id: "4",
            name: "Off Day",
            description: "Dinlenme günü, aktif dinlenme önerilir."
        ),
        "Cuma": Workout(
            id: "5",
            name: "Kol",
            description: "Biceps Curl, Triceps Pushdown, Hammer Curl"
        ),
        "Cumartesi": Workout(
            id: "6",
            name: "Full Body",
            description: "Deadlift, Clean and Jerk, Burpees"
        ),
        "Pazar": Workout(
            id: "7",
            name: "Off Day",
            description: "Dinlenme günü, esneme veya yoga yapabilirsiniz."
        )
    ]
}
