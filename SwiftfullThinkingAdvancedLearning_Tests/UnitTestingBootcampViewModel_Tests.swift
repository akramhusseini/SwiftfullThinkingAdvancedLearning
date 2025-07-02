//
//  UnitTestingBootcampViewModel_Tests.swift
//  SwiftfullThinkingAdvancedLearning_Tests
//
//  Created by Akram Husseini on 01/07/2025.
//

import XCTest
import Combine
@testable import SwiftfullThinkingAdvancedLearning

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct or class]_[variable or function]_[expected result]

// Testing Structure: Given, When, Then

final class UnitTestingBootcampViewModel_Tests: XCTestCase {

    var viewModel: UnitTestingBootcampViewModel?
    var cancellables: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = UnitTestingBootcampViewModel(isPremuim: Bool.random())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func test_UnitTestingBootcampViewModel_IsPremuim_shouldBeTrue() {
        // given
        let userIsPremuim: Bool = true
        // when
        let vm = UnitTestingBootcampViewModel(isPremuim: userIsPremuim)
        // then
        XCTAssertTrue(vm.isPremuim)
    }

    func test_UnitTestingBootcampViewModel_IsPremuim_shouldBeFalse() {
        // given
        let userIsPremuim: Bool = false
        // when
        let vm = UnitTestingBootcampViewModel(isPremuim: userIsPremuim)
        // then
        XCTAssertFalse(vm.isPremuim)
    }
    
    func test_UnitTestingBootcampViewModel_IsPremuim_shouldBeInjectedValue() {
        // given
        let userIsPremuim: Bool = Bool.random()
        // when
        let vm = UnitTestingBootcampViewModel(isPremuim: userIsPremuim)
        // then
        XCTAssertEqual(vm.isPremuim, userIsPremuim)
    }
    
    func test_UnitTestingBootcampViewModel_IsPremuim_shouldBeInjectedValue_allPossibleValues() {
        // given
        let boolValues = (0...1).map { $0 == 1 }
        for value in boolValues {
            // when
            let vm = UnitTestingBootcampViewModel(isPremuim: value)
            test_UnitTestingBootcampViewModel_IsPremuim_shouldBeInjectedValue()
            // then
            XCTAssertEqual(vm.isPremuim, value, "expected isPremuim to be \(value)")
        }
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldBeEmpty() {
        //given
        
        // when
        let vm = UnitTestingBootcampViewModel(isPremuim: Bool.random())
        // then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldAddItem() {
        //given
        let vm = UnitTestingBootcampViewModel(isPremuim: Bool.random())
        // when
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, loopCount)
        XCTAssertFalse(vm.dataArray.isEmpty)
        //then 
        XCTAssertEqual(vm.dataArray.count, loopCount)
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldNotAddBlankString() {
        //given
        let vm = UnitTestingBootcampViewModel(isPremuim: Bool.random())
        // when
        vm.addItem(item: "")
        //then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldNotAddBlankString2() {
        //given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        // when
        vm.addItem(item: "")
        //then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingBootcampViewModel_SelectedItem_shouldStartAsNil() {
        //given
      
        // when
        let vm = UnitTestingBootcampViewModel(isPremuim: Bool.random())
        //then
        XCTAssertTrue(vm.selectedItem == nil )

    }
    
    func test_UnitTestingBootcampViewModel_SelectedItem_shouldBeSelected() {
        //given
        let vm = UnitTestingBootcampViewModel(isPremuim: Bool.random())
        // when
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectedItem = newItem
        //then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertTrue(vm.selectedItem == newItem )

    }
    
    
    func test_UnitTestingBootcampViewModel_selectedItem_shouldBeNILWhenSelectingInvalidItem() {
        //given
        let vm = UnitTestingBootcampViewModel(isPremuim: Bool.random())
        // when
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        let otherItem = UUID().uuidString
        vm.selectItem(item: otherItem)
        //then
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingBootcampViewModel_selectedItem_shouldBeSelected() {
        //given
        let vm = UnitTestingBootcampViewModel(isPremuim: Bool.random())
        // when
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        //then
        XCTAssertTrue(vm.selectedItem == newItem )
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldBeSelected_stress() {
        //given
        let vm = UnitTestingBootcampViewModel(isPremuim: Bool.random())
        // when
        var itemsArray: [String] = []
        let loopCount: Int = Int.random(in: 1..<100)
        
        for _ in 0..<loopCount {
            let newItem =  UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        vm.selectItem(item: randomItem)
        
        //then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
      
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldThrowError_itemNotFound() {
        //given
        let vm = UnitTestingBootcampViewModel(isPremuim: Bool.random())
        // when
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        //then
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString))
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString), "Should throw error Item Not Found") {
            error in
            let returnedError = error as? UnitTestingBootcampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingBootcampViewModel.DataError.itemNotFound)
        }
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldThrowError_noData() {
        //given
        let vm = UnitTestingBootcampViewModel(isPremuim: Bool.random())
        // when
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        //then
        do {
            try vm.saveItem(item: "")
        } catch let error {
            let returnedError = error as? UnitTestingBootcampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingBootcampViewModel.DataError.noData)
        }
        
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_saveItem_shouldSaveItem() {
        //given
        let vm = UnitTestingBootcampViewModel(isPremuim: Bool.random())
        // when
        var itemsArray: [String] = []
        let loopCount: Int = Int.random(in: 1..<100)
        
        for _ in 0..<loopCount {
            let newItem =  UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty)
        
        //then
        XCTAssertNoThrow(try vm.saveItem(item: randomItem))
       
        
        do {
            try vm.saveItem(item: randomItem)
        } catch  {
           XCTFail()
        }
        
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_downloadWithEscaping_shouldReturnItems() {
        //given
        let vm = UnitTestingBootcampViewModel(isPremuim: Bool.random())
        // when
       
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds")
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.downloadWithCombine()
        
        //then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
        
    }
    
}
