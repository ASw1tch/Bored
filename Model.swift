//
//  Model.swift
//  Bored
//
//  Created by user1 on 20.07.2023.
//

import Foundation

struct APIResponse: Codable {
    let activity: String
    let accessibility: Double
    let type: String
    let participants: Int
    let price: Double
    let link: String
    let key: String
}



