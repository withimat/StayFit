//
//  AnimalListItemView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 10.10.2024.
//


import SwiftUI

struct SuplementListItemView: View {
    
    let suplement: Suplement
    var body: some View {
        HStack(alignment:.center, spacing:16) {
            Image(suplement.image)
                .resizable()
                .scaledToFill()
                .frame(width: 90,height: 90)
                .clipShape(
                RoundedRectangle(cornerRadius: 12)
                )
            
            VStack(alignment:.leading,spacing: 8){
                Text(suplement.name)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(.accentColor)
                Text(suplement.headline)
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .padding(.trailing,8)
            }
            
            
        }
    }
}

#Preview {
    
    SuplementListItemView(suplement: Suplement(id: "protein tozu", name: "protein", headline: "acıklama blogu", description: "acıklama", link: "wkmdkdn", image: "protein-tozu", fact: ["1","2"]))
        
}
