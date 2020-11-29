//
//  MeditationView.swift
//  pomospace
//
//  Created by Justin Pak on 11/28/20.
//  Copyright © 2020 Justin Pak. All rights reserved.
//

import SwiftUI
import AVFoundation
var audioPlayer: AVAudioPlayer!

struct MeditationView: View {
    @Binding var meditationLength: MeditationLength
    @State var isPlaying: Bool = false
    @State var playIndex: Int = 0
    
    var body: some View {
        VStack {
            Text("Try Meditating!")
                .font(.headline)
                .padding(.bottom, 2)
            Text("How long do you want to meditate for:")
        }
        .padding()
        
        HStack {
            RadioButtonField(text: "5-minutes", isOn: binding(for: .fiveMin))
            RadioButtonField(text: "10-minutes", isOn: binding(for: .tenMin))
        }
        
        HStack {
            Button(action: {
                print("Rewinding..")
                playIndex-=1
                if meditationLength == .fiveMin && playIndex < 0 {
                    playIndex = fiveMinuteMeditation.count-1
                } else if meditationLength == .tenMin && playIndex < 0 {
                    playIndex = tenMinuteMeditation.count-1
                }
                initAudioPlayer()
                if isPlaying { audioPlayer.play() }
            }) {
                if #available(OSX 11.0, *) {
                    Image(systemName: "backward.fill")
                        .resizable()
                        .frame(width: 16, height: 16)
                } else {
                    Text("Back")
                }
            }
            .buttonStyle(MusicButtonStyle())
            
            if isPlaying {
                Button(action: {
                    print("Pausing...")
                    audioPlayer.pause()
                    self.isPlaying.toggle()
                }) {
                    if #available(OSX 11.0, *) {
                        Image(systemName: "pause.fill")
                            .resizable()
                            .frame(width: 16, height: 16)
                    } else {
                        Text("Pause")
                    }
                }
                .buttonStyle(MusicButtonStyle())
            } else {
                Button(action: {
                    print("Playing.. \(playIndex)")
                    if audioPlayer == nil {
                        initAudioPlayer()
                    }
                    audioPlayer.play()
                    self.isPlaying.toggle()
                }) {
                    if #available(OSX 11.0, *) {
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 16, height: 16)
                    } else {
                        Text("Play")
                    }
                }
                .buttonStyle(MusicButtonStyle())
            }
            
            Button(action: {
                print("Skipping..")
                playIndex+=1
                if (meditationLength == .fiveMin && playIndex >= fiveMinuteMeditation.count) || (meditationLength == .tenMin && playIndex >= tenMinuteMeditation.count)  {
                    playIndex = 0
                }
                initAudioPlayer()
                if isPlaying { audioPlayer.play() }
            }) {
                if #available(OSX 11.0, *) {
                    Image(systemName: "forward.fill")
                        .resizable()
                        .frame(width: 16, height: 16)
                } else {
                    Text("Forward")
                }
            }
            .buttonStyle(MusicButtonStyle())
        }
        .padding()
    }
    
    private func binding(for length: MeditationLength) -> Binding<Bool> {
        Binding<Bool>(
            get: { self.meditationLength == length },
            set: { flag in
                if flag {
                    self.meditationLength = length
                    if isPlaying { audioPlayer.stop() }
                    self.playIndex = 0
                    self.isPlaying = false
                    initAudioPlayer()
                    print("meditation length: \(self.meditationLength)")
                }
            }
        )
    }
    
    private func initAudioPlayer() {
        do {
            if meditationLength == .tenMin { audioPlayer = try AVAudioPlayer(contentsOf: getURL(soundFile: tenMinuteMeditation[playIndex])) }
            else if meditationLength == .fiveMin { audioPlayer = try AVAudioPlayer(contentsOf: getURL(soundFile: fiveMinuteMeditation[playIndex])) }
        } catch {
            print(error)
        }
    }
}

struct MusicButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .some(150))
            .foregroundColor(.white)
            .background(Color.clear)
            .padding(.horizontal, 5)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}
