//
//  PokedexResponseViewModel.swift
//  PokedexUsingAPI
//
//  Created by Débora Juliane Guerra Marques da Silva on 07/01/21.
//

import Foundation

enum PokedexResponse {
    
    case success(model: PokedexModel)
    case serverError(description: ServerErrorModel)
    case timeOut(description: ServerErrorModel)
    case noConnection(description: ServerErrorModel)
    case invalidResponse
}



enum PokemonResponse {
    
    case success(model: PokemonModel)
    case serverError(description: ServerErrorModel)
    case timeOut(description: ServerErrorModel)
    case noConnection(description: ServerErrorModel)
    case invalidResponse
}



enum ImageResponse {
    
    case success(model: Data)
    case serverError(description: ServerErrorModel)
    case timeOut(description: ServerErrorModel)
    case noConnection(description: ServerErrorModel)
    case invalidResponse
}


enum DescriptionResponse {
    
    case success(model: Data)
    case serverError(description: ServerErrorModel)
    case timeOut(description: ServerErrorModel)
    case noConnection(description: ServerErrorModel)
    case invalidResponse
}
