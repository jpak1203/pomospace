//
//  PomoPatternView.swift
//  pomospace
//
//  Created by Justin Pak on 11/27/20.
//  Copyright © 2020 Justin Pak. All rights reserved.
//

import SwiftUI

struct PomoPatternView: View {
    @ObservedObject var timerManager: TimerManager
    @Binding var pomoPattern: PomoPatterns
    @Binding var breakPattern: BreakPatterns
    
    var body: some View {
        HStack {
            if timerManager.breakTime {
                RadioButtonField(text: "5", isOn: bindingBreak(for: .five))
                RadioButtonField(text: "10", isOn: bindingBreak(for: .ten))
                RadioButtonField(text: "20", isOn: bindingBreak(for: .twenty))
                RadioButtonField(text: "30", isOn: bindingBreak(for: .thirty))
            } else {
                RadioButtonField(text: "25", isOn: bindingPomo(for: .twentyfive))
                RadioButtonField(text: "50", isOn: bindingPomo(for: .fifty))
            }
        }
    }
    
    private func bindingPomo(for pomoPattern: PomoPatterns) -> Binding<Bool> {
        Binding<Bool>(
            get: { self.pomoPattern == pomoPattern },
            set: { flag in
                if flag {
                    self.pomoPattern = pomoPattern
                    self.timerManager.pomoPattern = pomoPattern
                    self.timerManager.secondsLeft = pomoPattern.rawValue
                    print("iteration: \(timerManager.iterations) pattern: \(String(pomoPattern.rawValue))")
                }
            }
        )
    }
    
    private func bindingBreak(for breakPattern: BreakPatterns) -> Binding<Bool> {
        Binding<Bool>(
            get: { self.breakPattern == breakPattern },
            set: { flag in
                if flag {
                    self.breakPattern = breakPattern
                    self.timerManager.breakPattern = breakPattern
                    self.timerManager.secondsLeft = breakPattern.rawValue
                    print("iteration: \(timerManager.iterations) pattern: \(String(breakPattern.rawValue))")
                }
            }
        )
    }
}
