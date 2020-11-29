//
//  RadioButtonField.swift
//  pomospace
//
//  Created by Justin Pak on 11/27/20.
//  Copyright © 2020 Justin Pak. All rights reserved.
//

import SwiftUI


struct RadioButtonField: View {
    let text: String
    @Binding var isOn: Bool
    
    var body: some View {
        Button(action: {
            self.isOn.toggle()
        }) {
            HStack(alignment: .top) {
                Circle()
                    .fill(isOn ? Color.primary : Color.clear)
                    .overlay(Circle().stroke(Color.primary))
                    .frame(width: 18, height: 18)
                Text(text)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(RadioButtonStyle())
    }
}

struct RadioButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .border(SeparatorShapeStyle(), width: 0)
            .background(Color.clear)
    }
}
