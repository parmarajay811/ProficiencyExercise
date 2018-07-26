//
//  HomeModalTests.swift
//  ProficiencyExerciseTests
//
//  Created by Ajay Parmar on 7/24/18.
//  Copyright © 2018 Ajay Parmar. All rights reserved.
//

import XCTest
@testable import ProficiencyExercise

class HomeModalTests: XCTestCase {
    
    var modelC: HomeModel!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
 
    func testAPICallSuccess() {
        let url = URL(string: baseURL)!
        let urlExpectation = expectation(description: kPost + "\(url)")
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = kPost
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = nil
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, response, error) in
            XCTAssertNotNil(data, kDataNotNill)
            XCTAssertNil(error, kErrorNill)
            
            if let response = response as? HTTPURLResponse,
                let responseURL = response.url,
                let _ = response.mimeType
            {
                XCTAssertEqual(responseURL.absoluteString, url.absoluteString, responseURLString)
                XCTAssertEqual(response.statusCode, kSuccessCode, kResponseStatusString)
            } else {
                XCTFail(kFailResponseMessage)
            }
            
            urlExpectation.fulfill()
        }
        task.resume()
        waitForExpectations(timeout: task.originalRequest!.timeoutInterval) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            task.cancel()
        }
    }
    
  
    func testAPICallFail() {
        let failureUrl = URL(string: kFailureURL)!
        let urlExpectation = expectation(description: kPost + "\(failureUrl)")
        let request = NSMutableURLRequest(url: failureUrl)
        request.httpMethod = kPost
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = nil
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: failureUrl) { (data, response, error) in
            XCTAssertNotNil(data, kDataNill)
            XCTAssertNil(error, kErrorNotNill)
            
            if let response = response as? HTTPURLResponse,
                let responseURL = response.url,
                let _ = response.mimeType
            {
                XCTAssertEqual(responseURL.absoluteString, failureUrl.absoluteString, kResponseURLString)
                XCTAssertEqual(response.statusCode, kFileNotFound, kResponseStatusString)
            } else {
                XCTFail(kFailResponseMessageFail)
            }
            
            urlExpectation.fulfill()
        }
        task.resume()
        waitForExpectations(timeout: task.originalRequest!.timeoutInterval) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            task.cancel()
        }
    }
}
