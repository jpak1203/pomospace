//
//  PomoPattern.swift
//  pomospace
//
//  Created by Justin Pak on 11/27/20.
//  Copyright © 2020 Justin Pak. All rights reserved.
//

import SwiftUI

enum PomoPatterns: Int {
    case twentyfive = 15
    case fifty = 30
}

enum BreakPatterns: Int {
    case five = 3
    case ten = 6
    case twenty = 12
    case thirty = 18
}

enum TimerMode {
    case running
    case paused
    case initial
}

enum MeditationLength {
    case fiveMin
    case tenMin
}

func secondsToMinutesAndSeconds(seconds: Int) -> String {
    let minutes = "\((seconds % 3600) / 60)"
    let seconds = "\((seconds % 3600) % 60)"
    let minuteStamp = minutes.count > 1 ? minutes : "0" + minutes
    let secondStamp = seconds.count > 1 ? seconds : "0" + seconds
    
    return "\(minuteStamp):\(secondStamp)"
}

// All audio tracks are taken from Creative Commons
var fiveMinuteMeditation = ["LifeHappens5MinuteBreathing",
                            "MARC5MinuteBreathing",
                            "PadraigBriefMindfulnessPractice",
                            "StillMind4MinuteBodyScan",
                            "VidyamalaBreathingSpace",
                            "VidyamalaTensionRelease"]

var tenMinuteMeditation = ["FreeMindfulness10MinuteBreathing",
                            "MARCBreathSoundBodyMeditation",
                            "PadraigTenMinuteMindfulnessOfBreathing",
                            "UCSD10MinuteWisdom"]

func getURL(soundFile: String) -> URL {
    let path = Bundle.main.path(forResource: soundFile, ofType:"mp3")!
    let url = URL(fileURLWithPath: path)
    return url
}

func shuffleMeditationTracks() {
    fiveMinuteMeditation.shuffle()
    tenMinuteMeditation.shuffle()
}
