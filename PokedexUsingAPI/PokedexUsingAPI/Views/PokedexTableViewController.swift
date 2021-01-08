//
//  PokedexTableViewController.swift
//  PokedexUsingAPI
//
//  Created by Débora Juliane Guerra Marques da Silva on 07/01/21.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    var pokedexRequest: PokedexResquestViewModel = PokedexResquestViewModel()
    var resultPokedexModel: PokedexModel?
    var resultCount = 0
    var pokemons = [PokemonModel]()
    var pokemonImages = [Data]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func loadPokedex(url: String?) {
        
        pokedexRequest.getAllPokemons(url: url) { (response) in
            
            switch response {
            
                case .success(let model):
                    self.resultPokedexModel = model
                    self.loadPokemon(self.resultCount+1)
                    self.resultCount += model.results
                
                case .serverError(let description):
                    print(description)
             
                case .timeOut(let description):
                    print(description)
             
                case .noConnection(let description):
                    print(description)
          
                case .invalidResponse:
                    print("Invalid Response")
            }
        }
    }
    
    
    func loadPokemon(_ id: Int) {
      
        pokedexRequest.getPokemon(id: id) { (response) in
        
            switch response {
              
                case .success(let model):
                    self.pokemons.append(model)
                    self.loadImagePokemon(url: model.urlImage)
              
                case .serverError(let description):
                    print(description)
              
                case .timeOut(let description):
                    print(description)
              
                case .noConnection(let description):
                    print(description)
            
                case .invalidResponse:
                    print("Invalid Response")
            }
        }
    }
    
    
    func loadImagePokemon(url: String) {
        
        pokedexRequest.getPokemonImage(url: url) { (response) in
        
            switch response {
            
                case .success(let model):
                    self.pokemonImages.append(model)
                    self.pokemons.last!.id < self.resultCount ?
                    self.loadPokemon(self.pokemons.last!.id + 1) : self.tableView.reloadData()
              
                case .noConnection(let description):
                    print(description)
              
                case .serverError(let description):
                    print(description)
              
                case .timeOut(let description):
                    print(description)
            
                case .invalidResponse:
                    print("Invalid Response")
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return resultPokedexModel?.next == "" ? resultCount : resultCount + 1
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == resultCount {
            loadPokedex(url:resultPokedexModel?.next)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        if indexPath.row == resultCount {
            guard let cellLoad =    tableView.dequeueReusableCell(withIdentifier: "loadCell", for: indexPath) as? LoadTableViewCell
            else {
                    
                return tableView.dequeueReusableCell(withIdentifier: "emptyCell", for: indexPath)
            }
        
            cellLoad.loadActivity.startAnimating()
        
            return cellLoad
        }
      
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PokemonTableViewCell else {
        
            return tableView.dequeueReusableCell(withIdentifier: "emptyCell", for: indexPath)
        }
        
//        cell.configureCell(withModel: pokemons[indexPath.row], pokemonSpriteData: pokemonImages[indexPath.row])
        cell.configureCell(withModel: pokemons[indexPath.row])
      
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController = storyboard?.instantiateViewController(identifier: "pokemonInfo") as? PokemonInfoViewController
        let id = String(format: "%03d", pokemons[indexPath.row].id)
        
        viewController?.name = pokemons[indexPath.row].name
        viewController?.id = "#\(id)"
        viewController?.image = UIImage(data: pokemonImages[indexPath.row])!
        
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
}
