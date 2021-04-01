//
//  VGExtensions.swift
//  VandenGlobal
//
//  Created by Neeraj on 05/12/17.
//  Copyright © 2017 thirtyfourInteractive. All rights reserved.
//

import Foundation
import UIKit


struct Contraint
{
   var left   : CGFloat?
   var right  : CGFloat?
   var top    : CGFloat?
   var bottom : CGFloat?
    
   var width  : CGFloat?
   var height : CGFloat?
}



extension UIView
{
 
    func border(_ width : CGFloat, _ color : UIColor)
    {
        self.layer.borderWidth = width
        
        self.layer.borderColor = color.cgColor
        
        self.layer.masksToBounds = true
    }
    
    func dropShadow(scale: Bool = true)
    {
        /*layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.2
        //layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1*/
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5
    }
    
//    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        layer.mask = mask
//    }
  
    func roundViewTopEdges(radius : CGFloat,color:UIColor) {
      //    self.layer.masksToBounds = true
      if #available(iOS 11.0, *) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.layer.shadowColor = color.cgColor
             self.layer.shadowOpacity = 1
             self.layer.shadowRadius = 15
             self.layer.shadowOffset = CGSize(width: 0, height: -5)
             self.layer.masksToBounds = false
             self.layer.cornerRadius = radius
      } else {
        self.roundCorners(corners: [.bottomRight, .bottomLeft], radius: radius)
      }
    }
    
    func roundViewBottomEdges(radius : CGFloat,color:UIColor) {
      //    self.layer.masksToBounds = true
      if #available(iOS 11.0, *) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.layer.shadowColor = color.cgColor
                 self.layer.shadowOpacity = 1
                 self.layer.shadowRadius = 15
                 self.layer.shadowOffset = CGSize(width: 0, height: -5)
                 self.layer.masksToBounds = false
                 self.layer.cornerRadius = radius
      } else {
        self.roundCorners(corners: [.topLeft, .topRight], radius: radius)
      }
    }
    func roundCorners(corners : UIRectCorner, radius : CGFloat) {
      let rect = self.bounds
      let maskPath = UIBezierPath.init(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize.init(width: radius, height: radius))
      let maskLayer = CAShapeLayer()
      maskLayer.frame = rect
      maskLayer.path = maskPath.cgPath
      self.layer.mask = maskLayer
        
    }
    func roundCornersWithShadow(corners : UIRectCorner, radius : CGFloat, color : UIColor) {
          if #available(iOS 11.0, *) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        self.layer.shadowColor = color.cgColor
                 self.layer.shadowOpacity = 1
                 self.layer.shadowRadius = 5
                 self.layer.shadowOffset = CGSize(width: 0, height: 5)
                 self.layer.masksToBounds = false
                 self.layer.cornerRadius = radius
      } else {
        self.roundCorners(corners: [.topLeft, .bottomLeft], radius: radius)
      }
    }
    func cornersRadiusithShadow(radius : CGFloat, cornerRadius : Double ,color : UIColor) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner,.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
         self.layer.shadowColor = color.cgColor
         self.layer.shadowOffset = CGSize(width: 0, height: 5)
         self.layer.shadowOpacity = 1.0
         self.layer.shadowRadius = radius
         self.layer.masksToBounds =  false
    }
    class func fromNib<T: UIView>() -> T {
      return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
}

extension UIViewController
{
   
    func showAlert(_ title : String,_ message : String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
       // alert.addAction(.init(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(1.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {() -> Void in
            alert.dismiss(animated: true, completion: {() -> Void in
            })
        })

    }
   
   func showAlertWithOkBtn(title:String?,msg:String,onDismiss:(()->Void)!) {
       let alertControler = UIAlertController.init(title:title, message: msg, preferredStyle:.alert)
       alertControler.addAction(UIAlertAction.init(title:"OK", style:.default, handler: { (action) in
           onDismiss()
       }))
       self.present(alertControler,animated:true, completion:nil)
   }
    func showPopupAlertWithAction(viewController: UIViewController,title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated() {
          let action = UIAlertAction(title: title, style: .default,handler: actions[index])
          alert.addAction(action)
          alert.dismiss(animated: false, completion: nil)
        }
        self.present(alert, animated: true, completion: nil)
      }
    
    func addChildWithConstraint(_ child : UIView, _ parent : UIView)
    {
        parent.addSubview(child)
        
        let margins = parent.layoutMarginsGuide
        
        child.translatesAutoresizingMaskIntoConstraints = false
        
        child.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        child.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        child.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        child.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
    }
    
   
    
    
    func addConstraint(_ toView : UIView, with parentView : UIView, _ constraint : Contraint)
    {
        let margins = parentView.layoutMarginsGuide
        
        toView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        toView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        toView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        toView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
    
    }
    
    func showOptions(From vc : UIViewController)
    {
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension String
{
    var asciiArray: [UInt32] {
        return unicodeScalars.filter{$0.isASCII}.map{$0.value}
    }
    
    func isValidEmail() -> Bool
    {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        
        return emailTest.evaluate(with: self)
    }
    
    func isEmpty() -> Bool
    {
        if self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == ""
        {
           return true
        }
        
        return false
    }
    
    func textSize(withHeight height:CGFloat, fontSize fs : CGFloat) -> CGSize
    {
//        let attributes = [NSFontAttributeName : UIFont.init(name: "Neon 80s", size: 12.0)]
//
//        let rect = (self as NSString).boundingRect(with: CGSize.init(width: CGFloat(MAXFLOAT)  , height: height), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil)
        
// return CGSize(width: rect.size.width, height: height) // + 12
        
        
        /*UIFont *font = [UIFont fontWithName:@"Helvetica" size:30];
        NSDictionary *userAttributes = @{NSFontAttributeName: font,
            NSForegroundColorAttributeName: [UIColor blackColor]};
        NSString *text = @"hello";
        ...
        const CGSize textSize = [text sizeWithAttributes: userAttributes];*/
        
        let font = UIFont.init(name: "Neon 80s", size: fs)
        
        let attributes  = [NSAttributedString.Key.font : font]
        
        return (self as NSString).size(withAttributes: attributes as [NSAttributedString.Key : Any])
    }
}


extension Date
{
    func readableDate() -> String
    {
        let df = self.dateFormater("dd/MM/yy")
        
        return df.string(from: self)
    }
    
    func dateFormater(_ datFormat : String) -> DateFormatter
    {
        let formatter = DateFormatter()
        
        formatter.dateFormat = datFormat
        
        return formatter
    }
    
}

//MARK: - CollectionView Layout

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout
{
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]?
    {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }
        
        return attributes
    }
}

//MARK: - TextView

extension UITextView : UITextViewDelegate
{
    
}

extension UIButton
{
    func deselected()
    {
        self.setTitleColor(UIColor.darkGray, for: .normal)
    }
    func selected()
    {
        self.setTitleColor(UIColor.lightGray, for: .normal)
    }
    
    func inFocus(_ focused : Bool)
    {
        let alpha = focused ? 1.0 : 0.6
        
        self.alpha = CGFloat(alpha)
    }
    
    func enable(_ isEnabled : Bool)
    {
        self.isEnabled = isEnabled
        
        self.inFocus(isEnabled)
    }
    
    func buttonTitle() -> String
    {
        var title = ""
        
        if let text = self.titleLabel?.text
        {
            title = text
        }
        
        return title
    }
    
}

//MARK: - Chat Methods

extension String
{
    func toDouble() -> Double? {
        
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    func trimmed() -> String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    

    static func uniqueChatId(_ sender:String, _ receiver : String,forGroup isGroup : Bool) -> String
    {
        if !isGroup
        {
            if Int(sender)! < Int(receiver)!
            {
                return sender + "_" + receiver
            }
            else
            {
                return receiver + "_" + sender
                
            }
        }
        else
        {
            return receiver
        }
        
    }
    
    func replacedotWithComma( _ string : String) -> String{
        let replaced = string.replacingOccurrences(of: ".", with: ",")
        return replaced

    }
    
    func replaceCommaWithDot( _ string : String) -> String{
        let replaced = string.replacingOccurrences(of: ",", with: ".")
        return replaced
        
    }
    
    func replaceCommaWithSpace( _ string : String) -> String{
        let replaced = string.replacingOccurrences(of: "", with: "")
        return replaced
        
    }
    
    func replacedotWithSpace( _ string : String) -> String{
        let replaced = string.replacingOccurrences(of: ".", with: "")
        return replaced
        
    }
    
    func replaceRsSymbol( _ string : String) -> String{
        let replaced = string.replacingOccurrences(of: "R$", with: "")
        return replaced
        
    }
    
    // formatting text for currency textField
    func currencyInputFormatting( _ points :String) -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
       // formatter.decimalSeparator = ","
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, points.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
    func currencyFormatting() -> String {
        if let value = Double(self) {
            let formatter = NumberFormatter()
             formatter.locale = Locale(identifier: "pt_BR")
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 2
            if let str = formatter.string(for: value) {
                return str
            }
        }
        return ""
    }
    func currencyLocalFormatting() -> String {
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "pt_BR")
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 2
            if let str = formatter.string(for: value) {
                return str
            }
        }
        return ""
    }
    
    
}
extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x:(labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y:
                                              (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x:locationOfTouchInLabel.x - textContainerOffset.x,y:
                                                         locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}
extension UITableView {
    
    public func reloadData(_ completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion:{ _ in
            completion()
        })
    }
    
    func scroll(to: scrollsTo, animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            let numberOfSections = self.numberOfSections
            let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
            switch to{
            case .top:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: 0, section: 0)
                    self.scrollToRow(at: indexPath, at: .top, animated: animated)
                }
                break
            case .bottom:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                    self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
                }
                break
            }
        }
    }
    
    enum scrollsTo {
        case top,bottom
    }
}
class TextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}


// Image extension
extension UIImage {
    
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    func updateImageOrientionUpSide() -> UIImage? {
        if self.imageOrientation == .up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        }
        UIGraphicsEndImageContext()
        return nil
    }
}

extension UIView {
    
    @IBInspectable var cornerRadius: Double {
        get {
            return Double(self.layer.cornerRadius)
        }set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    @IBInspectable var borderWidth: Double {
        get {
            return Double(self.layer.borderWidth)
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    @IBInspectable var shadowRadius: Double {
         get {
             return Double(self.layer.cornerRadius)
         }set {
             self.layer.shadowRadius = CGFloat(newValue)
         }
     }
    
    
}
@IBDesignable extension UITextField{

@IBInspectable var setImageName: String {
        get{
            return ""
        }
        set{
            let imageView: UIImageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
            imageView.isUserInteractionEnabled = false
            imageView.image = UIImage(named: newValue)!
            self.rightView = imageView
            self.rightView?.isUserInteractionEnabled = false
            self.rightViewMode = UITextField.ViewMode.always
    }

}
    
}
extension UIImageView {
func applyshadowWithCorner(containerView : UIView, cornerRadious : CGFloat,corners: UIRectCorner){
    containerView.clipsToBounds = false
    containerView.layer.shadowColor = UIColor.black.cgColor
    containerView.layer.shadowOpacity = 1
    containerView.layer.shadowOffset = CGSize.zero
    containerView.layer.shadowRadius = 10
    containerView.layer.cornerRadius = cornerRadious
      let path = UIBezierPath(roundedRect: containerView.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadious, height: cornerRadious))
    containerView.layer.shadowPath = path.cgPath
    self.clipsToBounds = true
   // self.layer.cornerRadius = cornerRadious
    let mask = CAShapeLayer()
           mask.path = path.cgPath
           layer.mask = mask
}
}
