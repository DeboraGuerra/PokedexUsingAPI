//
//  PokemonModel.swift
//  PokedexUsingAPI
//
//  Created by Débora Juliane Guerra Marques da Silva on 07/01/21.
//

import Foundation

struct PokemonModel {
    
    var id: Int
    var name: String
    var urlImage: String
    var type: [String]

    init() {
        self.id = 0
        self.name = ""
        self.urlImage = ""
        self.type = ["",""]
    }
}
