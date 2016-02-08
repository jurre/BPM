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
    var firstPressTime: NSDate!
    var lastPressTime: NSDate!
    var pressCount = 0
    var timer = NSTimer()

    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        gestureRecognizer.delegate = self;
        background.addGestureRecognizer(gestureRecognizer)
        resetTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func handleTap(recognizer: UITapGestureRecognizer) {
        pressCount += 1
        let now = NSDate()
        resetTimer()
        if firstPressTime != nil {
            lastPressTime = now
        } else {
            firstPressTime = now
            lastPressTime = now
        }

        let totalDifference = (lastPressTime.timeIntervalSince1970 - firstPressTime.timeIntervalSince1970)
        let bpm = Double(pressCount - 1) / (totalDifference / 60.0)

        updateView(bpm)
    }

    func reset() {
        pressCount = 0
        firstPressTime = nil
        lastPressTime = nil
    }

    @IBAction func resetButtonTapped(sender: AnyObject) {
        reset()
        updateView(0)
    }

    func resetTimer() {
        timer.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "reset", userInfo: nil, repeats: true)
    }

    func updateView(bpm: Double) {
        var bpmValue = "-"
        
        if bpm > 0 {
            bpmValue = String(format: "%.0f", bpm)
        }
        
        bpmLabel.text = bpmValue
        beatCountLabel.text = "\(pressCount) beats"
    }
}
