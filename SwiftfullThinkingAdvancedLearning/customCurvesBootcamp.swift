//
//  customCurvesBootcamp.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 18/06/2025.
//

import SwiftUI

struct customCurvesBootcamp: View {
    var body: some View {
        WaterShare()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), Color(#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1))]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
//            .stroke(lineWidth: 5)
//            .frame(width: 200, height: 200)
//            .rotationEffect(Angle(degrees: 90))
            .ignoresSafeArea()
    }
}

#Preview {
    customCurvesBootcamp()
}


struct ArcSample: Shape {
    
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addArc(
                center:  CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 40),
                clockwise: true)
//            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
//                path.addArc(
//                    center:  CGPoint(x: rect.midX, y: rect.midY),
//                    radius: rect.height / 2,
//                    startAngle: Angle(degrees: 160),
//                    endAngle: Angle(degrees: 200),
//                    clockwise: false)
            
        }
    }
    
    
}


struct ShapeWithArc: Shape {
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
//            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addArc(
                          center:  CGPoint(x: rect.midX, y: rect.midY),
                          radius: rect.height / 2,
                          startAngle: Angle(degrees: 0),
                          endAngle: Angle(degrees: 180),
                          clockwise: false)
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        }
    }
}



struct QuadSample: Shape {
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.midY),
                control: CGPoint(x: rect.maxX - 50, y: rect.minY - 100)
            )
        }
    }
}

struct WaterShare: Shape {
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.midY),
                control: CGPoint(x: rect.width * 0.25, y: rect.height * 0.40))
                path.addQuadCurve(
                    to: CGPoint(x: rect.maxX, y: rect.midY),
                    control: CGPoint(x: rect.width * 0.75, y: rect.height * 0.60))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
        }
    }
}
