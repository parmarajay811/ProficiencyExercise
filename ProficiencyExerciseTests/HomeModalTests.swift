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
        let urlExpectation = expectation(description: "POST \(url)")
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = nil
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, response, error) in
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertNil(error, "error should be nil")
            
            if let response = response as? HTTPURLResponse,
                let responseURL = response.url,
                let _ = response.mimeType
            {
                XCTAssertEqual(responseURL.absoluteString, url.absoluteString, "HTTP response URL should be equal to original URL")
                XCTAssertEqual(response.statusCode, 200, "HTTP response status code should be 200")
            } else {
                XCTFail("Response was not NSHTTPURLResponse")
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
        let failureUrl = URL(string: "https://dl.dropboxusercontent.com/testfail")!
        let urlExpectation = expectation(description: "POST \(failureUrl)")
        let request = NSMutableURLRequest(url: failureUrl)
        request.httpMethod = "POST"
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = nil
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: failureUrl) { (data, response, error) in
            XCTAssertNotNil(data, "data should be nil")
            XCTAssertNil(error, "error should not be nil")
            
            if let response = response as? HTTPURLResponse,
                let responseURL = response.url,
                let _ = response.mimeType
            {
                XCTAssertEqual(responseURL.absoluteString, failureUrl.absoluteString, "HTTP response URL should be equal to original URL")
                XCTAssertEqual(response.statusCode, 404, "HTTP response status code should not be 200")
            } else {
                XCTFail("Response was  NSHTTPURLResponse")
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
