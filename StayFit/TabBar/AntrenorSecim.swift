//
//  AntrenorSecim.swift
//  StayFit
//
//  Created by İmat Gökaslan on 1.11.2024.
//

import SwiftUI
import SwiftUI

struct AntrenorSecim: View {
    @StateObject private var viewModel = AntrenorSecimViewModel()
    @State private var isNavigatingToDetail: Bool = false // Detay sayfasına geçiş kontrolü

    var body: some View {
        VStack {
            if let person = viewModel.person {
                SecilenAntrenorDetaySayfasi(person: person)
            } else {
                Text("Lütfen aşağıdan bir antrenör seçin")
                    .padding()

                Button(action: {
                    viewModel.fetchPerson()  // Antrenör bilgilerini yükler
                }) {
                    Text("Antrenör Seç")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        
                }
            }
        }
        .onAppear {
            viewModel.fetchPerson()  // Sayfa açıldığında antrenör bilgilerini yükler
        }
    }
}

#Preview {
    AntrenorSecim()
}

/*
 
 struct AntrenorSecim: View {


     @State private var person : Person?
     @State private var isNavigatingToList: Bool = false  // Antrenor listesine geçiş kontrolü

     var body: some View {
         VStack {
             if let person = person {
                 Text("Seçilen Antrenör: \(person.firstName) \(person.lastName)")
                     .font(.title)
                     .padding()

                 Button(action: {
                
                 }) {
                     Text("Antrenörü Sil")
                         .foregroundColor(.white)
                         .padding()
                         .background(Color.red)
                         .cornerRadius(10)
                 }
                 .padding()
             } else {
                 Text("Lütfen aşağıdan bir antrenör seçin")
                 Button(action: {
                     isNavigatingToList = true
                 }) {
                 
                     Text("Antrenör Seç")
                         .foregroundColor(.white)
                         .padding()
                         .background(Color.blue)
                         .cornerRadius(10)
                 }
                 .fullScreenCover(isPresented: $isNavigatingToList) {
                     PersonListView()  // AntrenorListesi sayfası
                 }
             }
         }
         .onAppear {
            
         }
     }

     
 }

 
 */
