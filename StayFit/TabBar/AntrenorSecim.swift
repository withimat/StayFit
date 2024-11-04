//
//  AntrenorSecim.swift
//  StayFit
//
//  Created by İmat Gökaslan on 1.11.2024.
//

import SwiftUI
import SwiftUI
struct AntrenorSecim: View {
    @ObservedObject var viewmodel = AntrenorSecimViewModel()
    @State private var isNavigatingToList: Bool = false  // Antrenor listesine geçiş kontrolü

    var body: some View {
        VStack {
            if let person = viewmodel.person {
               SecilenAntrenorDetaySayfasi(person: person)

                
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
                    AntrenorListesiSayfasi()  // AntrenorListesi sayfası
                }
            }
        }
        .onAppear {
           
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
