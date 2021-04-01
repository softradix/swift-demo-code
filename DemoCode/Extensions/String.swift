//
//  String.swift
//  StepUp
//
//  Created by gomad on 25/11/19.
//  Copyright © 2019 gomad. All rights reserved.
//

import Foundation
import UIKit

enum DaysLabels : String {
    case useSoon = "Use Soon"
    case immediatley = "Use Immediately"
    case fresh = "Fresh"
}

extension String{
    
    public func toPhoneNumber() -> String {
        return self.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: nil)
    }
    
    // This function will remove whitespace
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    func removingWhitespacesSeprated() -> [String] {
        return components(separatedBy: .whitespaces)
    }
    
    // This function will check that the email id is valid or not
//    func isValidEmail() -> Bool {
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return emailTest.evaluate(with: self)
//    }

    func isValidPassword() -> Bool {
        return self.length >= 8
    }
    
    var length:Int{
            
        return self.count
         
    }
    public func components(separatedBy separators: [String]) -> [String] {
           var output: [String] = [self]
           for separator in separators {
               output = output.flatMap { $0.components(separatedBy: separator) }
           }
           return output.map { $0.trimmingCharacters(in: .whitespaces)}
       }
       
    func capitalizingFirstLetter() -> String {
          return prefix(1).capitalized + dropFirst()
      }
    
    func convertDateFormater(_ dateStr: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date = dateFormatter.date(from: dateStr)
            if let date = date {
                print("date=\(date)")
            }
            let dateStr = date?.timeAgoSince(date ?? Date()) ?? ""
            //timeAgoDisplay() ?? ""
            return dateStr
        }
    
    func isDateFromThisStringIsOfPast() -> Bool {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy/MM/dd HH:mm"
        let startTimeStamp = dateFormatter1.date(from: self)?.timeIntervalSince1970
        if Date().timeIntervalSince1970 - startTimeStamp! < 0 {
          return false
        }
        else {
          return true
        }
      }
      func isDateFromThisStringIsOfFutureWithString(strDate : String) -> Bool {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy/MM/dd HH:mm"
        let startTimeStamp = dateFormatter1.date(from: self)?.timeIntervalSince1970
        let compareTimeStamp = dateFormatter1.date(from: strDate)?.timeIntervalSince1970
        if compareTimeStamp! - startTimeStamp! > 0 { return true }
        else { return false }
      }
    
}
extension Date {
    var formatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return  formatter.string(from: self)
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return  formatter.string(from: self)
    }
    
    var formattedDatewithMonth: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return  formatter.string(from: self)
    }

    
    func timeAgoDisplay() -> String {
        if #available(iOS 13.0, *) {
          let formatter = RelativeDateTimeFormatter()
          formatter.unitsStyle = .full
          print(formatter.localizedString(for: self, relativeTo: Date()))
          return formatter.localizedString(for: self, relativeTo: Date())
        } else {
          // Fallback on earlier versions
        }
        return ""
      }
    /*  func timeAgoSince(_ date: Date) -> String {
        let calendar = Calendar.current
        let now = Date()
        let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let components = (calendar as NSCalendar).components(unitFlags, from: date, to: now, options: [])
        if let year = components.year, year >= 2 {
          return "\(year) years ago"
        }
        if let year = components.year, year >= 1 {
          return "Last year"
        }
        if let month = components.month, month >= 2 {
          return "\(month) months ago"
        }
        if let month = components.month, month >= 1 {
          return "Last month"
        }
        if let week = components.weekOfYear, week >= 2 {
          return "\(week) weeks ago"
        }
        if let week = components.weekOfYear, week >= 1 {
          return "Last week"
        }
        if let day = components.day, day >= 2 {
          return "\(day) days ago"
        }
        if let day = components.day, day >= 1 {
          return "Yesterday"
        }
        if let day = components.day, day <= 3 {
          return "Use Soon"
        }
        if let day = components.day, day <= 5 {
          return "Fresh"
        }
        
        if let day = components.day, day <= 2 {
          return "Use Immediately"
        }
        if let day = components.day, day <= 1 {
          return "Tommmorow"
        }
        
        if let hour = components.hour, hour >= 2 {
          return "\(hour) hours ago"
        }
        if let hour = components.hour, hour >= 1 {
          return "An hour ago"
        }
        if let minute = components.minute, minute >= 2 {
          return "\(minute) minutes ago"
        }
        if let minute = components.minute, minute >= 1 {
          return "A minute ago"
        }
        if let second = components.second, second >= 3 {
          return "\(second) seconds ago"
        }
        return "Today"
      }*/
    
    
    
    func timeAgoSince(_ date: Date) -> String {
      let calendar = Calendar.current
      let now = Date()
      let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
      let components = (calendar as NSCalendar).components(unitFlags, from: date, to: now, options: [])
     
      if let day = components.day, day <= 5 {
        return "Fresh"
      }
      if let day = components.day, day <= 2 {
        return "Use Immediately"
      }
      return "Use Soon"
    }
    
    func findDaysBefore( _ secondDate :  Date) -> String {
        let calendar = Calendar.current

        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: Date())
        let date2 = calendar.startOfDay(for: secondDate)

        let components = calendar.dateComponents([.day], from: date1, to: date2)
        var day = 0
        if let days = components.day {
            day = days
        }
        
        if day == 3 && day <= 5 {
            return DaysLabels.useSoon.rawValue
        }
        if day <= 2 {
            return DaysLabels.immediatley.rawValue
        }
        return DaysLabels.fresh.rawValue
    }
}

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}

extension Double {
    func format(f: String) -> Double {
        return  Double(String(format: "%.1f", self))! //String(format: "%\(f)f", self)
    }
    
   func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}

extension NSAttributedString {
  func scaleBy(scale: CGFloat) -> NSAttributedString {
    let scaledAttributedString = NSMutableAttributedString(attributedString: self)
    scaledAttributedString.enumerateAttribute(NSAttributedString.Key.font, in: NSRange(location: 0, length: scaledAttributedString.length), options: NSAttributedString.EnumerationOptions(rawValue: 0)) { (value, range, _) in
      if let oldFont = value as? UIFont {
        let newFont = oldFont.withSize(oldFont.pointSize * scale)
        scaledAttributedString.removeAttribute(NSAttributedString.Key.font, range: range)
        scaledAttributedString.addAttribute(NSAttributedString.Key.font, value: newFont, range: range)
      }
    }
    return scaledAttributedString
  }
    
    public convenience init?(HTMLString html: String, font: UIFont? = nil) throws {
        let options : [NSAttributedString.DocumentReadingOptionKey : Any] =
            [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
             NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue]

        guard let data = html.data(using: .utf8, allowLossyConversion: true) else {
            throw NSError(domain: "Parse Error", code: 0, userInfo: nil)
        }

        if let font = font {
            guard let attr = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil) else {
                throw NSError(domain: "Parse Error", code: 0, userInfo: nil)
            }
            var attrs = attr.attributes(at: 0, effectiveRange: nil)
            attrs[NSAttributedString.Key.font] = font
            attr.setAttributes(attrs, range: NSRange(location: 0, length: attr.length))
            self.init(attributedString: attr)
        } else {
            try? self.init(data: data, options: options, documentAttributes: nil)
        }
    }
}
