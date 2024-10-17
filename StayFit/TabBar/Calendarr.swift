//
//  Antrenman.swift
//  StayFit
//
//  Created by İmat Gökaslan on 7.10.2024.
//

import SwiftUI

struct Calendarr : View {
    @ObservedObject var viewmodel = CalendarViewmodel()
    @State var pickerSelect: Bool = true
 
    let daysOfWeek = ["Pazartesi", "Salı", "Çarşamba", "Perşembe", "Cuma", "Cumartesi", "Pazar"]
    @State private var selectedDay: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // Gün adını tam almak için (Pazartesi, Salı, vb.)
        formatter.locale = Locale(identifier: "tr_TR") // Türkçe gün adları için
        return formatter.string(from: Date())
    }()
    
    var body: some View {
        NavigationStack{
            VStack(){
                
                
                
                Picker(selection: $pickerSelect,
                     label: Text("")){
                  Text("Antrenman").tag(true)
                  Text("Diyet").tag(false)
                  
              }.pickerStyle(SegmentedPickerStyle()).padding()
                if pickerSelect {
                    Antrenman()
                }else {
                    Beslenme()
                        
                }
                
                
                
                
                Spacer()
                    
            }
            .navigationTitle("Calendar")
            .toolbarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    Calendarr()
}
