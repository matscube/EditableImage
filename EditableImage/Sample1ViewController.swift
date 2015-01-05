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

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.whiteColor()

        let editableIV = EditableImageView(frame: CGRectMake(100, 50, 100, 100), image: UIImage(named: "editable-image-button-control"))
        view.addSubview(editableIV)
        
        let button = UIButton()
        button.frame = CGRectMake(0, 0, 100, 50)
        button.center = CGPointMake(view.frame.width / 2, view.frame.height - 170)
        button.addTarget(self, action: "addImageView", forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitle("Add Image", forState: UIControlState.Normal)
        button.layer.borderWidth = 2
        let color = UIColor(red: 0x1b/255, green: 0x9a/255, blue: 0xf7/255, alpha: 1)
        button.layer.borderColor = color.CGColor
        button.setTitleColor(color, forState: UIControlState.Normal)
        button.layer.cornerRadius = 5
        view.addSubview(button)

        let button2 = UIButton()
        button2.frame = CGRectMake(0, 0, 100, 50)
        button2.center = CGPointMake(view.frame.width / 2, view.frame.height - 100)
        button2.addTarget(self, action: "getImage", forControlEvents: UIControlEvents.TouchUpInside)
        button2.setTitle("Get Image", forState: UIControlState.Normal)
        button2.layer.borderWidth = 2
        let color2 = UIColor(red: 0xfe/255, green: 0xae/255, blue: 0x1b/255, alpha: 1)
        button2.layer.borderColor = color2.CGColor
        button2.setTitleColor(color2, forState: UIControlState.Normal)
        button2.layer.cornerRadius = 5
        view.addSubview(button2)
    }
    
    func addImageView() {
        let editable = EditableImageView(frame: CGRectMake(100, 100, 100, 100), image: UIImage(named: "editable-image-button-control"))
        view.addSubview(editable)
    }
    
    func getImage() {
        
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
