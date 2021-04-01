//
//  RecipeFilterCell.swift
//  Swate
//
//  Created by apple on 25/01/21.
//  Copyright © 2021 Saurav Garg. All rights reserved.
//

import UIKit

class RecipeFilterCell: UITableViewCell {

    @IBOutlet weak var colectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionVW: UICollectionView!
    @IBOutlet weak var lblFilterType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
