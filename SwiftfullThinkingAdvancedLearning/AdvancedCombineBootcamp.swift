//
//  AdvancedCombineBootcamp.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 30/07/2025.
//

import SwiftUI
import Combine

class AdvancedCombineDataService {
    
//    @Published var basicPublisher: String = "first publish"
    let currentValuePublisher = CurrentValueSubject<String, Never>("first publish")
    let passThroughPublisher = PassthroughSubject<Int, Error>()
    let boolPublisher = PassthroughSubject<Bool, Error>()
    let intPublisher = PassthroughSubject<Int, Error>()
    init() {
        publishFakeData()
    }
    
    private func publishFakeData() {
        let items: [Int] = [1,2,3,4,5,6,7,8,9,10]
        
        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
                self.passThroughPublisher.send(items[x])
                if (x > 4 && x < 8) {
                    self.boolPublisher.send(true)
                    self.intPublisher.send(99)
                } else {
                    self.boolPublisher.send(false)
                }
                if x == items.indices.last {
                    self.passThroughPublisher.send(completion: .finished)
                }
            }
        }
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
//            self.passThroughPublisher.send(1)
//        }
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self.passThroughPublisher.send(2)
//        }
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//            self.passThroughPublisher.send(3)
//        }
        
    }
    
}

class AdvancedCombineViewModel: ObservableObject {
    
    @Published var data: [String] = []
    @Published var dataBools: [Bool] = []
    @Published var error: String = ""
    let dataService = AdvancedCombineDataService()
    var cancellables = Set<AnyCancellable>()
    let multiCastPublisher = PassthroughSubject<Int, Error>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        // sequence operations
        /*
         // sequence operations
         //            .first()
         //            .first(where: { int in
         //                int > 4
         //            })
         //            .first(where: { $0 > 4})
         //            .tryFirst(where: { int in
         //                if int == 3 {
         //                    throw URLError(.badServerResponse)
         //                }
         //                return int > 1
         //            })
         //            .last()
         //            .last(where: { $0 < 4 })
         //            .tryLast(where: { int in
         //            if int == 13 {
         //                throw URLError(.badServerResponse)
         //            }
         //            return int > 1
         //        })
         //            .dropFirst(3)
         //            .drop(while: {$0 < 5})
         //            .tryDrop(while: { int in
         //                if int == 15 {
         //                    throw URLError(.badServerResponse)
         //                }
         //                return int < 6
         //            })
         //            .prefix(4)
         //            .prefix(while: { $0 < 5})
         //            .tryPrefix(while: {})
         //            .output(at: 3)
         //            .output(in: 2..<7)
         */
        
        // mathematic operations
        /*
         //            .max()
         //            .max(by: { int1, int2 in
         //                int1 < int2
         //            })
         //            .tryMax(by: { int1, int2 in
         //
         //            })
         //            .min()
         //            .tryMin(by: { int1, int2 in
         //                if int1 == 15 {
         //                    throw URLError(.badServerResponse)
         //                }
         //                return int1 < int2
         //            })
         */
        
        // Filter / Reducing Operations
        /*
         //            .map ({ String($0) })
         //            .tryMap({ int in
         //                if int == 5 {
         //                    throw URLError(.badServerResponse)
         //                }
         //                return String(int)
         //            })
         //            .compactMap({ int in
         //                if int == 5 {
         //                    return nil
         //                }
         //                return String(int)
         //            })
         
         //            .compactMap({ Int in
         //            if Int == 5 {
         //                    return nil
         //                }
         //                return String(Int)
         //            })
         //            .tryCompactMap({ int in
         //                if int == 5 {
         //                    throw URLError(.badServerResponse)
         //                }
         //                return String(int)
         //            })
         //            .filter({ ($0 > 3) && ($0 < 7)})
         //            .removeDuplicates()
         //            .removeDuplicates(by: {int1, int2 in
         //                return int1 == int2
         //            })
         //            .replaceNil(with: 5)
         //            .replaceEmpty(with: [])
         //            .replaceError(with: "Default Value")
         //            .scan(0, { existingValue, newValue in
         //                existingValue == 0 ? 1 :
         //                existingValue * newValue
         //            })
         //            .scan(0, {$0+$1})
         //            .scan(0, +)
         //            .tryScan(0, { current, next in
         //
         //            })
         //            .reduce(0, {existing, newValue in
         //            return existing + newValue
         //            })
         //            .reduce(0, +)
         //            .allSatisfy({$0 < 50})
         //            .tryAllSatisfy({})
         */
        
        // Timing Operations
        /*
         //            .debounce(for: 0.75, scheduler: DispatchQueue.main)
         //            .delay(for: 2, scheduler: DispatchQueue.main)
         //            .measureInterval(using: DispatchQueue.main)
         //            .map({ stride in
         //                return "\(stride.timeInterval)"
         //            })
         //            .throttle(for: 5, scheduler: DispatchQueue.main, latest: true )
         //            .retry(3)
         //            .timeout(1.0000001, scheduler: DispatchQueue.main)
         */
        
        //Multiple Publishers / Subscribers
        /*
         //            .combineLatest(dataService.boolPublisher, dataService.intPublisher)
         //            .compactMap(({ int, bool, int2 in
         //                if bool {
         //                    return String(int)
         //                }
         //                return "n/a"
         //            }))
         //            .compactMap({ $1 ? String($0) : "n/a"})
         
         
         //            .map({String($0)})
         //            .collect()
         //            .collect(3)
         
         //            .merge(with: dataService.intPublisher)
         //            .zip(dataService.boolPublisher, dataService.intPublisher)
         //            .map({ tuple in
         //                return String(tuple.0) + tuple.1.description + String(tuple.2)
         //            })
         */
        
        let sharedPublisher = dataService.passThroughPublisher
//            .dropFirst(3)
            .share()
//            .multicast {
//                PassthroughSubject<Int, Error>()
//            }
            .multicast(subject: multiCastPublisher)
        
        
        sharedPublisher
            .map({ String($0)})
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = "ERROR :\(error.localizedDescription)"
                }
            } receiveValue: { [weak self] returndValue in
                self?.data.append(returndValue)
            }
            .store(in: &cancellables)
        
        
        sharedPublisher
            .map({ $0 > 5 ? true : false})
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = "ERROR :\(error.localizedDescription)"
                }
            } receiveValue: { [weak self] returndValue in
                self?.dataBools.append(returndValue)
            }
            .store(in: &cancellables)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            sharedPublisher
                .connect()
                .store(in: &self.cancellables)
        }
        
        
    }
    
    
}

struct AdvancedCombineBootcamp: View {
    @StateObject private var vm = AdvancedCombineViewModel()
    
    var body: some View {
        ScrollView {
            HStack {
                VStack {
                    ForEach(vm.data, id: \.self) {
                        Text($0)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                    if !vm.error.isEmpty {
                        Text(vm.error)
                    }
                }
                VStack {
                    ForEach(vm.dataBools, id: \.self) {
                        Text($0.description)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    AdvancedCombineBootcamp()
}
