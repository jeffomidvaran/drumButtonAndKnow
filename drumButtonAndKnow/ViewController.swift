//
//  ViewController.swift
//  drumButtonAndKnow
//
//  Created by jeffomidvaran on 3/15/20.
//  Copyright © 2020 jeffomidvaran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var knob: Knob!
    @IBOutlet weak var valueSlider: UISlider!
    @IBAction func handleValueChanged(_ sender: Any) {
         print(knob.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8870931268, green: 0.8731685877, blue: 0.8544336557, alpha: 1)
        knob.lineWidth = 8
        knob.pointerLength = 16
        knob.setValue(0.2)
        knob.addTarget(self,
                       action: #selector(ViewController.handleValueChanged(_:)),
                       for: .valueChanged)

        knob.knobColor = UIColor.darkGray
        knob.pointerColor = UIColor.orange
        
        
        
    }
}

