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

