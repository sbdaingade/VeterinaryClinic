//
//  VeterinaryClinicTests.swift
//  VeterinaryClinicTests
//
//  Created by Sachin Daingade on 27/08/22.
//

import XCTest
@testable import VeterinaryClinic

class VeterinaryClinicTests: XCTestCase {

    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCheckInternet() {
        let expec = expectation(description: "test Internet connection request")
        let isInternetConnected = InternetMonitor.shared.isConnected
        
        if isInternetConnected == true {
            expec.fulfill()
        }else {
            XCTFail("Internet is not working")
            expec.fulfill()
        }
        
        waitForExpectations(timeout: 2.0) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testValidationOfWorkingHours() {
        let homeViewModel = HomeViewModel()
        let expec = expectation(description: "test Working Hours")
        
        //"workHours": "M-F 9:00 - 18:00"
        let result = homeViewModel.validateWithInOfficeTime(workingHours: "M-F 9:00 - 23:00", currentDate: Date())
        if result == true {
            expec.fulfill()
        }else {
            XCTFail("Pets request failed: Work hours has ended. Please contact us again on the next work day")
            expec.fulfill()
        }
        waitForExpectations(timeout: 10.0) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    func testValidationOfEndWorkingHours() {
        let homeViewModel = HomeViewModel()
        let expec = expectation(description: "test Working Hours")
        
        //"workHours": "M-F 9:00 - 18:00"
        let result = homeViewModel.validateWithInOfficeTime(workingHours: "ABC", currentDate: Date())
        if result == false {
            expec.fulfill()
        }else {
            XCTFail("Pets request failed: Work hours has ended. Please contact us again on the next work day")
            expec.fulfill()
        }
        waitForExpectations(timeout: 2.0) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }


}
