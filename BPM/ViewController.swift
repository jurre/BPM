//
//  ViewController.swift
//  BPM
//
//  Created by Jurre Stender on 08/02/16.
//  Copyright © 2016 jurre. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var beatCountLabel: UILabel!
    @IBOutlet weak var bpmPreciseLabel: UILabel!

    var firstPressTime: Date!
    var lastPressTime: Date!
    var beatCount = 0
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:)))
        gestureRecognizer.delegate = self;
        background.addGestureRecognizer(gestureRecognizer)
        resetTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func handleTap(_ recognizer: UITapGestureRecognizer) {
        beatCount += 1
        let now = Date()
        resetTimer()
        if firstPressTime != nil {
            lastPressTime = now
        } else {
            firstPressTime = now
            lastPressTime = now
        }

        let totalDifference = (lastPressTime.timeIntervalSince1970 - firstPressTime.timeIntervalSince1970)
        let bpm = Double(beatCount - 1) / (totalDifference / 60.0)

        updateView(bpm)
    }

    func reset() {
        beatCount = 0
        firstPressTime = nil
        lastPressTime = nil
    }

    @IBAction func resetButtonTapped(_ sender: AnyObject) {
        reset()
        updateView(0)
    }

    func resetTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(ViewController.reset), userInfo: nil, repeats: true)
    }

    func updateView(_ bpm: Double) {
        var bpmValue = "-"
        var bpmPreciseValue = "-"
        
        if bpm > 0 && beatCount > 4 {
            bpmValue = String(format: "%.0f", bpm)
            bpmPreciseValue = String(format: "%.2f", bpm)
        }
        
        bpmLabel.text = bpmValue
        bpmPreciseLabel.text = bpmPreciseValue
        beatCountLabel.text = "\(beatCount) beats"
    }
}
