//
//  CustomNavLink.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 29/06/2025.
//

import SwiftUI

struct CustomNavLink<Label: View, Destination: View>: View {
    
    
    let destination: Destination
    let label: Label
    
    init(destination: Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
        
    }

    
    var body: some View {
        NavigationLink(
            destination: CustomNavBarContainerView(content: {
                destination
            })
            .navigationBarHidden(true)
            ,
            label: {
                label
            })
    }
}

#Preview {
    CustomNavView {
        CustomNavLink(
            destination: Text("Destination")) {
                Text("CLICK ME")
            }
    }
}
