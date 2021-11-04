//
//  AtemisBackendTest.swift
//  AtemisTests
//
//  Created by Nicholas on 29/10/21.
//

import XCTest
@testable import exzo

class AtemisBackendTest: XCTestCase {
    var ckHelper = CKHelper.shared

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRegister() throws {
        ckHelper.signUpNewUser(
            newAcc: NewUserAccount(fName: "Nic", lName: "asdf", email: "nkwxn05@gmail.com", pwd: "asdf")) { result in
                do {
                    let user = try result.get()
                    XCTAssert(true, "ga error kok: \(user)")
                } catch {
                    XCTAssert(false, "Error woi disini")
                }
            }
    }
    
    func testCheck() throws {
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
