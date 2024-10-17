//
//  VideoListItemView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 13.10.2024.
//

import SwiftUI


import SwiftUI

struct VideoListItemView: View {
    let video: VideoModel
    var body: some View {
        
        HStack(spacing:10) {
            ZStack {
                Image("cover1")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .frame(width: 120,height: 125)
                    .padding(.leading)
                    
                    
                
                Image(systemName: "play.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                    .foregroundColor(.gray.opacity(0.8))
                    .shadow(radius: 6)
                }//: ZSTACK
            
            VStack(alignment:.leading,spacing: 10){
                Text(video.name)
                    .font(.title3)
                    .lineLimit(2)
                    .fontWeight(.heavy)
                    .foregroundColor(Color("acikmavi"))
                    
                
                Text(video.headline)
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .padding(.trailing)
            }//:VSTACK
            
            
        }//:HSTACK
        .background(.black.opacity(0.8))
        .cornerRadius(10)
        .padding()
        
    }
}

#Preview {
    VideoListItemView(video: VideoModel(id: "1", name: "Motivasyon", headline: "Motivasyona İhtiyacın Olduğunda tıkla"))
}
