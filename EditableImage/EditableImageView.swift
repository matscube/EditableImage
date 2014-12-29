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
    
    private var _isEditable: Bool = false
    private var isEditable: Bool {
        get {
            return _isEditable
        }
        set {
            _isEditable = newValue
            if _isEditable {
                
            } else {
                
            }
        }
    }
    
    private let removeButtonImage = UIImage(named: "editable-image-button-delete")
    private let controlButtonImage = UIImage(named: "editable-image-button-control")
    private let buttonSize: CGFloat = 20
    
    private var imageView = UIImageView()
    private var frameView: FrameView!
    init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        imageView.image = image
  
        let imageScale: CGFloat = 0.7
        imageView.frame = CGRectMake(0, 0, frame.width * imageScale, frame.height * imageScale)
        imageView.center = CGPointMake(frame.width / 2, frame.height / 2)
        addSubview(imageView)
        
        frameView = FrameView(mainView: self, margin: 0)
        layoutFrameView()
        addSubview(frameView)
        
        let removeButton = UIButton()
        removeButton.frame = CGRectMake(0, 0, buttonSize, buttonSize)
        removeButton.addTarget(self, action: "remove", forControlEvents: UIControlEvents.TouchUpInside)
        removeButton.setImage(removeButtonImage, forState: UIControlState.Normal)
        addSubview(removeButton)

        let controlButton = UIButton()
        controlButton.frame = CGRectMake(frame.width - buttonSize, frame.height - buttonSize, buttonSize, buttonSize)
        controlButton.setImage(controlButtonImage, forState: UIControlState.Normal)
        let controlGestureRecognizer = UIPanGestureRecognizer(target: self, action: "control:")
        controlButton.addGestureRecognizer(controlGestureRecognizer)
        addSubview(controlButton)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutFrameView()
    }
    
    func layoutFrameView() {
        let frameWidth: CGFloat = frame.width - buttonSize
        let frameHeight: CGFloat = frame.height - buttonSize
        frameView.frame = CGRectMake(buttonSize / 2, buttonSize / 2, frameWidth, frameHeight)
    }
    
    func remove() {
        println("hoge")
    }
    
    private var baseTransform: CGAffineTransform?
    private var baseCenter: CGPoint?
    private var touchLocation: CGPoint?
    func control(sender: UIGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began {
            println("control began")
            touchLocation = sender.locationInView(superview)
            baseTransform = transform
            baseCenter = CGPointMake(frame.origin.x + frame.width / 2, frame.origin.y + frame.height / 2)
        } else if sender.state == UIGestureRecognizerState.Changed {
            let curLocation = sender.locationInView(superview)
            let beforeVector = CGPointMake(touchLocation!.x - baseCenter!.x, touchLocation!.y - baseCenter!.y)
            let afterVector = CGPointMake(curLocation.x - baseCenter!.x, curLocation.y - baseCenter!.y)
            let beforeVectorNorm = CGFloat(sqrt(beforeVector.x * beforeVector.x + beforeVector.y * beforeVector.y))
            let afterVectorNorm = CGFloat(sqrt(afterVector.x * afterVector.x + afterVector.y * afterVector.y))
            println("afternorm: \(afterVectorNorm), beforenorm: \(beforeVectorNorm)")
            let scale = afterVectorNorm / beforeVectorNorm
            
            var cosValue = (beforeVector.x * afterVector.x + beforeVector.y * afterVector.y) / beforeVectorNorm / afterVectorNorm
            cosValue = max(-1, min(1, cosValue))
            let crossValue = (beforeVector.x * afterVector.y - afterVector.x * beforeVector.y)
            var angle = acos(cosValue)
            if crossValue < 0 {
                angle *= -1
            }
            
            println("angle: \(angle)")
            println("scale: \(scale)")
            
            var afterTransform = CGAffineTransformScale(baseTransform!, scale, scale)
            afterTransform = CGAffineTransformRotate(afterTransform, angle)
            transform = afterTransform
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        touchLocation = touch.locationInView(superview)
        baseCenter = center
    }
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        let curLocation = touch.locationInView(superview)
        center.x = baseCenter!.x + (curLocation.x - touchLocation!.x)
        center.y = baseCenter!.y + (curLocation.y - touchLocation!.y)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        isEditable = false
    }
    
    
    private class FrameView: UIView {
        let margin: CGFloat!
        let borderMainColor = UIColor.grayColor()
        let borderSubColor = UIColor.whiteColor()
        
        init(mainView: UIView, margin: CGFloat) {
            super.init(frame: CGRectMake(0, 0, frame.width, frame.height))
            backgroundColor = UIColor.clearColor()
            self.margin = margin
        }

        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func drawRect(rect: CGRect) {
            let context = UIGraphicsGetCurrentContext()
            
            let minX = CGRectGetMinX(rect) + margin
            let maxX = CGRectGetMaxX(rect) - margin
            let minY = CGRectGetMinY(rect) + margin
            let maxY = CGRectGetMaxY(rect) - margin
            
            CGContextSetStrokeColorWithColor(context, borderSubColor.CGColor)
            CGContextSetLineWidth(context, 4)
            CGContextMoveToPoint(context, minX, minY)
            CGContextAddLineToPoint(context, minX, maxY)
            CGContextAddLineToPoint(context, maxX, maxY)
            CGContextAddLineToPoint(context, maxX, minY)
            CGContextAddLineToPoint(context, minX, minY)
            CGContextAddLineToPoint(context, minX, maxY)
            CGContextSetShouldAntialias(context, false)
            CGContextStrokePath(context)
            
            CGContextSetStrokeColorWithColor(context, borderMainColor.CGColor)
            CGContextSetLineWidth(context, 2)
            CGContextMoveToPoint(context, minX, minY)
            CGContextAddLineToPoint(context, minX, maxY)
            CGContextAddLineToPoint(context, maxX, maxY)
            CGContextAddLineToPoint(context, maxX, minY)
            CGContextAddLineToPoint(context, minX, minY)
            CGContextAddLineToPoint(context, minX, maxY)
            CGContextSetShouldAntialias(context, false)
            CGContextStrokePath(context)
            
            
        }
    }

}
