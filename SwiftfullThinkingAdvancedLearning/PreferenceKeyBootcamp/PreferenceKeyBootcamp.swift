//
//  PreferenceKeyBootcamp.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 22/06/2025.
//

import SwiftUI

struct PreferenceKeyBootcamp: View {
    
    @State private var text: String = "Hello World!"
    
    var body: some View {
        NavigationView {
            VStack {
                SecendaryScreen(text: text)
                 
            }
            .navigationTitle(Text("Navigation Title"))
            .customTitle("NEW VALUE")
        }
        .onPreferenceChange(CustomTitlePreferenceKey.self, perform: {
            value in
            self.text = value
        })
    }
}



extension View {
    
    func customTitle(_ text: String) -> some View {
        self.preference(key: CustomTitlePreferenceKey.self, value: text)
    }
}

#Preview {
    PreferenceKeyBootcamp()
}

struct SecendaryScreen: View {
    let text: String
    @State private var newValue: String = ""
    
    var body: some View {
        Text(text)
            .onAppear(perform: getDataFromDatabase)
    }
    
    func getDataFromDatabase() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.newValue = "NEW VALUE FROM DATABASE"
        }
    }
}
 

struct CustomTitlePreferenceKey: PreferenceKey {
    
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
    
    
}
