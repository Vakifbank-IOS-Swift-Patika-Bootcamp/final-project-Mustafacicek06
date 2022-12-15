//
//  GameModel.swift
//  GameRatingApp
//
//  Created by Mustafa Çiçek on 15.12.2022.
//

import Foundation

struct Games: Decodable {
    let results: [GameModel]?
}


struct GameModel: Decodable {
    let id: Int?
    let name, released: String?
    let backgroundImage: String?
    let rating: Double?

    enum CodingKeys: String, CodingKey {
        case backgroundImage = "background_image"
        case id
        case name
        case released
        case rating
    }
}

let mockDatas: [GameModel] = [
    GameModel(id:1 , name: "mustafa", released: "20.20.20",backgroundImage:"img", rating: 2.5),
    GameModel(id:1 , name: "çiçek", released: "20.20.20",backgroundImage:"img", rating: 2.5),
    GameModel(id:1 , name: "yasin", released: "20.20.20",backgroundImage:"img", rating: 2.5),
]
