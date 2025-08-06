//
//  CloudKitUtility.swift
//  SwiftfullThinkingAdvancedLearning
//
//  Created by Akram Husseini on 06/08/2025.
//

import Foundation
import CloudKit
import Combine

class CloudKitUtility {
    
    enum CLoudKitError: String, LocalizedError {
        case iCloudAccountNotFound
        case iCLouldAccountNotDetermined
        case iCloudAccountRestricted
        case iCLoudAccountUnknown
        case iCloudApplicationPermissionNotGranted
        case iCLoudCouldNotFetchUserRecordId
        case iCloudCOuldNotDiscoverUser
    }
    
}


// MARK: User Functions
extension CloudKitUtility {
    
    static private func getiCloudStatus(completion: @escaping (Result<Bool, Error>) -> ()) {
        CKContainer.default().accountStatus { returnedStatus, returnedError in
                switch returnedStatus {
                case .available:
                    completion(.success(true))
                case .noAccount:
                    completion(.failure(CLoudKitError.iCloudAccountNotFound))
                case .couldNotDetermine:
                    completion(.failure(CLoudKitError.iCLouldAccountNotDetermined))
                case .restricted:
                    completion(.failure(CLoudKitError.iCloudAccountRestricted))
                default:
                    completion(.failure(CLoudKitError.iCLoudAccountUnknown))
                }
        }
    }
    
    static func getiCloudStatus() -> Future<Bool, Error> {
        Future { promise in
            CloudKitUtility.getiCloudStatus { result in
                promise(result)
                
            }
        }
    }
    
    static private func requestApplicationPermission(completion: @escaping (Result<Bool, Error>) -> ()) {
        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { returnedStatus, returnedError in
            if returnedStatus == .granted {
                completion(.success(true))
            } else {
                completion(.failure(CLoudKitError.iCloudApplicationPermissionNotGranted))
            }
        }
    }
    
    static func requestApplicationPermission() -> Future<Bool, Error> {
        Future { promise in
            CloudKitUtility.requestApplicationPermission { result in
                promise(result)
            }
        }
    }
    
    private static func fetchUserRecordID(completion: @escaping (Result<CKRecord.ID, Error>) -> ())  {
        CKContainer.default().fetchUserRecordID { returnedID, returnedError in
            if let id = returnedID {
                completion(.success(id))
            } else if let error = returnedError {
                completion(.failure(error))
            } else {
                completion(.failure(CLoudKitError.iCLoudCouldNotFetchUserRecordId))
            }
        }
    }
    
    static func discoverUserIdentity(id: CKRecord.ID, completion: @escaping (Result<String, Error>) -> ()) {
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { returnedIdentity, returnedError in
                if let name = returnedIdentity?.nameComponents?.givenName {
                    completion(.success(name))
                } else {
                    completion(.failure(CLoudKitError.iCloudCOuldNotDiscoverUser))
                }
        }
    }
    
    static func discoverUserIdentity(completion: @escaping (Result<String, Error>) -> ()) {
        fetchUserRecordID { fetchCompletion in
            switch fetchCompletion {
            case .success(let recordID):
                CloudKitUtility.discoverUserIdentity(id: recordID, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
             
        }
    }
    
    static func discoverUserIdentity() -> Future<String, Error> {
        Future { promise in
            CloudKitUtility.discoverUserIdentity { result in
                promise(result)
            }
        }
    }
}

// MARK: CRUD Functions
extension CloudKitUtility {
    
    static func fetch<T: CloudKitableProtocol> (
        predicate: NSPredicate,
        recordType: CKRecord.RecordType,
        sortDescriptions: [NSSortDescriptor]? = nil,
        resultsLimit: Int? = nil) -> Future<[T], Error> {
            Future { promise in
                CloudKitUtility.fetch(
                    predicate: predicate,
                    recordType: recordType) { items in
                        promise(.success(items))
                    }
            }
        }
    
    static private func fetch<T: CloudKitableProtocol>(
        predicate: NSPredicate,
        recordType: CKRecord.RecordType,
        sortDescriptions: [NSSortDescriptor]? = nil,
        resultsLimit: Int? = nil,
        completion: @escaping (_ items: [T]) -> ()) {
            let operation = createOperation(
                predicate: predicate,
                recordType: recordType,
                sortDescriptions: sortDescriptions,
                resultsLimit: resultsLimit)
            var returnedItems: [T] = []
            addRecordMatchedBlock(operation: operation) { item in
                returnedItems.append(item)
            }
            addQueryResultBlock(operation: operation) { finished in
                completion(returnedItems)
            }
            add(operation: operation)
        }
    
    static private func createOperation(
        predicate: NSPredicate,
        recordType: CKRecord.RecordType,
        sortDescriptions: [NSSortDescriptor]? = nil,
        resultsLimit: Int? = nil
    ) -> CKQueryOperation {
        let query = CKQuery(recordType: recordType, predicate: predicate)
        query.sortDescriptors = sortDescriptions
        let queryOperation = CKQueryOperation(query: query)
        if let limit = resultsLimit {
            queryOperation.resultsLimit = limit
        }
        return queryOperation
    }
    
    static private func addRecordMatchedBlock<T: CloudKitableProtocol>(operation: CKQueryOperation, completion: @escaping (_ item: T) -> ()) {
        operation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
            switch returnedResult {
            case .success(let record):
                guard let item = T(record: record) else { return }
                completion(item)
            case .failure(let error):
                break
            }
        }
    }
    
    static private func addQueryResultBlock(operation: CKQueryOperation, completion: @escaping (_ finished: Bool) -> ()) {
        operation.queryResultBlock = { returnedResult in
            completion(true)
        }
    }
    
    static private func add(operation: CKDatabaseOperation) {
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    static func add<T:CloudKitableProtocol>(item: T, completion: @escaping (Result<Bool, Error>) -> ()) {
        let record = item.record
        save(record: record, completion: completion)
    }
    
    static func update<T:CloudKitableProtocol>(item: T, completion: @escaping (Result<Bool, Error>) -> ()) {
        add(item: item, completion: completion)
    }
    
    static func save(record: CKRecord, completion: @escaping (Result<Bool, Error>) -> ()) {
        CKContainer.default().publicCloudDatabase.save(record) {  returnedRecord, returnedError in
           if let error = returnedError {
               completion(.failure(error))
           } else {
               completion(.success(true))
           }
           
        }
    }
    
    static func delete<T:CloudKitableProtocol>(item: T) -> Future<Bool, Error> {
        Future { promise in
            CloudKitUtility.delete(item: item, completion: promise)
        }
    }
    
    static private func delete<T:CloudKitableProtocol>(item: T, completion: @escaping (Result<Bool, Error>) -> ()) {
        CloudKitUtility.delete(record: item.record, completion: completion)
    }
    
    static private func delete(record: CKRecord, completion: @escaping (Result<Bool, Error>) -> ()) {
        CKContainer.default().publicCloudDatabase.delete(withRecordID: record.recordID) { returnedRecordID, returnedError in
            if let error = returnedError {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
}
