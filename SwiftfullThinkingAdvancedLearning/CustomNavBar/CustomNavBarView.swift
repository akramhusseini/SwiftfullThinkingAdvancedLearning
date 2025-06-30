//
//  CustomNavBarView.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 25/06/2025.
//

import SwiftUI

struct CustomNavBarView: View {
    
    @Environment(\.dismiss) var dismiss
    let shoBackButton: Bool
    let title: String
    let subTitle: String?
    
    var body: some View {
        HStack {
            if shoBackButton {
                backButton
            }
            Spacer()
            titleSection
            Spacer()
            if shoBackButton {
                backButton
                    .opacity(0)
            }
            
        }
        .padding()
        .accentColor(.white)
        .foregroundColor(.white)
        .font(.headline)
        .background(
            Color.blue.ignoresSafeArea(edges: .top)
        )
    }
}

#Preview {
    CustomNavBarView(
        shoBackButton: true,
        title: "Title here",
        subTitle: "subtitle goes here"
    )
    Spacer()
}

extension CustomNavBarView {
    
    private var backButton: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "chevron.left")
        })
    }
    
    private var titleSection: some View {
        
        VStack(spacing: 4) {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
            if let subTitle {
                Text(subTitle)
            }
        }
        
    }
    
}
