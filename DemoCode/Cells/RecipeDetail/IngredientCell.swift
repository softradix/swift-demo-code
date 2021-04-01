//
//  IngredientCell.swift
//  Swate
//
//  Created by Prateek Arora on 17/11/20.
//  Copyright © 2020 Saurav Garg. All rights reserved.
//

import UIKit

class IngredientCell: UITableViewCell {

    @IBOutlet weak var lblFoodname: UILabel!
    @IBOutlet weak var vwBottom: UIView!
    @IBOutlet weak var chkMarkImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
