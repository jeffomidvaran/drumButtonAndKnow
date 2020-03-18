//
//  drumDial.swift
//  drumButtonAndKnow
//
//  Created by jeffomidvaran on 3/15/20.
//  Copyright © 2020 jeffomidvaran. All rights reserved.
//

import UIKit

@IBDesignable
class DrumDial: UIView {

    private lazy var circle = UIBezierPath(ovalIn: bounds)
    private lazy var pointer = UIBezierPath()
    
    var knobBodyColor = #colorLiteral(red: 0.2685026824, green: 0.2507379055, blue: 0.1766097844, alpha: 1) { didSet {  setNeedsDisplay(); setNeedsLayout() } }
    var pointerColor  = #colorLiteral(red: 0.7767125964, green: 0.4977853894, blue: 0.2844029069, alpha: 1) { didSet {  setNeedsDisplay(); setNeedsLayout() } }
    var degree: Double = 0.0 { didSet {  setNeedsDisplay(); setNeedsLayout() } }

    override func draw(_ rect: CGRect) {
        let knobWidth = bounds.maxX * 0.1
        let knobHeight = bounds.maxY * 0.2
        
        // DRAW KNOB BODY
        circle.addClip()
        knobBodyColor.setFill()
        circle.fill()

        // DRAW KNOB POINTER
         let cosPercent = CGFloat(cos(degreeToRadians(degree)))
         let sinPercent = CGFloat(sin(degreeToRadians(degree)))
         let xPosition = (bounds.maxX / 2) * cosPercent - (knobWidth / 1.5 * cosPercent)
         let yPosition = -((bounds.maxY / 2) * sinPercent - (knobHeight/1.5 * sinPercent))
        
        
        // used to start postioning from the center rather then the upper left
        let xCenter = bounds.midX - knobWidth/2
        let yCenter = bounds.midY - knobHeight/2

        pointer = UIBezierPath(
            roundedRect: CGRect(x: xCenter, // + xPosition,
                                y: yCenter, // + yPosition ,
                                width: knobWidth,
                                height: knobHeight),
            cornerRadius: cornerRadius)
        print(pointer.currentPoint)
        // pointer.addClip()  // don't understand what this is for
        pointerColor.setFill()
        let testing = degreeToRadians(40.0)
        print(testing)
        pointer.apply(CGAffineTransform(rotationAngle: testing))
        pointer.fill()

        

    }


    override func layoutSubviews() {
        /*
            called by the system
            can be called manually by setNeedsLayout()
        */
        super.layoutSubviews()
       
    }

    
    private func degreeToRadians(_ number: Double) -> CGFloat {
        return CGFloat(number * .pi / 180)
    }
    
    
    private struct SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.60
    }
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    private var cornerOffset: CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    private var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
}
