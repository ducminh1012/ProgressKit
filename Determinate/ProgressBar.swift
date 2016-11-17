//
//  ProgressBar.swift
//  ProgressKit
//
//  Created by Kauntey Suryawanshi on 31/07/15.
//  Copyright (c) 2015 Kauntey Suryawanshi. All rights reserved.
//

import Foundation
import Cocoa

@IBDesignable
open class ProgressBar: DeterminateAnimation {

    var borderLayer = CAShapeLayer()
    var progressLayer = CAGradientLayer()
    var percentageLayer = CATextLayer()
    var percentageColor = NSColor.white
    
    @IBInspectable open var originColor: NSColor = NSColor(red: 247/255.0, green: 148/255.0, blue: 29/255.0, alpha: 1.0) {
        didSet {
            notifyViewRedesigned()
        }
    }
    
    @IBInspectable open var destColor: NSColor = NSColor(red: 247/255.0, green: 148/255.0, blue: 29/255.0, alpha: 0.0) {
        didSet {
            notifyViewRedesigned()
        }
    }
    
    @IBInspectable open var borderColor: NSColor = NSColor.black {
        didSet {
            notifyViewRedesigned()
        }
    }

    
    @IBInspectable open var percentageFont: NSFont = NSFont.boldSystemFont(ofSize: 15) {
        didSet {
            notifyViewRedesigned()
        }
    }

    override func notifyViewRedesigned() {
        super.notifyViewRedesigned()
        self.layer?.cornerRadius = 0.0
        borderLayer.borderColor = borderColor.cgColor
        progressLayer.backgroundColor = foreground.cgColor
        progressLayer.colors?[0] = originColor.cgColor
        progressLayer.colors?[1] = destColor.cgColor
        
        percentageLayer.font = percentageFont
    }

    override func configureLayers() {
        super.configureLayers()

        borderLayer.frame = self.bounds
        borderLayer.cornerRadius = 0.0
        borderLayer.borderWidth = 0.0
        self.layer?.addSublayer(borderLayer)

        progressLayer.frame = NSInsetRect(borderLayer.bounds, 0, 0)
        progressLayer.frame.size.width = borderLayer.bounds.width
        progressLayer.cornerRadius = 0.0
        progressLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        progressLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        progressLayer.colors = [originColor.cgColor, destColor.cgColor]
        borderLayer.addSublayer(progressLayer)

        percentageLayer.string = "0%"
        percentageLayer.font = percentageFont
        percentageLayer.fontSize = 15
        percentageLayer.contentsScale = NSScreen.main()!.backingScaleFactor
        percentageLayer.foregroundColor = percentageColor.cgColor
        percentageLayer.isWrapped = true
        percentageLayer.frame = NSRect(x: borderLayer.frame.width/2 - 10, y: borderLayer.frame.height/2 - 10, width: 50, height:20)
        progressLayer.addSublayer(percentageLayer)
    }
    
    override func updateProgress() {
        CATransaction.begin()
        if animated {
            CATransaction.setAnimationDuration(0.5)
        } else {
            CATransaction.setDisableActions(true)
        }
        
        percentageLayer.string = "\(Int(progress * 100))%"
        
        let timing = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        CATransaction.setAnimationTimingFunction(timing)
        progressLayer.frame.size.width = borderLayer.bounds.width * progress
        CATransaction.commit()
    }
}
