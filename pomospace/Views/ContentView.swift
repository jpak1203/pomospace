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
    @State var pattern: PomoPatterns = .twentyfive
    @State var timerMode: TimerMode = .initial
    @State var meditationLength: MeditationLength = .fiveMin
    
    var body: some View {
        VStack {
            Text("Select a Pattern:")
                .font(.headline)
            PomoPatternView(timerManager: timerManager, pattern: $pattern)
            TimerView(timerManager: timerManager)
            Divider()
            MeditationView(meditationLength: $meditationLength)
            
        }.padding()
    }
}
