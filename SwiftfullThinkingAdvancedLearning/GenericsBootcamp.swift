//
//  GenericsBootcamp.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 18/06/2025.
//

import SwiftUI

struct StringModel {
    let info: String?
    func removeInfo() -> StringModel {
        StringModel(info: nil)
    }
}

struct BoolModel {
    let info: Bool?
    func removeInfo() -> BoolModel {
        BoolModel(info: nil)
    }
}

struct GenericModel<T> {
    let info: T?
    func removeInfo() -> GenericModel<T> {
        GenericModel(info: nil)
    }
}

class GenericsViewModel: ObservableObject {
    @Published var stringModel = StringModel(info: "Hello World!")
    @Published var boolModel = BoolModel(info: true)
    @Published var genericsStringModel = GenericModel(info: "Hello World")
    @Published var genericsBoolModel = GenericModel(info: true)
    
    func removeData() {
        stringModel = stringModel.removeInfo()
        boolModel = boolModel.removeInfo()
        genericsStringModel = genericsStringModel.removeInfo()
        genericsBoolModel = genericsBoolModel.removeInfo()
    }
}

struct GenericView<T: View>: View {
    
    let content: T
    
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
            content
        }
    }
    
}

struct GenericsBootcamp: View {
    
    @StateObject private var vm = GenericsViewModel()
    
    var body: some View {
        VStack {
            GenericView(content: Text("custom content"), title: "new view!")
            //GenericView(title: "New view")
            
            Text(vm.stringModel.info ?? "no data")
            Text(vm.boolModel.info?.description ?? "no data")
            Text(vm.genericsStringModel.info ?? "no data")
            Text(vm.genericsBoolModel.info?.description ?? "no data")
        }
        .onTapGesture {
            vm.removeData()
        }
    }
}

#Preview {
    GenericsBootcamp()
}
