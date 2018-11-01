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
     func scrollBarDidScroll(_ scrollBar:SelfScrollBar)
     func scrollBarTouchAction(_ scrollBar:SelfScrollBar)
}
class SelfScrollBar: UIView {
    
    
    
    var barMoveDuration : CGFloat = 0
    
    var minBarHeight : CGFloat = 0
    
    var barHeight : CGFloat = 0 {
        didSet {
            barHeight = (barHeight>self.minBarHeight) ? barHeight : self.minBarHeight
            var temFrame :CGRect = self.scrollBar!.frame;
            temFrame.size.height = barHeight;
            self.scrollBar?.frame = temFrame;
        }
    }
    
    var yPosition : CGFloat = 0 {
        didSet {
            var temFrame : CGRect = self.scrollBar!.frame;
            temFrame.origin.y = yPosition;
            self.scrollBar?.frame = temFrame;
        }
    }
    
    var scrollBar : UIView?
    
    var backView : UIView?
    
    var  backColor : UIColor?
    
    var foreColor : UIColor?

    
    weak var delegate:SelfScrollBarDelegate?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initInfo()
        self.createControl()
        self.addSwipeGesture()
    }
    
    func initInfo() {
        minBarHeight = 40
        barMoveDuration = 0.25
        
        foreColor = UIColor.init(hexColor: "#2f9cd4")
        backColor = UIColor.init(hexColor: "#e6e6e6")
        self.layer.cornerRadius = self.bounds.size.width * 0.5
        self.layer.masksToBounds = true
        self.backgroundColor = backColor
    }
    
    func createControl() {
        let backView = UIView.init(frame: self.bounds)
        self.addSubview(backView)
        self.backView = backView
        
        let scrollBar = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height));
        scrollBar.backgroundColor = self.foreColor
        scrollBar.layer.cornerRadius = self.bounds.width * 0.5
        scrollBar.layer.masksToBounds = true
        self.addSubview(scrollBar)
        self.scrollBar = scrollBar
    }
    
    func addSwipeGesture() {
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(SelfScrollBar.handleTap(_:)))
        backView?.addGestureRecognizer(tap)
        
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(SelfScrollBar.handlePan(_:)))
        scrollBar?.addGestureRecognizer(pan)
        
    }
    
    @objc func handleTap(_ tap:UITapGestureRecognizer)  {
        if tap.view == self.scrollBar {
            return
        }
        let positionY = tap.location(in: self).y
        
        UIView.animate(withDuration: TimeInterval(self.barMoveDuration)) {
            self.yPosition = positionY > self.yPosition ? positionY - self.barHeight : positionY
        }
        if (self.delegate != nil) {
            self.delegate?.scrollBarTouchAction(self)
        }
    }
    
    @objc func handlePan(_ pan:UIPanGestureRecognizer)  {
        let moveY = pan.translation(in: self).y
        
        pan.setTranslation(CGPoint.init(x: 0, y: 0), in: self)
        
        //在顶部上滑或底部下滑直接返回
        if ((self.yPosition <= 0 && moveY <= 0) || (self.yPosition >= self.bounds.size.height - self.barHeight && moveY >= 0)){return}
        
        //赋值
        self.yPosition += moveY;
        
        //防止瞬间大偏移量滑动影响显示效果
        if (self.yPosition < 0) {
            self.yPosition = 0;
        }
        if (self.yPosition > self.bounds.size.height - self.barHeight && moveY >= 0){
            self.yPosition = self.bounds.size.height - self.barHeight;
        }
        //代理
        if (self.delegate != nil){
            self.delegate?.scrollBarDidScroll(self)
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
