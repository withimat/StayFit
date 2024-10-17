//
//  MainViewViewModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 1.10.2024.
//

import Foundation

class MainViewViewModel : ObservableObject {
    @Published var currentUserId : String = ""
    
    init(){}
    
    // kullanıcı login olmuş mu olmamış mı kontrol et
    /*
            DispatchQueue.main.async{
        self?.currentUserId = user?.uid ?? ""
     }
     */
     
    
}
