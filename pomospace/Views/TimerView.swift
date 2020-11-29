//
//  TimerView.swift
//  pomospace
//
//  Created by Justin Pak on 11/28/20.
//  Copyright © 2020 Justin Pak. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var timerManager: TimerManager
    
    var body: some View {
        VStack {
            Text(secondsToMinutesAndSeconds(seconds: timerManager.secondsLeft))
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .font(.title)
            switch (timerManager.timerMode) {
            case .initial:
                Button(action: {
                    timerManager.start()
                }) {
                    Text("Start")
                        .font(.headline)
                }
                .buttonStyle(AccentBackgroundStyle())
            case .running:
                HStack {
                    Button(action: {
                        timerManager.pause()
                    }) {
                        Text("Pause")
                            .font(.headline)
                    }
                    .buttonStyle(AccentBackgroundStyle())
                    
                    Button(action: {
                        timerManager.stopToPomo()
                    }) {
                        Text(timerManager.breakTime ? "Skip" : "Stop")
                            .font(.headline)
                    }
                    .buttonStyle(SecondaryBackgroundStyle())
                }
            case .paused:
                HStack {
                    Button(action: {
                        timerManager.start()
                    }) {
                        Text("Resume")
                            .font(.headline)
                    }
                    .buttonStyle(AccentBackgroundStyle())
                    
                    Button(action: {
                        timerManager.stopToPomo()
                    }) {
                        Text(timerManager.breakTime ? "Skip" : "Stop")
                            .font(.headline)
                    }
                    .buttonStyle(SecondaryBackgroundStyle())
                }
            }
        }
        .padding(.bottom)
    }
}

struct AccentBackgroundStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .some(150))
            .padding()
            .foregroundColor(.white)
            .background(configuration.isPressed ? Color.secondary : Color.accentColor)
            .cornerRadius(40)
            .padding(.horizontal, 5)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct SecondaryBackgroundStyle: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .some(150))
            .padding()
            .foregroundColor(.white)
            .background(configuration.isPressed ? Color.primary : Color.secondary)
            .cornerRadius(40)
            .padding(.horizontal, 5)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}
