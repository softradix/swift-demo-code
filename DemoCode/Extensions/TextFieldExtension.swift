//
//  TextFieldExtension.swift
//  StepUp
//
//  Created by gomad on 19/11/19.
//  Copyright © 2019 gomad. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    enum PaddingSide {
        case left(CGFloat)
        case right(CGFloat)
        case both(CGFloat)
    }
    
    func addPadding(_ padding: PaddingSide) {
        
        self.leftViewMode = .always
        self.layer.masksToBounds = true
        
        switch padding {
            
        case .left(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = paddingView
            self.rightViewMode = .always
            
        case .right(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always
            
        case .both(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = paddingView
            self.leftViewMode = .always
            // right
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
    
    func setLeftImage(image: UIImage)  {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        imageView.image = image
        view.addSubview(imageView)
        self.leftView = view
        self.leftViewMode = .always
    }
    func setRightImage(image: UIImage)  {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        imageView.image = image
        view.addSubview(imageView)
        self.rightView = view
        self.rightViewMode = .always
    }
    func leftImage(_ image: UIImage?, imageWidth: CGFloat, imageHeight: CGFloat, padding: CGFloat) {
          let imageView = UIImageView(image: image)
          imageView.frame = CGRect(x: padding, y: 0, width: imageWidth, height: frame.height)
          imageView.contentMode = .center
          
          let containerView = UIView(frame: CGRect(x: 0, y: 0, width: imageWidth + 2 * padding, height: imageHeight))
          containerView.addSubview(imageView)
          leftView = containerView
          leftViewMode = .always
      }
    
    func rightImage(_ image: UIImage?, imageWidth: CGFloat, imageHeight: CGFloat, padding: CGFloat) {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let imageView = UIImageView(frame: CGRect(x: 15, y: 5, width: imageWidth, height: imageHeight))
        imageView.image = image
        view.addSubview(imageView)
        self.rightView = view
        self.rightViewMode = .always
        
        self.rightView?.isUserInteractionEnabled = false

      }
    func rightImageDropdown(_ image: UIImage?, imageWidth: CGFloat, imageHeight: CGFloat, padding: CGFloat) {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let imageView = UIImageView(frame: CGRect(x: 15, y: 5, width: imageWidth, height: imageHeight))
        imageView.image = image
        view.addSubview(imageView)
        self.rightView = view
        self.rightViewMode = .always
        
        self.rightView?.isUserInteractionEnabled = false

      }

}
