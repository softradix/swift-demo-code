//
//  Enumerations.swift
//  StepUp
//
//  Created by gomad on 29/11/19.
//  Copyright © 2019 gomad. All rights reserved.
//

import Foundation
import UIKit

enum APIStatusCode:Int{

    case success      = 200
    case unAuthorized = 401
    case pageNotFound = 404
    case unexpected   = 500
    case imageSuccess = 201

}

enum APIHeaders{

    case accept
    case contentType
    case authorization
    case apiKey
}

enum LinkType {
    case RESOURCE
    case V_LEARNING_MENU_ITEM_1
    case V_LEARNING_MENU_ITEM_2
    case V_LEARNING_MENU_ITEM_3
    case defaultLink
    case seeAlllLink
}


public enum DisplayType {
    case unknown
    case iphone4
    case iphone5
    case iphone6
    case iphone6plus
    static let iphone7 = iphone6
    static let iphone7plus = iphone6plus
    case iphoneX
}

public final class Display {
    class var width:CGFloat { return UIScreen.main.bounds.size.width }
    class var height:CGFloat { return UIScreen.main.bounds.size.height }
    class var maxLength:CGFloat { return max(width, height) }
    class var minLength:CGFloat { return min(width, height) }
    class var zoomed:Bool { return UIScreen.main.nativeScale >= UIScreen.main.scale }
    class var retina:Bool { return UIScreen.main.scale >= 2.0 }
    class var phone:Bool { return UIDevice.current.userInterfaceIdiom == .phone }
    class var pad:Bool { return UIDevice.current.userInterfaceIdiom == .pad }
    class var carplay:Bool { return UIDevice.current.userInterfaceIdiom == .carPlay }
    class var tv:Bool { return UIDevice.current.userInterfaceIdiom == .tv }
    class var typeIsLike:DisplayType {
        if phone && maxLength < 568 {
            return .iphone4
        }
        else if phone && maxLength == 568 {
            return .iphone5
        }
        else if phone && maxLength == 667 {
            return .iphone6
        }
        else if phone && maxLength == 736 {
            return .iphone6plus
        }
        else if phone && maxLength >= 812 {
            return .iphoneX
        }
        return .unknown
    }
}
