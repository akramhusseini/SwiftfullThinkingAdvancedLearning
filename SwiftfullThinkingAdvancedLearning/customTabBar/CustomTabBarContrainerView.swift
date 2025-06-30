//
//  CustomTabBarContrainerView.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 23/06/2025.
//

import SwiftUI

struct CustomTabBarContrainerView<Content: View>: View {
    
    @Binding var selection: TabBarItem
    let content: Content
    @State private var tabs: [TabBarItem] = []
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            content
                .ignoresSafeArea()
            CustomTabbarView(tabs: tabs, seleciton: $selection, localSelection: selection)
        }
        .onPreferenceChange(TabBarItemsPrefeterenceKey.self) { value in
            self.tabs = value
        }
    }
    
}

#Preview {
    
    let tabs: [TabBarItem] = [
        .home, .favorites, .profile, .more
    ]
    
    CustomTabBarContrainerView(selection: .constant(tabs.first!)) {
        Color.red
    }
}
