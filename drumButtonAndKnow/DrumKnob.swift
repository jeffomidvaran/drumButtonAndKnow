//
//  CustomKnob.swift
//  drumButtonAndKnow
//
//  Created by jeffomidvaran on 3/16/20.
//  Copyright © 2020 jeffomidvaran. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

@IBDesignable
class DrumKnob: UIButton {
    let knobLayer = CAShapeLayer()
    let pointerLayer = CAShapeLayer()
    var pointerColor = UIColor.orange { didSet { pointerLayer.strokeColor = pointerColor.cgColor }}
    var knobColor = UIColor.darkGray { didSet { knobLayer.fillColor = knobColor.cgColor }}
    var startAngle: CGFloat = CGFloat(-Double.pi) * 11 / 8 { didSet { updateKnobBezierPath() }}
    var endAngle: CGFloat = CGFloat(Double.pi) * 3 / 8 { didSet { updateKnobBezierPath() }}
    private (set) var pointerAngle: CGFloat = CGFloat(-Double.pi) * 11 / 8
    var isContinuous = true
    var minimumValue: Float = 0
    var maximumValue: Float = 1
    private (set) var value: Float = 0
    var pointerLength: CGFloat = 6 { didSet {
            updateKnobBezierPath()
            updatePointerBezierPath()
        }
    }
    var lineWidth: CGFloat = 2 { didSet {
        knobLayer.lineWidth = lineWidth
        pointerLayer.lineWidth = lineWidth
        updateKnobBezierPath()
        updatePointerBezierPath()
        }
    }


    private func commonInit(){
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        setBounds(bounds)
        setPointerAngle(startAngle, animated: false)
        layer.addSublayer(knobLayer)
        layer.addSublayer(pointerLayer)
        
        let gestureRecognizer = RotationGestureRecognizer(target: self, action: #selector(DrumKnob.handleGesture(_:)))
        addGestureRecognizer(gestureRecognizer)
    }

    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func setBounds(_ bounds: CGRect) {
        //  set knob bounds
        knobLayer.bounds = bounds
        knobLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        updateKnobBezierPath()
        
        //  set pointer bounds
        pointerLayer.bounds = knobLayer.bounds
        pointerLayer.position = knobLayer.position
        updatePointerBezierPath()
    }

    // TO DO: make it so the user can't go from 100% to 0
    func setValue(_ newValue: Float, animated: Bool = false){
        value = min(maximumValue, max(minimumValue, newValue))
        let angleRange = endAngle - startAngle
        let valueRange = maximumValue - minimumValue
        let angleValue = CGFloat(value - minimumValue) /
            CGFloat(valueRange) * angleRange + startAngle
        setPointerAngle(angleValue, animated: animated)
    }
    
    func setPointerAngle(_ newPointerAngle: CGFloat, animated: Bool = false) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        pointerLayer.transform = CATransform3DMakeRotation(newPointerAngle, 0, 0, 1)
        CATransaction.commit()
        pointerAngle = newPointerAngle
    }
    
    private func updateKnobBezierPath() {
      let bounds = knobLayer.bounds
      let center = CGPoint(x: bounds.midX, y: bounds.midY)
      let offset = max(pointerLength, lineWidth  / 2)
      let radius = min(bounds.width, bounds.height) / 2 - offset
      let circle = UIBezierPath(arcCenter: center,
                              radius: radius,
                              startAngle: 0,
                              endAngle: 360,
                              clockwise: true)
      knobLayer.path = circle.cgPath
    }
    
    private func updatePointerBezierPath() {
      let bounds = knobLayer.bounds
      let pointer = UIBezierPath()
      pointer.move(to: CGPoint(x: bounds.width - CGFloat(pointerLength)
                                    - CGFloat(lineWidth) / 2 - CGFloat(pointerLength),
                               y: bounds.midY))
      pointer.addLine(to: CGPoint(x: bounds.width - CGFloat(pointerLength),
                                  y: bounds.midY))
      pointerLayer.path = pointer.cgPath
    }


    @objc private func handleGesture(_ gesture: RotationGestureRecognizer) {
        let midPointAngle = (2 * CGFloat(Double.pi) + startAngle - endAngle) / 2 + endAngle
        var boundedAngle = gesture.touchAngle
        if boundedAngle > midPointAngle {
            boundedAngle -= 2 * CGFloat(Double.pi)
        } else if boundedAngle < (midPointAngle - 2 * CGFloat(Double.pi)) {
            boundedAngle -= 2 * CGFloat(Double.pi)
        }
        boundedAngle = min(endAngle, max(startAngle, boundedAngle))
        let angleRange = endAngle - startAngle
        let valueRange = maximumValue - minimumValue
        let angleValue = Float(boundedAngle - startAngle) / Float(angleRange) * valueRange + minimumValue
        setValue(angleValue)
        if isContinuous {
            sendActions(for: .valueChanged)
        } else {
            if gesture.state == .ended || gesture.state == .cancelled {
                sendActions(for: .valueChanged)
            }
        }
    }
}


private class RotationGestureRecognizer: UIPanGestureRecognizer {
    private (set) var touchAngle: CGFloat = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        updateAngle(with: touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent){
        super.touchesMoved(touches, with: event)
        updateAngle(with: touches)
    }
    
    private func updateAngle(with touches: Set<UITouch>) {
      guard
        let touch = touches.first,
        let view = view
      else {
        return
      }
      let touchPoint = touch.location(in: view)
      touchAngle = angle(for: touchPoint, in: view)
    }

    private func angle(for point: CGPoint, in view: UIView) -> CGFloat {
      let centerOffset = CGPoint(x: point.x - view.bounds.midX, y: point.y - view.bounds.midY)
      return atan2(centerOffset.y, centerOffset.x)
    }

    override init(target: Any?, action: Selector?) {
      super.init(target: target, action: action)

      maximumNumberOfTouches = 1
      minimumNumberOfTouches = 1
    }
}














