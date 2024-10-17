//
//  Bundle.swift
//  StayFit
//
//  Created by İmat Gökaslan on 9.10.2024.
//


import Foundation
extension Bundle{
    func decode<T: Codable>(_ file: String) -> T {
        // 1. Locate the json file
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to located \(file) in bundle. \n hata var 1 numara")
        }
        // 2. create a property for the data
         
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from.\n hata var 2 numara")
        }
        
        // 3. create a decoder
        let decoder = JSONDecoder()
        
        
        // 4. create a property for the decoded data
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.\n hata var 3 numara")
        }
        // 5. return the ready to use data
        return loaded
    }
}
