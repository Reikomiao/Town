//
//  PrefixHeader.swift
//  Town
//
//  Created by 冯振玲 on 2017/5/25.
//  Copyright © 2017年 Reiko. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height
// 255,222,100
let mainColor:UIColor = UIColor.init(red: 255 / 255, green: 210 / 255, blue: 45 / 255, alpha: 1)

extension UIColor{

    static func RGBColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor{
        return UIColor.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }

}
