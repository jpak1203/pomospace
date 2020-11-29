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
    @Published var pattern: PomoPatterns = .twentyfive
    @Published var secondsLeft = 1500 //1500 seconds = 25 minutes
    var timer: Timer = Timer()
    var iterations: Int = 0
    var breakTime: Bool = false
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
        print("iteration: " + String(iterations) + " pattern: " + pattern.rawValue)
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            if self.secondsLeft == 0 {
                self.checkIterations()
                self.scheduleNotification()
                if (self.breakTime) { self.stopToBreak() }
                else { self.stopToPomo()}
            } else {
                self.secondsLeft-=1
            }
        })
    }
    
    func stopToPomo() {
        print("iteration: " + String(iterations) + " pattern: " + pattern.rawValue)
        timerMode = .initial
        if (pattern == .twentyfive) { secondsLeft = 1500 }
        else if (pattern == .fifty && iterations % 3 == 0) { secondsLeft = 3000 }
        else { secondsLeft = 15 }
        timer.invalidate()
    }
    
    func stopToBreak() {
        print("iteration: " + String(iterations) + " pattern: " + pattern.rawValue)
        timerMode = .initial
        if (pattern == .fifty && iterations % 3 == 0) { secondsLeft = 600 }
        else if (pattern == .twentyfive && iterations % 4 == 0) { secondsLeft = 600 }
        else { secondsLeft = 300 }
        timer.invalidate()
    }

    func pause() {
        print("iteration: " + String(iterations) + " pattern: " + pattern.rawValue)
        timerMode = .paused
        timer.invalidate()
    }
    
    private func checkIterations() {
        iterations+=1
        if (iterations == 12) { iterations = 0 }
        breakTime.toggle()
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
