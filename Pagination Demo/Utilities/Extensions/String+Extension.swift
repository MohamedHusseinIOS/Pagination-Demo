//
//  String+Extension.swift
//  etajerIOS
//
//  Created by mohamed on 7/4/19.
//  Copyright © 2019 mohamed ismail. All rights reserved.
//

import Foundation
import UIKit

extension String{
    
    func clickableString(gotolink link: String, fontSize: CGFloat = 17) -> NSMutableAttributedString {
        let range = NSRange(location: 0, length: self.count)
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(.link, value: URL(string: link)!, range: range)
        //attributedString.addAttribute(.font, value: UIFont(name: Constants.font.rawValue, size: fontSize)!, range: range)
        return attributedString
    }
    
    func attributedString(fontSize: CGFloat = 17, color: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))->NSMutableAttributedString{
        let range = NSRange(location: 0, length: self.count)
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        //attributedString.addAttribute(.font, value: UIFont(name: Constants.font.rawValue, size: fontSize)!, range: range)
        return attributedString
    }

}
