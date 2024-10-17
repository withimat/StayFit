//
//  CoverImageView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 8.10.2024.
//

import SwiftUI

struct CoverImageView: View {
    let covers: [String] = ["cover-6", "cover-7", "cover3", "cover4"]
    
    @State private var currentIndex: Int = 0  // Aktif olan index'i tutar
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()  // 3 saniyede bir çalışacak timer
    
    var body: some View {
        TabView(selection: $currentIndex) {  // Seçili sekme için 'selection' kullandık
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
