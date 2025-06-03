//
//  AnyTransistionBootcamp.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 03/06/2025.
//

import SwiftUI

struct rotateViewModifier: ViewModifier {

    
    let rotation: Double
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotation))
            .offset(
                x: rotation != 0 ? UIScreen.main.bounds.width : 0,
                y: rotation != 0 ? UIScreen.main.bounds.height: 0)
            
    }
}

extension AnyTransition {
    
    static var rotating: AnyTransition {
        modifier(
            active: rotateViewModifier(rotation: 180),
            identity: rotateViewModifier(rotation: 0)
        )
    }
    
    static func rotating(rotation: Double) -> AnyTransition {
        modifier(
            active: rotateViewModifier(rotation: rotation),
            identity: rotateViewModifier(rotation: 0)
        )
    }
    
    static var rotateOn: AnyTransition {
        asymmetric(
            insertion: .rotating,
            removal: .move(edge: .leading))
    }
    
}


struct AnyTransistionBootcamp: View {
    
    @State private var showRectangle: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            if showRectangle {
                
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 250, height: 350)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.rotateOn)
            }
            
            Spacer()
            
            Text("Click Me!")
                .withDefaultButtonFormating()
                .padding(.horizontal, 40)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        showRectangle.toggle()
                    }
                }
        }
    }
}

#Preview {
    AnyTransistionBootcamp()
}
