//
//  SelfScrollBar.swift
//  swizzing
//
//  Created by song on 2018/2/9.
//  Copyright © 2018年 YiJie. All rights reserved.
//

import UIKit

protocol SelfScrollBarDelegate : NSObjectProtocol {
    //滚动条滑动代理事件
    func scrollBarDidScroll(scrollBar:SelfScrollBar)
    func scrollBarTouchAction(scrollBar:SelfScrollBar) 
}
class SelfScrollBar: UIView {
    
    var  backColor : UIColor = UIColor.black
    var foreColor : UIColor = UIColor.black
    
    var barMoveDuration: Float = 0
    
    var minBarHeight = 0
    
    var barHeight = 0
    
    var yPosition = 0
    
    var scrollBar : UIView?
    
    var backView : UIView?
    
    weak var delegate:SelfScrollBarDelegate?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    func initInfo() {
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
