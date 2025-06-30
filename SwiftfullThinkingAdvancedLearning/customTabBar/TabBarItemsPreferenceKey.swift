//
//  TabBarItemsPreferenceKey.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 23/06/2025.
//

import Foundation
import SwiftUI

struct TabBarItemsPrefeterenceKey: PreferenceKey {
    
    static var defaultValue: [TabBarItem] = []
    
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
        value += nextValue()
    }
    
}

struct TabbarItemViewModifier: ViewModifier {
    
    let tab: TabBarItem
    @Binding var seleciton: TabBarItem
    
    func body(content: Content) -> some View {
        content
            .opacity(seleciton == tab ? 1.0 : 0.0)
            .preference(key: TabBarItemsPrefeterenceKey.self, value: [tab])
    }
    
}


extension View {
    
    func tabBarItem(tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
        modifier(TabbarItemViewModifier(tab: tab, seleciton: selection))
    }
    
}
