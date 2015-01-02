//
//  Sample1ViewController.swift
//  EditableImage
//
//  Created by TakanoriMatsumoto on 2015/01/02.
//  Copyright (c) 2015年 TakanoriMatsumoto. All rights reserved.
//

import UIKit

class Sample1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "sample1"
        

        // Do any additional setup after loading the view.
        let editableIV = EditableImageView(frame: CGRectMake(100, 100, 100, 100), image: UIImage(named: "editable-image-button-control"))
        view.addSubview(editableIV)
        
        let editableIV2 = EditableImageView(frame: CGRectMake(100, 100, 100, 100), image: UIImage(named: "editable-image-button-control"))
        view.addSubview(editableIV2)
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
