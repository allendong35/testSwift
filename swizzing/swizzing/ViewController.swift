//
//  ViewController.swift
//  swizzing
//
//  Created by song on 2018/2/8.
//  Copyright © 2018年 YiJie. All rights reserved.
//

import UIKit
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        let point = tableView.contentOffset
        print("Name is changed! point =",point);
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset" {
            let new = change![NSKeyValueChangeKey.newKey]
            let point = tableView.indexPathForRow(at: new as! CGPoint)
            print("point=====>",point)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {//滑动减速时
        
    }

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

