//
//  CKCrudOperators.swift
//  Atemis
//
//  Created by Nicholas on 01/11/21.
//

import Foundation
import CloudKit

enum CKError: Error {
    case recordFailure
    case recordIDFailure
    case castFailure
    case cursorFailure
}

class CKCrudOperators {
    // MARK: - Check iCloud account status (if apple id not logged in, can't use the app)
    static func checkiCloud(completionHandler: @escaping (_: CKAccountStatus, _: Error?) -> Void) {
        CKContainer.default().accountStatus { status, error in
            completionHandler(status, error)
        }
    }
    
    static func CREATE(
        recordType: CKRecord.RecordType, values: [String: Any],
        completion: @escaping (Result<CKRecord, Error>) -> Void
    ) {
        let newRecord = CKRecord(recordType: recordType)
        newRecord.setValuesForKeys(values)
        CKContainer.default().publicCloudDatabase.save(newRecord) { record, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let record = record else {
                completion(.failure(CKError.recordFailure))
                return
            }
            completion(.success(record))
        }
    }
    
    static func READ(
        recordToRead: CKRecord.RecordType, predicate: NSPredicate,
        sortDescriptors: [NSSortDescriptor], desiredKeys: [String],
        completion: @escaping (Result<CKRecord, Error>) -> Void
    ) {
        let query = CKQuery(recordType: recordToRead, predicate: predicate)
        query.sortDescriptors = sortDescriptors
        
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = desiredKeys
        
        operation.recordMatchedBlock = { id, result in
            DispatchQueue.main.async {
                do {
                    let user = try result.get()
                    completion(.success(user))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        operation.queryResultBlock = { result in
            do {
                guard let _ = try result.get() else { return }
            } catch {
                completion(.failure(CKError.cursorFailure))
                return
            }
        }
        
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    static func READ(
        recordToRead: CKRecord.RecordType, predicate: NSPredicate,
        sortDescriptors: [NSSortDescriptor],
        completion: @escaping (Result<[CKRecord], Error>) -> Void
    ) {
        // Query
        let query = CKQuery(recordType: recordToRead, predicate: predicate)
        query.sortDescriptors = sortDescriptors
        
        CKContainer.default().publicCloudDatabase.fetch(withQuery: query) { result in
            do {
                var records = [CKRecord]()
                let resultcurs = try result.get()
                for result in resultcurs.matchResults {
                    records.append(try result.1.get())
                }
                completion(.success(records))
            } catch {
                completion(.failure(error))
            }
        }
        
    }
    
    static func UPDATE(
        recordID: CKRecord.ID, valueToUpdate: [String: Any],
        completion: @escaping (Result<CKRecord, Error>) -> Void
    ) {
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { accRec, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let accRec = accRec else { return }
                accRec.setValuesForKeys(valueToUpdate)
                
                CKContainer.default().publicCloudDatabase.save(accRec) { record, error in
                    DispatchQueue.main.async {
                        if let error = error {
                            completion(.failure(error))
                            return
                        }
                        
                        guard let record = record else {
                            completion(.failure(CKError.recordFailure))
                            return
                        }
                        
                        completion(.success(record))
                    }
                }
            }
        }
    }
    
    static func DELETE(recordID: CKRecord.ID, completion: @escaping (Result<CKRecord.ID, Error>) -> Void) {
        CKContainer.default().publicCloudDatabase.delete(withRecordID: recordID) { accID, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                }
                guard let accID = accID else {
                    completion(.failure(CKError.castFailure))
                    return
                }
                completion(.success(accID))
            }
        }
    }
}
