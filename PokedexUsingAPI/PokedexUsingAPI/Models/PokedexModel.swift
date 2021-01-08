//
//  PokedexModel.swift
//  PokedexUsingAPI
//
//  Created by Débora Juliane Guerra Marques da Silva on 07/01/21.
//

import Foundation

struct PokedexModel {
    
    var count: Int
    var next: String
    var previous: String
    var results: Int
    
    init() {
        self.count = 0
        self.next = ""
        self.previous = ""
        self.results = 0
    }
}
