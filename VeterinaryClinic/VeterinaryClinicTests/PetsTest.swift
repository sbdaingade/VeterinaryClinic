//
//  PetsTest.swift
//  VeterinaryClinicTests
//
//  Created by Sachin Daingade on 27/08/22.
//

import XCTest
@testable import VeterinaryClinic

class PetsTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetPets() {
        let expec = expectation(description: "test Pets request")
        TestPetsNetwork.getPets { result in
            switch result {
            case .failure(let error):
                XCTFail("Pets request failed \(error.localizedDescription)")
                expec.fulfill()
            case .success(let Pets):
                print("Pets success \(Pets.pets.count )")
                expec.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2.0) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
        
    }

}