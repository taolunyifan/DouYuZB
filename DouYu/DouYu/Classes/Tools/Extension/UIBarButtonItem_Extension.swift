//
//  UIBarButtonItem-Extension.swift
//  DouYu
//
//  Created by 黄忠汉(外包) on 2018/3/20.
//  Copyright © 2018年 黄忠汉(外包). All rights reserved.
//

import UIKit


extension UIBarButtonItem {
    class func addBarButtonItem(imageName:String,hightImageName:String,size:CGSize)->UIBarButtonItem{
        let btn = UIButton()
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        let item = UIBarButtonItem(customView: btn)
        return item
    }
    convenience init(imageName:String,hightImageName:String = "",size:CGSize = CGSize.zero) {
        let btn = UIButton()
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        if hightImageName != "" {
            btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        }
        btn.setImage(UIImage(named: imageName), for: .normal)
        self.init(customView: btn)
    }
}
