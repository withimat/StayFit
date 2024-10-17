//
//  AntrenorTabView.swift
//  StayFit
//
//  Created by İmat Gökaslan on 19.10.2024.
//

import SwiftUI

struct AntrenorTabView: View {
    var body: some View {
            TabView {
                        AntrenorAnasayfa()
                            .tabItem {
                                Label("Anasayfa", systemImage: "house.fill")
                            }

                        AntrenorProfil()
                            .tabItem {
                                Label("Profil", systemImage: "person.fill")
                            }
                    }
        
    }
}

#Preview {
    AntrenorTabView()
}
