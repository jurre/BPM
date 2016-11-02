//
//  BPMCounter.swift
//  BPM
//
//  Created by Jurre Stender on 02/11/2016.
//  Copyright © 2016 jurre. All rights reserved.
//

import Foundation

class BPMCounter {
    private var firstBeatTime: Date!
    private var lastBeatTime: Date!
    public var beatCount = 0
    private var timer = Timer()
    public var bpm = 0.0

    public func beat() {
        beatCount += 1
        let now = Date()
        resetTimer()
        if firstBeatTime != nil {
            lastBeatTime = now
        } else {
            firstBeatTime = now
            lastBeatTime = now
        }

        let totalDifference =
            lastBeatTime.timeIntervalSince1970 - firstBeatTime.timeIntervalSince1970
        self.bpm = Double(beatCount - 1) / (totalDifference / 60.0)
    }

    func resetTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(
            timeInterval: 2.0,
            target: self,
            selector: #selector(BPMCounter.reset),
            userInfo: nil,
            repeats: true
        )
    }

    @objc func reset() {
        beatCount = 0
        firstBeatTime = nil
        lastBeatTime = nil
    }
}
