//
//  SuplementList.swift
//  StayFit
//
//  Created by İmat Gökaslan on 10.10.2024.
//

import SwiftUI

struct SuplementList: View {
    @Environment(\.dismiss) var dismiss
    let products: [Suplement] = Bundle.main.decode("Suplementler.json")
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "BG")
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "beyaz")!,.font : UIFont(name: "Pacifico-Regular" , size: 22)!]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
    var body: some View {
        NavigationView {
            List(){
                    ForEach(products){product in
                        NavigationLink(destination: SuplementDetailView(animal: product)){
                            SuplementListItemView(suplement: product)
                            
                        }//:link
                        
                        
                    }
                
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
            .navigationTitle("Suplementler")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SuplementList()
}

