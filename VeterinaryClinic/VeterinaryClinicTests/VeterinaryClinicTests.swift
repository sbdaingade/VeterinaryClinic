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

    func testValidationOfWorkingHours() {
        let homeViewModel = HomeViewModel()
        homeViewModel.input = .getMockConfiguration

        let strMsgForWorkHoursEnded = "Work hours has ended. Please contact us again on the next work day"
        
        let expec = expectation(description: "test Pets request")
        
        let result = homeViewModel.validateWithInOfficeTime()
        
        if result != strMsgForWorkHoursEnded {
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

}
