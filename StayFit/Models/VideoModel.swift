//
//  VideoPlayerModel.swift
//  StayFit
//
//  Created by İmat Gökaslan on 11.10.2024.
//

import Foundation
import SwiftUI

struct VideoModel : Codable,Identifiable{
    let id: String
    let name: String
    let headline: String
    
    
    
    //computed property
    var thumbnail:String{
        "\(id)-cover"
    }
}
