//
//  MeditationHelper.swift
//  pomospace
//
//  Created by Justin Pak on 11/28/20.
//  Copyright © 2020 Justin Pak. All rights reserved.
//

import Foundation

class MeditationHelper {

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
    
    func getRandomSoundFile(soundArray: Array<String>) -> URL {
        let randIndex = Int.random(in: 0..<soundArray.count)
        let path = Bundle.main.path(forResource: soundArray[randIndex], ofType:"mp3")!
        let url = URL(fileURLWithPath: path)
        return url
    }
}
