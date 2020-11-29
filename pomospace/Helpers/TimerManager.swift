//
//  TimerHelper.swift
//  pomospace
//
//  Created by Justin Pak on 11/28/20.
//  Copyright © 2020 Justin Pak. All rights reserved.
//

import Foundation
import SwiftUI
import UserNotifications

class TimerManager: ObservableObject {
    @Published var timerMode: TimerMode = .initial
    @Published var pomoPattern: PomoPatterns = .twentyfive
    @Published var breakPattern: BreakPatterns = .five
    @Published var secondsLeft = PomoPatterns.twentyfive.rawValue
    @Published var breakTime: Bool = false
    
    var timer: Timer = Timer()
    var iterations: Int = 0
    let center = UNUserNotificationCenter.current()
    
    init() {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
    }

    func start() {
        print("iteration: \(iterations) timeLeft: \(secondsToMinutesAndSeconds(seconds: secondsLeft))")
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            if self.secondsLeft == 0 {
                self.breakTime.toggle()
                self.scheduleNotification()
                if (self.breakTime) {
                    self.iterations+=1
                    self.stopToBreak()
                }
                else { self.stopToPomo()}
            } else {
                self.secondsLeft-=1
            }
        })
    }
    
    func stopToPomo() {
        print("iteration: \(iterations) timeLeft: \(secondsToMinutesAndSeconds(seconds: secondsLeft))")
        timerMode = .initial
        breakTime = false
        secondsLeft = pomoPattern.rawValue
        timer.invalidate()
    }
    
    func stopToBreak() {
        print("iteration: \(iterations) timeLeft: \(secondsToMinutesAndSeconds(seconds: secondsLeft))")
        timerMode = .initial
        secondsLeft = breakPattern.rawValue
        timer.invalidate()
    }

    func pause() {
        print("iteration: \(iterations) timeLeft: \(secondsToMinutesAndSeconds(seconds: secondsLeft))")
        timerMode = .paused
        timer.invalidate()
    }
    
    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        if (breakTime) {
            content.title = "Time to take a break!"
            content.body = "Take a few minutes to rest your mind. You could even try meditating."
        } else {
            content.title = "Back to work!"
            content.body = "Break time's over. Back on the grind!"
        }
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
}
