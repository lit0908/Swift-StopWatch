//
//  ViewController.swift
//  StopWatch
//
//  Created by Tong Li on 30/04/2015.
//  Copyright (c) 2015 Tong Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = NSTimer()
    var startTime = NSTimeInterval()
    var accumulatedTime = NSTimeInterval()
    
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var playOrPauseButton: UIButton!

    @IBAction func stop(sender: UIButton) {
        
        timer.invalidate()
        
        // reset accumulatedTime and label text
        accumulatedTime = 0.0
        timerLabel.text = "00:00:00"
        
        // reset Play Button image and selected status
        playOrPauseButton.selected = false
    }
    
    @IBAction func playOrPause(sender: UIButton) {
        
        // The button show "Play" image when selected == true
        // while as the button show "Pause" image when selected == false
        if !sender.selected {
            
            // Reset startTime
            startTime = NSDate.timeIntervalSinceReferenceDate()
            
            // Triggering Play button action
            if !timer.valid {
                timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
            }
            
            // Change to Pause button
            sender.selected = true
        } else {
            // Triggering Pause button action
            timer.invalidate()
            
            // Save up elapsed time
            var currentTime = NSDate.timeIntervalSinceReferenceDate()
            accumulatedTime += currentTime - startTime
            
            // Change to Play button
            sender.selected = false
        }
    }
    
    // Callback from NSTimer to update the time
    func updateTime() {
        
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        // Get the different between the currentTime and startTime
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        // Addes up accumulatedTime
        elapsedTime += accumulatedTime
        
        // Calculate the minutes
        let minutes = UInt8(elapsedTime/60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        // Calculate the seconds
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        // Find out the fraction part
        let fraction = UInt8(elapsedTime * 100)
        
        // Add the leading zeros if neccessary
        let strMinutes = minutes > 9 ? String(minutes):"0" + String(minutes)
        let strSeconds = seconds > 9 ? String(seconds):"0" + String(seconds)
        let strFraction = fraction > 9 ? String(fraction):"0" + String(fraction)
        
        // Concatenate to make the final string
        timerLabel.text = "\(strMinutes):\(strSeconds):\(strFraction)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setup startTime and elapsedTime
        startTime = NSDate.timeIntervalSinceReferenceDate()
        accumulatedTime = 0.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

