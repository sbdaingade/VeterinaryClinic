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

    
    func testAPIGetPets() {
        let expec = expectation(description: "test Pets request")
        PetsNetwork.getPets { result in
            switch result {
            case .failure(let error):
                XCTFail("Pets request failed \(error.localizedDescription)")
                expec.fulfill()
            case .success(let Pets):
                print("Pets success \(Pets.pets.count )")
                expec.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10.0) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    
    func testCheckInternet() {
        let expec = expectation(description: "test Internet connection request")
        PetsNetwork.getPets { result in
            switch result {
            case .failure(let error):
                print("Internet connection \(error.description )")
                expec.fulfill()
            case .success(let pet):
                expec.fulfill()
                XCTFail("Internet connection is working \(pet)")
            }
        }
        
        waitForExpectations(timeout: 10.0) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testMockGetPets() {
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
