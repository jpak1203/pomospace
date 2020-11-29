//
//  PomoPattern.swift
//  pomospace
//
//  Created by Justin Pak on 11/27/20.
//  Copyright © 2020 Justin Pak. All rights reserved.
//

import SwiftUI

enum PomoPatterns: String, CaseIterable, Codable, Hashable {
    case twentyfive = "25-25-25-25"
    case fifty = "25-25-50"
}

enum TimerMode {
    case running
    case paused
    case initial
}

func secondsToMinutesAndSeconds(seconds: Int) -> String {
    let minutes = "\((seconds % 3600) / 60)"
    let seconds = "\((seconds % 3600) % 60)"
    let minuteStamp = minutes.count > 1 ? minutes : "0" + minutes
    let secondStamp = seconds.count > 1 ? seconds : "0" + seconds
    
    return "\(minuteStamp):\(secondStamp)"
}

enum MeditationLength {
    case fiveMin
    case tenMin
}

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
