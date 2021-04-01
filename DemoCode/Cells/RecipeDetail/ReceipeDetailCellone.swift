//
//  ReceipeDetailCellone.swift
//  Swate
//
//  Created by Prateek Arora on 17/11/20.
//  Copyright © 2020 Saurav Garg. All rights reserved.
//

import UIKit

protocol DetailsDelegates : class{
    func plusActionPerformed()
    func minusActionPerformed()
}
class ReceipeDetailCellone: UITableViewCell {
    @IBOutlet weak var topImg: UIImageView!
    @IBOutlet weak var vwServing: UIView!
    @IBOutlet weak var lblMealtype: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblVegname: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var lblServing: UILabel!
    @IBOutlet weak var btnStar: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    
    weak var delegates : DetailsDelegates!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblVegname.adjustsFontSizeToFitWidth = true
        lblVegname.minimumScaleFactor = 0.2
        topImg.roundViewBottomEdges(radius: 50, color: .gray)
        topImg.clipsToBounds = true
        vwServing.roundCornersWithShadow(corners: [.topLeft, .bottomLeft], radius: 50,color: UIColor.init(red: 18/255.0, green: 21/255.0, blue: 61/255.0, alpha: 0.2))
        //vwServing.roundViewBottomEdges(radius: 50, color: .gray)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        }
    
    
    @IBAction func plusTapped( _ sender : UIButton){
        self.delegates.plusActionPerformed()
    }
    
    @IBAction func minusTapped( _ sender : UIButton){
        self.delegates.minusActionPerformed()
    }
}
