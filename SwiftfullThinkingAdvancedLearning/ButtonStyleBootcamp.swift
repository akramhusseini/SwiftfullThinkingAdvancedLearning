//
//  ButtonStyleBootcamp.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 03/06/2025.
//

import SwiftUI

struct PressableStyle: ButtonStyle {
    
    let scaledAmount: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaledAmount : 1.0)
//            .brightness(configuration.isPressed ? 0.05: 0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
    }
    
}

extension View {
    
    func withPressableStyle(scaledAmount: CGFloat = 0.95) -> some View {
        buttonStyle(PressableStyle(scaledAmount: scaledAmount))
    }
    
}


struct ButtonStyleBootcamp: View {
    var body: some View {
        Button(action: {
            
        }, label: {
            Text("Click Me")
                .font(.headline)
                .withDefaultButtonFormating()
        })
        .withPressableStyle()
        .padding(40)
    }
}

#Preview {
    ButtonStyleBootcamp()
}
