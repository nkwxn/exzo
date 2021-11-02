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
    
    enum AccountError: Error {
        case accountExists
        case notRegistered
        case incorrectPassword
    }
    
    // Singleton
    static let shared = CKHelper()
    
    // MARK: - CRUD functions for Account
    func signUpNewUser(
        newAcc: NewUserAccount,
        completion: @escaping (Result<NewUserAccount, Error>) -> Void
    ) {
        self.checkIsUserRegistered(newAcc.email) { registered, result in
            if registered {
                completion(.failure(AccountError.accountExists))
            } else {
                CKCrudOperators.CREATE(
                    recordType: RecordType.Account,
                    values: [
                        "givenName": newAcc.fName,
                        "surName": newAcc.lName,
                        "email": newAcc.email,
                        "password": newAcc.pwd
                    ]
                ) { result in
                    do {
                        let record = try result.get()
                        
                        let id = record.recordID
                        guard let fName = record["givenName"] as? String,
                              let lName = record["surName"] as? String,
                              let email = record["email"] as? String,
                              let pwd = record["password"] as? String
                        else {
                            completion(.failure(CKError.castFailure))
                            return
                        }
                        
                        let account = NewUserAccount(recordID: id, fName: fName, lName: lName, email: email, pwd: pwd)
                        completion(.success(account))
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
    
    func setNickname(
        userID: CKRecord.ID, nickName: String, picKey: String,
        completion: @escaping (Result<NewUserAccount, Error>) -> Void
    ) {
        CKCrudOperators.UPDATE(
            recordID: userID,
            valueToUpdate: [
                "nickName": nickName,
                "profThumb": picKey
            ]
        ) { result in
            do {
                let record = try result.get()
                let id = record.recordID
                guard let fName = record["givenName"] as? String,
                      let lName = record["surName"] as? String,
                      let email = record["email"] as? String,
                      let pwd = record["password"] as? String,
                      let nick = record["nickName"] as? String,
                      let thumb = record["profThumb"] as? String
                else {
                    completion(.failure(CKError.castFailure))
                    return
                }
                let account = NewUserAccount(recordID: id, fName: fName, lName: lName, email: email, pwd: pwd, picThumb: thumb, nickName: nick)
                completion(.success(account))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func login(
        email: String,
        pwd: String,
        completion: @escaping (Result<NewUserAccount, Error>) -> Void
    ) {
        checkIsUserRegistered(email) { registered, result in
            if registered {
                do {
                    guard let record = try result.get() else {
                        completion(.failure(CKError.castFailure))
                        return
                    }
                    
                    let id = record.recordID
                    guard let fName = record["givenName"] as? String,
                          let lName = record["surName"] as? String,
                          let email = record["email"] as? String,
                          let pass = record["password"] as? String,
                          let nick = record["nickName"] as? String,
                          let thumb = record["profThumb"] as? String
                    else {
                        completion(.failure(CKError.castFailure))
                        return
                    }
                    
                    let acc = NewUserAccount(
                        recordID: id,
                        fName: fName,
                        lName: lName,
                        email: email,
                        pwd: pass,
                        picThumb: thumb,
                        nickName: nick
                    )
                    
                    // Check password if correct then login
                    if pwd == pass {
                        completion(.success(acc))
                    } else {
                        completion(.failure(AccountError.incorrectPassword))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(AccountError.notRegistered))
            }
        }
    }
    
    func checkIsUserRegistered(_ email: String, completion: @escaping (Bool, Result<CKRecord?, Error>) -> Void) {
        let predicate = NSPredicate(format: "email = %@", email)
        CKCrudOperators.READ(recordToRead: RecordType.Account, predicate: predicate, sortDescriptors: [NSSortDescriptor(key: "email", ascending: true)]) { result in
            do {
                let recs = try result.get()
                if recs.isEmpty {
                    completion(false, .success(nil))
                } else {
                    completion(true, .success(recs[0]))
                }
            } catch {
                completion(false, .failure(error))
            }
        }
    }
    
    func deleteAccount(accountID: CKRecord.ID, completion: @escaping (Result<CKRecord.ID, Error>) -> Void) {
        CKCrudOperators.DELETE(recordID: accountID) { result in
            do {
                let deletedID = try result.get()
                completion(.success(deletedID))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - CRUD Methods for SkinCondition
}
