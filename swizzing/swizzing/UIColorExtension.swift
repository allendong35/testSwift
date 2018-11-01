//
//  UIColorExtension.swift
//  swizzing
//
//  Created by song on 2018/2/11.
//  Copyright © 2018年 YiJie. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hexColor: String){//遍历构造函数必须写self.init
        
        // 存储转换后的数值
        var red:UInt32 = 0, green:UInt32 = 0, blue:UInt32 = 0
        
        // 分别转换进行转换
        Scanner(string: hexColor[0..<2]).scanHexInt32(&red)
        
        Scanner(string: hexColor[2..<4]).scanHexInt32(&green)
        
        Scanner(string: hexColor[4..<6]).scanHexInt32(&blue)
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255,alpha: 1)
    }
}
