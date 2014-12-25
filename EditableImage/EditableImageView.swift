//
//  EditableImageView.swift
//  EditableImage
//
//  Created by TakanoriMatsumoto on 2014/12/25.
//  Copyright (c) 2014年 TakanoriMatsumoto. All rights reserved.
//

import UIKit

class EditableImageView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    deinit {
        
    }
    
    private var imageView = UIImageView()
    private var frameView: FrameView!
    init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        imageView.image = image
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class FrameView: UIView {
        
    }

}
