//
//  Utils.swift
//  PR3
//
//  Copyright © 2020 UOC. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    static func show(Message message: String, WithTitle title: String, InViewController viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alertController, animated: true, completion: nil)
    }
}

extension UIColor {
    @objc func lighter(by percentage: CGFloat = 80.0) -> UIColor {
        return self.adjustBrightness(by: abs(percentage))
    }
    @objc func darker(by percentage: CGFloat = 80.0) -> UIColor {
        return self.adjustBrightness(by: -abs(percentage))
    }
    
    @objc func adjustBrightness(by percentage: CGFloat = 30.0) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            if b < 1.0 {
                let newB: CGFloat = max(min(b + (percentage/100.0)*b, 1.0), 0,0)
                return UIColor(hue: h, saturation: s, brightness: newB, alpha: a)
            } else {
                let newS: CGFloat = min(max(s - (percentage/100.0)*s, 0.0), 1.0)
                return UIColor(hue: h, saturation: newS, brightness: b, alpha: a)
            }
        }
        return self
    }
}

extension String {
    // Formats a String from a Decimal value
    static func withFormatted(amount: Decimal) -> String {
        let amountFormatter = NumberFormatter()
        amountFormatter.numberStyle = .decimal
        amountFormatter.decimalSeparator = ","
        amountFormatter.groupingSeparator = "."
        amountFormatter.minimumFractionDigits = 2
        amountFormatter.maximumFractionDigits = 2
        
        if let formattedAmount = amountFormatter.string(from: amount as NSDecimalNumber) {
            return "\(formattedAmount) €"
        } else {
            return "Not available"
        }
    }
    
    // Formats a String from a Date value
    static func withFormatted(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: date)
    }
}
