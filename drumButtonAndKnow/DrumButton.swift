//
//  DrumButton.swift
//  drumButtonAndKnow
//
//  Created by jeffomidvaran on 3/15/20.
//  Copyright © 2020 jeffomidvaran. All rights reserved.
//

import UIKit

@IBDesignable
class DrumButton: UIButton {
    var buttonColor = #colorLiteral(red: 0.7603728175, green: 0.7242770791, blue: 0.6018891931, alpha: 1) {didSet{ setNeedsLayout(); setNeedsDisplay()}}
    var lightOnColor = UIColor.red { didSet {setNeedsLayout(); setNeedsDisplay()}}
    var buttonOn: Bool = true {didSet{setNeedsLayout(); setNeedsDisplay()}}
    private let lightOffColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    override init(frame: CGRect){
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    private func customInit() {
        self.backgroundColor = UIColor.clear
    }
    
    
    override func draw(_ rect: CGRect) {
        // CREATE BUTTON BACKGROUND
        let outerButton = UIBezierPath(
            roundedRect: CGRect(x: 0.0, y: 0.0,
                                width: bounds.maxX, height: bounds.maxY),
                                cornerRadius: cornerRadius)
        outerButton.addClip()
        buttonColor.setFill()
        outerButton.fill()
        
        // CREATE BUTTON LIGHT
        let innerButtonWidth = bounds.maxX * 0.4
        let innerButtonHeight = bounds.maxY * 0.1

        let innerButton = UIBezierPath(
            roundedRect: CGRect(x: (bounds.maxX / 2) - innerButtonWidth / 2,
                                y: bounds.maxY * 0.2,
                                width: innerButtonWidth, height: innerButtonHeight),
                                cornerRadius: cornerRadius)
        innerButton.addClip()
        buttonOn ? lightOnColor.setFill() : lightOffColor.setFill()
        innerButton.fill()
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
