//
//  ConfigTests.swift
//  VeterinaryClinicTests
//
//  Created by Sachin Daingade on 27/08/22.
//

import XCTest
@testable import VeterinaryClinic

class ConfigTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    //MARK: API GetConfigData
    func testAPIGetConfigData() {
        let expec = expectation(description: "test ConfigData request")
        ConfigNetwork.getConfigData { result in
            switch result {
            case .failure(let error):
                XCTFail("ConfigData request failed \(error.localizedDescription)")
                expec.fulfill()
            case .success(let config):
                print("ConfigData success \(config.settings )")
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
        let expec = expectation(description: "test ConfigData request")
        ConfigNetwork.getConfigData { result in
            switch result {
            case .failure(let error):
                print("Internet connection \(error.description )")
                expec.fulfill()
            case .success(let config):
                expec.fulfill()
                XCTFail("Internet connection is working \(config.settings)")

            }
        }
        
        waitForExpectations(timeout: 10.0) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    //MARK: API Mock GetConfigData

    func testMockGetConfigData() {
        let expec = expectation(description: "test ConfigData request")
        TestConfigNetwork.getConfigData { result in
            switch result {
            case .failure(let error):
                XCTFail("ConfigData request failed \(error.localizedDescription)")
                expec.fulfill()
            case .success(let config):
                print("ConfigData success \(config.settings )")
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
