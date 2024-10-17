//
//  Lottie.swift
//  StayFit
//
//  Created by İmat Gökaslan on 6.10.2024.
//


import Foundation
import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var animationUrl: URL
    
    let animationView = LottieAnimationView()
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        
        // İlk olarak boş bir Lottie view oluşturulur
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        
        // URL'den animasyonu indir
        downloadAnimation(from: animationUrl)
        
        // Lottie animasyonu eklenir
        view.addSubview(animationView)
        
        // Auto Layout
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Burada güncelleme yapılmasına gerek yok
    }
    
    // URL'den JSON verisini indirip animasyonu başlatma fonksiyonu
    func downloadAnimation(from url: URL) {
        // URLSession ile veriyi indiriyoruz
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Veri indirme hatası: \(String(describing: error))")
                return
            }
            
            do {
                // Lottie animasyonunu veriden yüklüyoruz
                let animation = try LottieAnimation.from(data: data)
                DispatchQueue.main.async {
                    animationView.animation = animation
                    animationView.play()
                }
            } catch {
                print("Animasyon yükleme hatası: \(error)")
            }
        }.resume()
    }
}
