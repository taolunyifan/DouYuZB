//
//  UIColor_Extension.swift
//  DouYu
//
//  Created by 黄忠汉(外包) on 2018/3/21.
//  Copyright © 2018年 黄忠汉(外包). All rights reserved.
//

import UIKit

extension UIColor{
    class func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1.0)
    }
}
