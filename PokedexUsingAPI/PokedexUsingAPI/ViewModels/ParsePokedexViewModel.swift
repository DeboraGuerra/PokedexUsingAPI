//
//  ParsePokedexViewModel.swift
//  PokedexUsingAPI
//
//  Created by Débora Juliane Guerra Marques da Silva on 07/01/21.
//

import Foundation

class ParsePokedexViewModel {
    
    func parseAllPokedex(response: [String: Any]?) -> PokedexModel {
        
        // unwrap do dicionário enviado pelo request
        guard let response = response else {
            // caso for nulo, cria model vazio
            return PokedexModel()
        }
        
        // atribui os valores do dicionário a variáveis
        let count = response["count"] as? Int ?? 0
        let next = response["next"] as? String ?? ""
        let previous = response["previous"] as? String ?? ""
        
        //pega a quantidade de filhos do array
        let resultList = response["results"] as? [[String: Any]] ?? []
        let results = resultList.count
        
        var pokedex = PokedexModel()
        pokedex.count = count
        pokedex.next = next
        pokedex.previous = previous
        pokedex.results = results
        
        return pokedex
    }
    
    
    func parsePokemon(response: [String: Any]?) -> PokemonModel {
        
        guard let response = response else {
            return PokemonModel()
        }
        
        let id = response["id"] as? Int ?? 0
        let name = response["name"] as? String ?? ""
        let sprites = response["sprites"] as? [String: Any]
        let urlImage = sprites?["front_default"] as? String ?? ""
        
        var pokemon = PokemonModel()
        pokemon.id = id
        pokemon.name = name
        pokemon.urlImage = urlImage
        
        return pokemon
    }
}
