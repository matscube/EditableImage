//
//  TabBarController.swift
//  EditableImage
//
//  Created by TakanoriMatsumoto on 2015/01/02.
//  Copyright (c) 2015年 TakanoriMatsumoto. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var sample1VC = Sample1ViewController()
        var sample2VC = Sample2ViewController()
        self.setViewControllers([sample1VC, sample2VC], animated: true)

        var tabItem1 = UITabBarItem(title: "Sample1", image: nil, tag: 0)
        var tabItem2 = UITabBarItem(title: "Sample2", image: nil, tag: 1)
        sample1VC.tabBarItem = tabItem1
        sample2VC.tabBarItem = tabItem2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
