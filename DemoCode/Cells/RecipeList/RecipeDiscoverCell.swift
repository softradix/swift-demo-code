//
//  RecipeDiscoverCell.swift
//  Swate
//
//  Created by Prateek Arora on 16/11/20.
//  Copyright © 2020 Saurav Garg. All rights reserved.
//

import UIKit

class RecipeDiscoverCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var vwFav: UIView!
    @IBOutlet weak var lblIngredients: UILabel!
    @IBOutlet weak var btnStar: UIButton!
    @IBOutlet weak var lblFoodTitle: UILabel!
    @IBOutlet weak var imgFood: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //imgFood.cornersRadiusithShadow(radius: 24, cornerRadius: 24 ,color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.25))
       // vwFav.roundCorners(corners: [.topLeft, .bottomLeft], radius: 25)

        vwFav.roundCornersWithShadow(corners: [.topLeft, .bottomLeft], radius: 25, color: .clear)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
