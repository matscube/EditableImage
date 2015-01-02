//
//  ViewController.swift
//  EditableImage
//
//  Created by TakanoriMatsumoto on 2014/12/22.
//  Copyright (c) 2014年 TakanoriMatsumoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var sample1VC = Sample1ViewController()
    var sample2VC = Sample2ViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        addChildViewController(sample1VC)
        addChildViewController(sample2VC)
        view.addSubview(sample1VC.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

