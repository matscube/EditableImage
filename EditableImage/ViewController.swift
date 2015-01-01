//
//  ViewController.swift
//  EditableImage
//
//  Created by TakanoriMatsumoto on 2014/12/22.
//  Copyright (c) 2014年 TakanoriMatsumoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let editableIV = EditableImageView(frame: CGRectMake(100, 100, 100, 100), image: UIImage(named: "editable-image-button-control"))
        view.addSubview(editableIV)

        let editableIV2 = EditableImageView(frame: CGRectMake(100, 100, 100, 100), image: UIImage(named: "editable-image-button-control"))
        view.addSubview(editableIV2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

