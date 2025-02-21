//
//  Extension.swift
//  StayFit
//
//  Created by İmat Gökaslan on 1.10.2024.
//

import Foundation

extension Encodable {
    func asDictonary() -> [String:Any]{
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String:Any]
            return json ?? [:]
        }catch{
            return [:]
        }
        
        
    }
}
