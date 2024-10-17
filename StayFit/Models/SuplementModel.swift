//
//  SuplementModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 9.10.2024.
//

import Foundation

struct Suplement: Codable,Identifiable,Hashable{
    let id : String
    let name: String
    let headline : String
    let description: String
    let link: String
    let image: String
    let fact : [String]
}
