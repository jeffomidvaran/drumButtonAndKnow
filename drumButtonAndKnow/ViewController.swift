//
//  ViewController.swift
//  drumButtonAndKnow
//
//  Created by jeffomidvaran on 3/15/20.
//  Copyright © 2020 jeffomidvaran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var knob: DrumKnob!
    @IBOutlet weak var button: DrumButton!
    @IBOutlet weak var display: DrumDisplay!
    
    @IBAction func knobMoved(_ sender: Any) {
        let myString = String(knob.value)
        if myString.count > 5 {
            let index = myString.index(myString.startIndex, offsetBy: 5)
            let substring = myString[..<index]
            display.setlabelText(message: String(substring))
        } else {
            display.setlabelText(message: String(knob.value))
        }
    }

    @IBAction func buttonPressed() {
        button.buttonOn = !button.buttonOn
        display.setlabelText(message: "5678")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8870931268, green: 0.8731685877, blue: 0.8544336557, alpha: 1)

        // SET UP KNOB
        knob.lineWidth = 8
        knob.pointerLength = 16
        knob.setValue(0.2)
        knob.addTarget(self,
                       action: #selector(ViewController.knobMoved(_:)),
                       for: .valueChanged)
        knob.knobColor = UIColor.darkGray
        knob.pointerColor = UIColor.orange
        
        // SET UP BUTTON
        button.buttonOn = false
        button.addTarget(self, action: #selector(ViewController.buttonPressed), for: .touchUpInside)
        
        // TESTING SPACE

        
        
        
    }
}

