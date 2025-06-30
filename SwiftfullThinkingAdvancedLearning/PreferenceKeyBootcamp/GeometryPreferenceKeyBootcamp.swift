//
//  GeometryPreferenceKeyBootcamp.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 22/06/2025.
//

import SwiftUI

struct GeometryPreferenceKeyBootcamp: View {
    
    @State private var rectSize: CGSize = .zero
    
    var body: some View {
        VStack {
            
            Text("Hello World!")
                .frame(width: rectSize.width, height: rectSize.height)
                .background(Rectangle().fill(Color.blue))
                .frame(maxWidth: .infinity)
            
            
            Spacer()
            HStack {
                Rectangle()
                
                GeometryReader { geo in
                    Rectangle()
                        .updateRectableGeoSize(geo.size)
                }
                Rectangle()
            }
            .frame(height: 55)
        }
        .onPreferenceChange(RectanleGeometrySizePreferenceKey.self, perform: { value in
            self.rectSize = value
        })
    }
}

#Preview {
    GeometryPreferenceKeyBootcamp()
}

extension View {
    func updateRectableGeoSize(_ size: CGSize) -> some View {
        preference(key: RectanleGeometrySizePreferenceKey.self, value: size)
    }
}

struct RectanleGeometrySizePreferenceKey: PreferenceKey {
    
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}
