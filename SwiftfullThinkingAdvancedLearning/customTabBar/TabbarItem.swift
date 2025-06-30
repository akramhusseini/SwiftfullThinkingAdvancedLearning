//
//  TabbarItem.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 23/06/2025.
//

import Foundation
import SwiftUI

//struct TabBaerItem: Hashable {
//    let iconName: String
//    let title: String
//    let color: Color
//}

enum TabBarItem: Hashable {
    case home, favorites, profile, more
    
    var iconName: String {
        switch self {
        case .home: return "house"
        case .favorites: return "heart"
        case .profile: return "person"
        case .more: return "ellipsis.circle"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .favorites: return "Favorites"
        case .profile: return "Profile"
        case .more: return "More"
        }
    }
    
    
    var color: Color {
        switch self {
        case .home: return .red
        case .favorites: return .blue
        case .profile: return .green
        case .more: return .yellow
        }
    }
    
}

