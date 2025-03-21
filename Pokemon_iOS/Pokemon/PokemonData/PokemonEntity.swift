//
//  PokemonEntity.swift
//  Pokemon
//
//  Created by 宮田彩花 on 2025/03/14.
//

import Foundation

@MainActor
struct PokemonEntity: Decodable, Identifiable {
    
    let name: String
    let id: Int
    let types: [Types]
    
    let sprites: Images
    
    struct Images: Codable  {
        let frontdefault: String
        let frontshiny: String
        
        enum CodingKeys: String, CodingKey {
            
            case frontdefault = "front_default"
            case frontshiny = "front_shiny"
        }
    }
    
    struct Types: Codable {
        let type: `Type`
    }
    
    struct `Type`: Codable {
        let name: String
    }
}
