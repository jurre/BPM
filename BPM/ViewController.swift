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

    var counter = BPMCounter()

    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:)))
        gestureRecognizer.delegate = self;
        background.addGestureRecognizer(gestureRecognizer)
        counter.resetTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func handleTap(_ recognizer: UITapGestureRecognizer) {
        counter.beat()

        updateView()
    }

    @IBAction func resetButtonTapped(_ sender: AnyObject) {
        counter.reset()
        updateView()
    }

    func updateView() {
        var bpmValue = "-"
        var bpmPreciseValue = "-"
        
        if counter.bpm > 0 && counter.beatCount > 3 {
            bpmValue = String(format: "%.0f", counter.bpm)
            bpmPreciseValue = String(format: "%.2f", counter.bpm)
        }
        
        bpmLabel.text = bpmValue
        bpmPreciseLabel.text = bpmPreciseValue
        beatCountLabel.text = "\(counter.beatCount) beats"
    }
}
