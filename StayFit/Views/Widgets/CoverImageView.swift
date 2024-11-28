//
//  CoverImageView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 8.10.2024.
//

import SwiftUI

struct CoverImageView: View {
    let covers: [String] = ["cover-6", "cover-7-3", "bg-2", "bg-1"]
    
    @State private var currentIndex: Int = 0  // Aktif olan index'i tutar
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(0..<covers.count, id: \.self) { index in
                Image(covers[index])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 390)
                    .tag(index)  // Her görüntüye bir 'tag' verdik
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .onReceive(timer) { _ in
            withAnimation {
                currentIndex = (currentIndex + 1) % covers.count  // Index döngüsü
            }
        }
    }
}

#Preview {
    CoverImageView()
}
