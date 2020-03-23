//
//  SignalGenerator.swift
//  drumButtonAndKnow
//
//  Created by jeffomidvaran on 3/22/20.
//  Copyright © 2020 jeffomidvaran. All rights reserved.
//

import Foundation
import AVFoundation
private let userDefaults = UserDefaults.standard
private var twoPi =  2 * Float.pi

struct OptionNames {
    static let signal = "signal"
    static let frequency = "freq"
    static let duration = "duration"
    static let output = "output"
    static let amplitude = "amplitude"
}

func getFloatForKeyOrDefault(key: String, defaultValue: Float) -> Float {
    let value = userDefaults.float(forKey: key)
    return value > 0.0 ? value : defaultValue
}

struct SignalGenerator {
    private let engine = AVAudioEngine()
    private var mainMixer: AVAudioMixerNode
    private var output: AVAudioOutputNode
    private let outputFormat: AVAudioFormat
    private let sampleRate: Float
    private let inputFormat: AVAudioFormat?
    private var currentPhase: Float
    private let phaseIncrement: Float
    let frequency = getFloatForKeyOrDefault(key: OptionNames.frequency,
                                            defaultValue:  440)
    let amplitude = min(max(getFloatForKeyOrDefault(key: OptionNames.amplitude,
                                                    defaultValue: 0.5), 0.0), 1.0)
    let duration = getFloatForKeyOrDefault(key: OptionNames.duration,
                                           defaultValue: 5.0)
    let outputPath = userDefaults.string(forKey: OptionNames.output)



    init() {
        mainMixer = engine.mainMixerNode
        output = engine.outputNode
        outputFormat = output.inputFormat(forBus: 0)
        sampleRate = Float(outputFormat.sampleRate)
        inputFormat = AVAudioFormat(commonFormat: outputFormat.commonFormat,
                                    sampleRate: outputFormat.sampleRate,
                                    channels: 1,
                                    interleaved: outputFormat.isInterleaved)
        currentPhase = 0
        phaseIncrement = (twoPi / sampleRate) * frequency
    }
    


}

fileprivate struct WaveGenerator {
    static func sine(phase: Float) -> Float {
        return sin(phase)
    }
    
    static func whiteNoise(phase: Float) -> Float {
        return ((Float(arc4random_uniform(UINT32_MAX)) / Float(UINT32_MAX)) * 2 - 1)
    }
    
    static func sawtoothUp(phase: Float) -> Float {
        return 1.0 - 2.0 * (phase * (1.0 / twoPi ))
    }
    
    static func sawtoothDown(phase: Float) -> Float {
        return (2.0 * (phase * (1.0 / twoPi) )) - 1
    }
    
    static func square(phase: Float) -> Float {
        if phase <= Float.pi {
            return 1.0
        } else {
            return -1.0
        }
    }
    
    static func triangle(phase: Float) -> Float{
        var value = (2.0 * (phase * (1.0 / twoPi))) - 1.0
        if value < 0.0 {
            value = -value
        }
        return 2.0 * (value - 0.5)
    }
    
}
