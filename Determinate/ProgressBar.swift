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
    var percentageLabel = CATextLayer()
    
    var originColor = NSColor(red: 247/255.0, green: 148/255.0, blue: 29/255.0, alpha: 1.0)
    var destColor = NSColor(red: 247/255.0, green: 148/255.0, blue: 29/255.0, alpha: 0.0)
    
    @IBInspectable open var borderColor: NSColor = NSColor.black {
        didSet {
            notifyViewRedesigned()
        }
    }

    override func notifyViewRedesigned() {
        super.notifyViewRedesigned()
        self.layer?.cornerRadius = 0.0
        borderLayer.borderColor = borderColor.cgColor
        progressLayer.backgroundColor = foreground.cgColor
    }

    override func configureLayers() {
        super.configureLayers()

        borderLayer.frame = self.bounds
        borderLayer.cornerRadius = 0.0
        borderLayer.borderWidth = 0.0
        self.layer?.addSublayer(borderLayer)

        progressLayer.frame = NSInsetRect(borderLayer.bounds, 0, 0)
        progressLayer.frame.size.width = (borderLayer.bounds.width - 6)
        progressLayer.cornerRadius = 0.0
//        progressLayer.backgroundColor = foreground.cgColor
        progressLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        progressLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        progressLayer.colors = [originColor.cgColor, destColor.cgColor]
        borderLayer.addSublayer(progressLayer)

//        percentageLabel.stringValue = "test"
//        percentageLabel.backgroundColor = NSColor.clear
//        percentageLabel.layer?.backgroundColor = NSColor.clear.cgColor
//        percentageLabel.frame = NSRect(x: 0, y: 0, width: 100, height: 20)
//        percentageLabel.drawsBackground = false
//        percentageLabel.wantsLayer = true
////        borderLayer.addSublayer(percentageLabel)
//        self.addSubview(percentageLabel)
        percentageLabel.string = "122"
        percentageLabel.fontSize = 15
        percentageLabel.isWrapped = true
        percentageLabel.frame = NSRect(x: 10, y: 10, width: 100, height:100)
        borderLayer.addSublayer(percentageLabel)
    }
    
    override func updateProgress() {
        CATransaction.begin()
        if animated {
            CATransaction.setAnimationDuration(0.5)
        } else {
            CATransaction.setDisableActions(true)
        }
        let timing = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        CATransaction.setAnimationTimingFunction(timing)
        progressLayer.frame.size.width = (borderLayer.bounds.width - 6) * progress
        CATransaction.commit()
    }
}
