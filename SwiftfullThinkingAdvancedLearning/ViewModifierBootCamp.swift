//
//  ViewModifierBootCamp.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 03/06/2025.
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
           
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
    }
    
}

extension View {
    
    func withDefaultButtonFormating(backgroundColor: Color = .blue) -> some View {
        modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor))
    }
    
}

struct ViewModifierBootCamp: View {

    var body: some View {
        VStack(spacing: 10) {
            Text("Hello World")
                .font(.headline)
                .withDefaultButtonFormating(backgroundColor: .blue)
            
            Text("Hello Everyone")
                .font(.subheadline)
                .withDefaultButtonFormating(backgroundColor: .orange)
            
            Text("Hello!!!")
                .font(.title)
                .withDefaultButtonFormating(backgroundColor: .pink)
        }
        .padding()
    }
}

#Preview {
    ViewModifierBootCamp()
}
