//
//  CustomNavBarPreferenceKeys.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 29/06/2025.
//

//@State private var shoBackButton: Bool = true
//@State private var title: String = "Title"//""
//@State private var subTitle: String? = "subTitle"//nil

import Foundation
import SwiftUI

struct CustomNavBarTitlePreferenceKey: PreferenceKey {
   
    static let defaultValue: String = ""
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

struct CustomNavBarSubTitlePreferenceKey: PreferenceKey {
   
    static let defaultValue: String? = nil
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

struct CustomNavBarBackButtonHiddenPreferenceKey: PreferenceKey {
   
    static let defaultValue: Bool = false
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

extension View {
//    .navigationTitle("Title 2")
//    .navigationBarBackButtonHidden(true),
    
    func customNavigationTitle(_ title: String) -> some View {
        self.preference(key: CustomNavBarTitlePreferenceKey.self, value: title)
    }
    
    func customNavigationSubTitle(_ subTitle: String?) -> some View {
        self.preference(key: CustomNavBarSubTitlePreferenceKey.self, value: subTitle)
    }
    
    func customNavigationBarBackButtonHidden(_ hidden: Bool) -> some View {
        self.preference(key: CustomNavBarBackButtonHiddenPreferenceKey.self, value: hidden)
    }
    
    func customNavBarItems(title: String = "", subTitle: String? = nil, backButtonHidden: Bool = false) -> some View {
        self
            .customNavigationTitle(title)
            .customNavigationSubTitle(subTitle)
            .customNavigationBarBackButtonHidden(backButtonHidden)
    }
    
}
