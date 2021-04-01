//
//  DirectionCell.swift
//  Swate
//
//  Created by Prateek Arora on 17/11/20.
//  Copyright © 2020 Saurav Garg. All rights reserved.
//

import UIKit

class DirectionCell: UITableViewCell {

    @IBOutlet weak var btnCooked: UIButton!
    @IBOutlet weak var lblData: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
