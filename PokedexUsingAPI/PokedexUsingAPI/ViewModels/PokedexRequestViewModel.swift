//
//  PokedexRequestViewModel.swift
//  PokedexUsingAPI
//
//  Created by Débora Juliane Guerra Marques da Silva on 07/01/21.
//

import Foundation
import Alamofire

struct PokemonAPIURL {
    static let main: String = "http://pokeapi.co/api/v2/pokemon/"
}

class PokedexResquestViewModel {
    
    let alamofireManager: SessionManager = {
        
        let configuration = URLSessionConfiguration.default
        
        configuration.timeoutIntervalForRequest = 10000
        configuration.timeoutIntervalForResource = 10000
        
        return SessionManager(configuration: configuration)
    }()
    
    let parse: ParsePokedexViewModel = ParsePokedexViewModel()
    
    
    func getAllPokemons(url:String?, completion:@escaping (_ response: PokedexResponse) -> Void) {
        
        // se a url for vazia, será atribuída a url main
        let page = url == "" || url == nil ? PokemonAPIURL.main : url ?? ""
        
        alamofireManager.request(page, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            
            let statusCode = response.response?.statusCode
            switch response.result {
                
                case .success(let value):
                    
                    let resultValue = value as? [String: Any]
                
                    if statusCode == 404 {
                        if let description = resultValue?["detail"] as? String
                        {
                            let error = ServerErrorModel(msgError: description, statusCode: statusCode!)
                            completion(.serverError(description: error))
                        }
                    
                    } else if statusCode == 200 {
                        let model = self.parse.parseAllPokedex(response: resultValue)
                        completion(.success(model: model))
                    }
                    
                case .failure(let error):
                    
                    let errorCode = error._code
                    
                    if errorCode == -1009 {
                        let erro = ServerErrorModel(msgError: error.localizedDescription, statusCode: errorCode)
                        completion(.noConnection(description: erro))
                    
                    } else if errorCode == -1001 {
                        let erro = ServerErrorModel(msgError: error.localizedDescription, statusCode: errorCode)
                        completion(.timeOut(description: erro))
                    }
            }
        }
    }
    
    
    func getPokemon(id:Int, completion:@escaping (_ response: PokemonResponse) -> Void) {
     
      alamofireManager.request("\(PokemonAPIURL.main)\(id)/", method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
        
        let statusCode = response.response?.statusCode
        
        switch response.result {
          
            case .success(let value):
                
                let resultValue = value as? [String: Any]
                
                if statusCode == 404 {
                  
                    if let description = resultValue?["detail"] as? String {
                        
                        let error = ServerErrorModel(msgError: description, statusCode: statusCode!)
                        completion(.serverError(description: error))
                    }
                
                } else if statusCode == 200 {
                    
                  // parse dos pokemons
                  let model = self.parse.parsePokemon(response: resultValue)
                  completion(.success(model: model))
                }
                
          case .failure(let error):
            
            let errorCode = error._code
            
            if errorCode == -1009 {
                let erro = ServerErrorModel(msgError: error.localizedDescription, statusCode: errorCode)
                completion(.noConnection(description: erro))
            }
            
            else if errorCode == -1001 {
                let erro = ServerErrorModel(msgError: error.localizedDescription, statusCode: errorCode)
                completion(.timeOut(description: erro))
            }
        }
      }
    }

    
    func getPokemonImage(url:String, completion:@escaping (_ response: ImageResponse) -> Void) {
      
        // responseData devolve um objeto Data em caso de sucesso
        alamofireManager.request(url, method: .get).responseData { (response) in
            if response.response?.statusCode == 200 {
              
               guard let data = response.data else {
                
                    let erro = ServerErrorModel(msgError: "Empty Data", statusCode: 404)
                    completion(.serverError(description: erro))
                    return
               }
              
              completion(.success(model: data))
            } else {
                
                let erro = ServerErrorModel(msgError: "Empty Data", statusCode: 404)
                completion(.serverError(description: erro))
            }
        }
    }
}
