//
//  UIColor+rgb.swift
//  githubViewer
//
//  Created by Francis Beauchamp on 2018-07-09.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import UIKit

extension UIColor {
    class func rgb(r red: CGFloat, g green: CGFloat, b blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue /     255, alpha: 1)
    }
    
    static var charcoal: UIColor {
        return UIColor.rgb(r: 21, g: 27, b: 31)
    }
    
    static var lightCharcoal: UIColor {
        return UIColor.rgb(r: 30, g: 36, b: 40)
    }
    
    static var harleyOrange: UIColor {
        return UIColor.rgb(r: 217, g: 76, b: 12)
    }
}
