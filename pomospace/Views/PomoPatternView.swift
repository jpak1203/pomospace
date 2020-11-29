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
    @Binding var pattern: PomoPatterns
    
    var body: some View {
        HStack {
            RadioButtonField(text: "25-25-25-25", isOn: binding(for: .twentyfive))
            RadioButtonField(text: "25-25-50", isOn: binding(for: .fifty))
        }
    }
    
    private func binding(for pattern: PomoPatterns) -> Binding<Bool> {
        Binding<Bool>(
            get: { self.pattern == pattern },
            set: { flag in
                if flag {
                    self.pattern = pattern
                    self.timerManager.pattern = pattern
                    self.timerManager.iterations = 0
                    print("iteration: \(timerManager.iterations) pattern: \(pattern.rawValue)")
                }
            }
        )
    }
}
