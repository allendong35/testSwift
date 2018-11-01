//
//  ViewController.swift
//  swizzing
//
//  Created by song on 2018/2/8.
//  Copyright © 2018年 YiJie. All rights reserved.
//

import UIKit
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,SelfScrollBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var scrollBar : SelfScrollBar?
    var tableBar : SelfScrollBar?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        let point = tableView.contentOffset
        print("Name is changed! point =",point);
        self.createControl()
        
    }

    func createControl() {
        tableBar = SelfScrollBar.init(frame: CGRect.init(x: tableView.frame.maxX, y: 64, width: 5, height: tableView.bounds.size.height))
        tableBar?.foreColor = UIColor.green
        tableBar?.backColor = UIColor.gray
        tableBar?.isUserInteractionEnabled = false
        self.view.addSubview(tableBar!)
        
        scrollBar = SelfScrollBar.init(frame: CGRect.init(x: tableView.frame.maxX+10, y: 64, width: 20, height: tableView.bounds.size.height))
        scrollBar?.delegate = self
        scrollBar?.minBarHeight = 80
        self.view.addSubview(scrollBar!)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset" {
            let new = change![NSKeyValueChangeKey.newKey]
            let point = tableView.indexPathForRow(at: new as! CGPoint)
//            print("point=====>",point)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            if (tableView.contentSize.height <= tableView.bounds.size.height) {
                self.scrollBar?.barHeight = tableView.bounds.size.height;
                self.tableBar?.barHeight = tableView.bounds.size.height;
            }else {
                self.scrollBar?.barHeight = pow(tableView.bounds.size.height, 2) / tableView.contentSize.height;
                self.tableBar?.barHeight = pow(tableView.bounds.size.height, 2) / tableView.contentSize.height;
            }
            //更新滚动条Y向位置
            self.scrollBar?.yPosition = ((self.scrollBar?.bounds.size.height)! - (self.scrollBar?.barHeight)!) * tableView.contentOffset.y / (tableView.contentSize.height - (self.scrollBar?.bounds.size.height)!);
            self.tableBar?.yPosition = ((self.tableBar?.bounds.size.height)! - (self.tableBar?.barHeight)!) * tableView.contentOffset.y / (tableView.contentSize.height - (self.tableBar?.bounds.size.height)!);
        }
    }
    
    
    internal func scrollBarDidScroll(_ scrollBar: SelfScrollBar) {
        self.tableView.contentOffset = CGPoint.init(x: 0, y: (self.tableView.contentSize.height - (self.scrollBar?.bounds.size.height)!)*scrollBar.yPosition / ((self.scrollBar?.bounds.size.height)! - (self.scrollBar?.barHeight)!))
    }
    
    func scrollBarTouchAction(_ scrollBar: SelfScrollBar) {
        UIView.animate(withDuration: TimeInterval(scrollBar.barMoveDuration)) {
            self.tableView.contentOffset = CGPoint.init(x: 0, y: (self.tableView.contentSize.height-(self.scrollBar?.bounds.size.height)!)*(self.scrollBar?.yPosition)! / ((self.scrollBar?.bounds.size.height)! - (self.scrollBar?.barHeight)!))
        }
//        [UIView animateWithDuration:scrollBar.barMoveDuration animations:^{
//            [_tableView setContentOffset:CGPointMake(0, (_tableView.contentSize.height - _scrollBar.bounds.size.height) * scrollBar.yPosition / (_scrollBar.bounds.size.height - _scrollBar.barHeight))];
//            }];
    }
    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//
//    }
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//
//    }
//
//    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {//滑动减速时
//
//    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "test") as! TableViewCell
        tableCell.setLabel(content: String(indexPath.row))
        if indexPath.row%3 == 0 {
            tableCell.backgroundColor = UIColor.red
        }else if indexPath.row%3 == 1{
            tableCell.backgroundColor = UIColor.green
        }else if indexPath.row%3 == 2{
            tableCell.backgroundColor = UIColor.blue
        }
        return  tableCell;
    }

}

