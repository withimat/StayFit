//
//  HeadingView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 10.10.2024.
//

import SwiftUI

struct HeadingView: View {
    @State var color: Color // UIColor yerine Color kullanılmalı
    var headingImage: String
    var headingText: String
    
    var body: some View {
        HStack {
            Image(systemName: headingImage)
                .foregroundColor(color) // Color tipi burada kullanılabilir
                .imageScale(.large)
            Text(headingText)
                .foregroundColor(color)
                .font(.title3)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    HeadingView(color: .black, headingImage: "photo.on.rectangle.angled", headingText: "wilderness in Pictures")
}
