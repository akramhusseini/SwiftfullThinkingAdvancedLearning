//
//  UnitTestingBootcampViewModel.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 01/07/2025.
//

import SwiftUI
import Combine

class UnitTestingBootcampViewModel: ObservableObject {
    
    @Published var isPremuim: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    let dataService: NewDataServiceProtocol
    var cancalables = Set<AnyCancellable>()
    
    init(isPremuim: Bool, dataService: NewDataServiceProtocol = NewMockDataService(items: nil)) {
        self.isPremuim = isPremuim
        self.dataService = dataService
    }
    
    func addItem(item: String) {
        guard !item.isEmpty else { return }
        self.dataArray.append(item)
    }
    
    func selectItem(item: String) {
        if let x = self.dataArray.first(where: {$0 == item}) {
            selectedItem = x
        } else {
            selectedItem = nil
        }
    }
    
    func saveItem(item: String) throws {
        
        guard !item.isEmpty else {
            throw DataError.noData
        }
        
        if let x = dataArray.first(where: { $0 == item}) {
            print("Save item here!!! \(x)")
        } else {
            throw DataError.itemNotFound
        }
        
        
    }
    
    enum DataError: LocalizedError {
        case noData
        case itemNotFound
    }
    
    func downloadWithEscaping() {
        dataService.downloadItemsWithEscaping { [weak self] returnedItems in
            self?.dataArray = returnedItems
        }
    }
    
    func downloadWithCombine() {
        dataService.downloadItemsWithCombine()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedItems in
                self?.dataArray = returnedItems
            }
            .store(in: &cancalables)
    }
    
    
}
