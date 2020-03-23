//
//  DrumDisplay.swift
//  drumButtonAndKnow
//
//  Created by jeffomidvaran on 3/18/20.
//  Copyright © 2020 jeffomidvaran. All rights reserved.
//

import UIKit

@IBDesignable
class DrumDisplay: UIView {
    private var label: UILabel = UILabel()
    var textColor: UIColor = UIColor.red
    var labelBackgroundColor: UIColor = UIColor.black
    private var labelText: String = "12:34" { didSet { setNeedsDisplay(); setNeedsLayout() }}

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit(){
        label.numberOfLines = 0
        self.backgroundColor = UIColor.clear
        addSubview(label)
    }
    
    func setlabelText(message: String){
        labelText = (message.count > 5) ? "Err" : message
    }

    override func draw(_ rect: CGRect) {
        let labelBackground = UIBezierPath(
                                roundedRect: CGRect(x: 0.0, y: 0.0,
                                                    width: bounds.maxX,
                                                    height: bounds.maxY),
                                cornerRadius: cornerRadius)
        labelBackground.addClip()
        labelBackgroundColor.setFill()
        labelBackground.fill()

        guard let customFont = UIFont(name: "Digital-7", size: 80) else {
            fatalError("Font Could Not Be Found")
        }
        label.font = UIFontMetrics.default.scaledFont(for: customFont)
        label.adjustsFontForContentSizeCategory = true
        
        label.attributedText = NSAttributedString(string: labelText,
                                                  attributes: [.foregroundColor: textColor])
        label.frame.size = CGSize.zero
        label.sizeToFit()
        label.center.x = self.bounds.midX
        label.center.y = self.bounds.midY
    }

    private struct SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
    }
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
}

