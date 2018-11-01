//
//  ViewController.swift
//  text
//
//  Created by song on 2018/2/12.
//  Copyright © 2018年 YiJie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var name : String?
    
    
    var testName : String! {
        get{
            return name;
        }set {
            name = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        testName = "aa"
        print("testName====>",self.name)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

