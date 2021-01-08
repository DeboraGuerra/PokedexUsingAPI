//
//  PokemonInfoViewController.swift
//  PokedexUsingAPI
//
//  Created by Débora Juliane Guerra Marques da Silva on 08/01/21.
//

import UIKit

class PokemonInfoViewController: UIViewController {

    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonID: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    var name = ""
    var id = ""
    var image = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonName.text = name
        pokemonID.text = id
        pokemonImage.image = image
    }

}
