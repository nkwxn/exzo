//
//  CloudKitHelper.swift
//  Atemis
//
//  Created by Nicholas on 29/10/21.
//

import CloudKit

class CKHelper {
    // MARK: - Record Types
    struct RecordType {
        static let Account = "Account"
        static let Journal = "Journal"
        static let Product = "Product"
        static let SkinCondition = "SkinCondition"
        static let TriggerArea = "TriggerArea"
        static let CustomActivity = "CustomActivity"
        static let CustomFoodIntake = "CustomFoodIntake"
    }
    
    enum CKHelperError: Error {
        case recordFailure
        case recordIDFailure
        case castFailure
        case cursorFailure
    }
    
    // Singleton
    static let shared = CKHelper()
    
    // CloudKit Container
    let container = CKContainer.default()
    let database: CKDatabase?
    
    private init() {
        database = container.publicCloudDatabase
    }
    
    // MARK: - Check iCloud account status (if apple id not logged in, can't use the app)
    func checkiCloud(completionHandler: @escaping (_: CKAccountStatus, _: Error?) -> Void) {
        container.accountStatus { status, error in
            completionHandler(status, error)
        }
    }
    
    // MARK: - Create a new user
    func signUpNewUser(
        newAcc: NewUserAccount,
        completionHandler: @escaping (Result<NewUserAccount, Error>) -> ()
    ) {
        let newUserRecord = CKRecord(recordType: RecordType.Account)
        
        newUserRecord.setValuesForKeys([
            "givenName": newAcc.fName,
            "surName": newAcc.lName,
            "email": newAcc.email,
            "password": newAcc.pwd
        ])
        
        if let database = database {
            database.save(newUserRecord) { record, error in
                if let error = error {
                    completionHandler(.failure(error))
                    return
                }
                
                guard let record = record else {
                    completionHandler(.failure(CKHelperError.recordFailure))
                    return
                }
                
                let id = record.recordID
                guard let fName = record["givenName"] as? String,
                      let lName = record["surName"] as? String,
                      let email = record["email"] as? String,
                      let pwd = record["password"] as? String
                else {
                    completionHandler(.failure(CKHelperError.castFailure))
                    return
                }
                
                let account = NewUserAccount(recordID: id, fName: fName, lName: lName, email: email, pwd: pwd)
                completionHandler(.success(account))
            }
        }
    }
    
    // MARK: - Create Nickname (PASS UPDATE VALUE)
    func setNickname(
        userID: CKRecord.ID, nickName: String, picKey: String,
        completion: @escaping (Result<NewUserAccount, Error>) -> Void
    ) {
        if let database = database {
            database.fetch(withRecordID: userID) { accRec, error in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    
                    guard let accRec = accRec else { return }
                    accRec.setValuesForKeys([
                        "password": "updated", // buat testing data aja kok
                        "nickName": nickName,
                        "profThumb": picKey
                    ])
                    
                    database.save(accRec) { record, error in
                        DispatchQueue.main.async {
                            if let error = error {
                                completion(.failure(error))
                                return
                            }
                            
                            guard let record = record else { return }
                            let id = record.recordID
                            guard let fName = record["givenName"] as? String,
                                  let lName = record["surName"] as? String,
                                  let email = record["email"] as? String,
                                  let pwd = record["password"] as? String,
                                  let nick = record["nickName"] as? String,
                                  let thumb = record["profThumb"] as? String
                            else {
                                completion(.failure(CKHelperError.castFailure))
                                return
                            }
                            let account = NewUserAccount(recordID: id, fName: fName, lName: lName, email: email, pwd: pwd, picThumb: thumb, nickName: nick)
                            completion(.success(account))
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Fetch user, validate the password (READ PASSED)
    func login(
        email: String,
        pwd: String,
        completionHandler: @escaping (Result<NewUserAccount, Error>) -> Void
    ) {
        // fetching every single user
        let pred = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: "email", ascending: false)
        let query = CKQuery(recordType: RecordType.Account, predicate: pred)
        query.sortDescriptors = [sort]
        
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["givenName", "surName", "email", "password"]
        
        operation.recordMatchedBlock = { id, result in
            DispatchQueue.main.async {
                do {
                    let user = try result.get()
                    let id = user.recordID
                    guard let fName = user["givenName"] as? String,
                          let lName = user["surName"] as? String,
                          let email = user["email"] as? String,
                          let pwd = user["password"] as? String
                    else {
                        completionHandler(.failure(CKHelperError.castFailure))
                        return
                    }
                    let account = NewUserAccount(recordID: id, fName: fName, lName: lName, email: email, pwd: pwd)
                    completionHandler(.success(account))
                } catch {
                    print("Error")
                }
            }
        }
        
        operation.queryCompletionBlock = { _, err in
            DispatchQueue.main.async {
                if let err = err {
                    completionHandler(.failure(err))
                    return
                }
            }
        }

        if let database = database {
            database.add(operation)
        }
    }
    
    // MARK: - Delete User (PASSED)
    func deleteAccount(accountID: CKRecord.ID, completion: @escaping (Result<CKRecord.ID, Error>) -> ()) {
        if let database = database {
            database.delete(withRecordID: accountID) { accID, error in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(.failure(error))
                    }
                    guard let accID = accID else {
                        completion(.failure(CKHelperError.castFailure))
                        return
                    }
                    completion(.success(accID))
                }
            }
        }
    }
}
