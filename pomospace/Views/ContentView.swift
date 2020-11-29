//
//  ContentView.swift
//  pomospace
//
//  Created by Justin Pak on 11/26/20.
//  Copyright © 2020 Justin Pak. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var timerManager = TimerManager()
    @State var pomoPattern: PomoPatterns = .twentyfive
    @State var breakPattern: BreakPatterns = .five
    @State var timerMode: TimerMode = .initial
    @State var meditationLength: MeditationLength = .fiveMin
    
    var body: some View {
        VStack {
            Text(timerManager.breakTime ? "How long do you want to rest:" : "How long do you want to focus for:")
                .font(.headline)
                .padding()
            PomoPatternView(timerManager: timerManager, pomoPattern: $pomoPattern, breakPattern: $breakPattern)
            TimerView(timerManager: timerManager)
            Text(timerManager.iterations > 0 ? "Your Pomostreak is at: \(timerManager.iterations)" : "")
            Divider()
            MeditationView(meditationLength: $meditationLength)
            
        }.padding()
    }
}
