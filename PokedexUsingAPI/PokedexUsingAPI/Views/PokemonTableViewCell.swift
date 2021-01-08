//
//  PokemonTableViewCell.swift
//  PokedexUsingAPI
//
//  Created by Débora Juliane Guerra Marques da Silva on 07/01/21.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonID: UILabel!
    @IBOutlet weak var pokemonName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
//    func configureCell(withModel model: PokemonModel, pokemonSpriteData data:Data) {
//
//        let id = String(format: "%03d", model.id)
//
//        pokemonImage.image = UIImage(data: data)
//        pokemonID.text = "#\(id)"
//        pokemonName.text = "\(model.name)"
//    }
    
    func configureCell(withModel model: PokemonModel) {
        
        let id = String(format: "%03d", model.id)
        
        pokemonID.text = "#\(id)"
        pokemonName.text = "\(model.name)"
    }

}
