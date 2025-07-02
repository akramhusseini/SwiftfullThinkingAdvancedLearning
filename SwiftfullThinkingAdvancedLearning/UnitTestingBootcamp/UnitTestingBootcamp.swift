//
//  UnitTestingBootcamp.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 01/07/2025.
//

import SwiftUI

/*
 1 Unit Tests
 - test business logic
 
 2. UI Tests
 tests the UI of your app
 
 */


struct UnitTestingBootcamp: View {
    
    @StateObject private var vm: UnitTestingBootcampViewModel
    
    init(isPremuim: Bool) {
        _vm = StateObject(wrappedValue: UnitTestingBootcampViewModel(isPremuim: isPremuim))
    }
    
    var body: some View {
        Text(vm.isPremuim.description)
    }
}

#Preview {
    UnitTestingBootcamp(isPremuim: true)
}
