//
//  MatchedGeometryEffetBootcamp.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 03/06/2025.
//

import SwiftUI

struct MatchedGeometryEffetBootcamp: View {
    
    @State private var isclicked: Bool = false
    @Namespace private var nameSpace
    
    var body: some View {
        VStack {
            if !isclicked {
                Circle()
                    .matchedGeometryEffect(id: "rectangle", in: nameSpace)
                    .frame(width: 100, height: 100)
                   
            }
            
            Spacer()
            
            if isclicked {
                Circle()
                    .matchedGeometryEffect(id: "rectangle", in: nameSpace)
                    .frame(width: 300, height: 200)
                   
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
        .onTapGesture {
            withAnimation(.easeInOut) {
                isclicked.toggle()
            }
            
        }
    }
}

#Preview {
    MatchedGeometryEffetExample2()
}

struct MatchedGeometryEffetExample2: View {
    
    let categories: [String] = ["Home", "Popular", "Saved"]
    @State private var selected = ""
    @Namespace private var namespace2
    
    var body: some View {
        HStack {
            ForEach(categories, id: \.self) { category in
                ZStack {
                    if selected == category {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red.opacity(0.5))
                            .matchedGeometryEffect(id: "category_background", in: namespace2)
                            .frame(width: 35, height: 2)
                            .offset(y: 10)
                    }
                    Text(category)
                        .foregroundColor(selected == category ? .red : .black)
                }
                
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .onTapGesture {
                    withAnimation(.spring()) {
                        selected = category
                    }
                }
            }
        }
        .padding()
    }
        
}
