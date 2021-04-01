//
//  ViewExtension.swift
//  StepUp
//
//  Created by gomad on 21/11/19.
//  Copyright © 2019 gomad. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setViewBorder(radius:CGFloat = 2.0, color:UIColor = UIColor.clear, borderWidth: CGFloat = 2.0){
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = true
    }
}
