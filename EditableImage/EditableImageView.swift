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
        NSLog("EditableImageView deinit")
    }
    
    private var _isEditable: Bool = false
    private var isEditable: Bool {
        get {
            return _isEditable
        }
        set {
            _isEditable = newValue
            if _isEditable {
                removeButton.hidden = false
                controlButton.hidden = false
                frameView.hidden = false
            } else {
                removeButton.hidden = true
                controlButton.hidden = true
                frameView.hidden = true
            }
        }
    }
    
    private let removeButtonImage = UIImage(named: "editable-image-button-delete")
    private let controlButtonImage = UIImage(named: "editable-image-button-control")
    private let removeButton = UIButton()
    private let controlButton = UIButton()
    private let buttonSize: CGFloat = 30
    
    private var imageView = UIImageView()
    private var frameView: FrameView!
    init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        imageView.image = image
  
        addSubview(imageView)
        
        frameView = FrameView(mainView: self, margin: 0)
        addSubview(frameView)
        
        removeButton.addTarget(self, action: "remove", forControlEvents: UIControlEvents.TouchUpInside)
        removeButton.setImage(removeButtonImage, forState: UIControlState.Normal)
        addSubview(removeButton)

        controlButton.setImage(controlButtonImage, forState: UIControlState.Normal)
        let controlGestureRecognizer = UIPanGestureRecognizer(target: self, action: "control:")
        controlButton.addGestureRecognizer(controlGestureRecognizer)
        addSubview(controlButton)
        
        clipsToBounds = false
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let superWidth: CGFloat = bounds.width
        let superHeight: CGFloat = bounds.height
        frameView.frame = CGRectMake(buttonSize / 2, buttonSize / 2, superWidth - buttonSize, superHeight - buttonSize)

        let imageScale: CGFloat = 0.7
        imageView.frame = CGRectMake(0, 0, (superWidth - buttonSize) * imageScale, (superHeight - buttonSize) * imageScale)
        imageView.center = CGPointMake(superWidth / 2, superHeight / 2)
        removeButton.frame = CGRectMake(0, 0, buttonSize, buttonSize)
        controlButton.frame = CGRectMake(superWidth - buttonSize, superHeight - buttonSize, buttonSize, buttonSize)
    }
    
    func getImage() -> UIImage {
        return imageView.image!
    }
    
    func remove() {
        NSLog("EditableImage is removed")
        removeFromSuperview()
    }
    
    private var baseTransform: CGAffineTransform?
    private var baseCenter: CGPoint?
    private var baseBounds: CGRect?
    private var touchLocation: CGPoint?
    func control(sender: UIGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began {
            superview?.bringSubviewToFront(self)
            println("control began")
            touchLocation = sender.locationInView(superview)
            baseTransform = transform
            baseCenter = CGPointMake(frame.origin.x + frame.width / 2, frame.origin.y + frame.height / 2)
            baseBounds = bounds
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

            // layout angle
            var rotatedTransform = CGAffineTransformRotate(baseTransform!, angle)
            transform = rotatedTransform

            // layout scale
            bounds = CGRectMake(0, 0, (baseBounds!.width - buttonSize) * scale + buttonSize, (baseBounds!.height - buttonSize) * scale + buttonSize)
            center = baseCenter!
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        superview?.bringSubviewToFront(self)
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
        isEditable = !isEditable
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
        
        override func layoutSubviews() {
            super.layoutSubviews()
            setNeedsDisplayInRect(bounds)
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
            CGContextSetLineWidth(context, 8)
            CGContextMoveToPoint(context, minX, minY)
            CGContextAddLineToPoint(context, minX, maxY)
            CGContextAddLineToPoint(context, maxX, maxY)
            CGContextAddLineToPoint(context, maxX, minY)
            CGContextAddLineToPoint(context, minX, minY)
            CGContextAddLineToPoint(context, minX, maxY)
            CGContextSetShouldAntialias(context, false)
            CGContextStrokePath(context)
            
            CGContextSetStrokeColorWithColor(context, borderMainColor.CGColor)
            CGContextSetLineWidth(context, 6)
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
