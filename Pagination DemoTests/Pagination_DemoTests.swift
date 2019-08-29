//
//  Pagination_DemoTests.swift
//  Pagination DemoTests
//
//  Created by Mohamed Hussien on 27/08/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import XCTest
@testable import Pagination_Demo

class Pagination_DemoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testStorage() {
        // Given
        let givenRepos = Repositories(repositories: [Repository(fullName: "test",
                                                           description: "testtest",
                                                           url: "www.google.com",
                                                           htmlUrl: "www.google.com",
                                                           watchers: 10,
                                                           forks: 2)])
        
        // When
        do {
            try StorageManager.shared.saveData(data: givenRepos, for: Stored.Repos.rawValue)
        } catch let error {
            let error = XCTestError(_nsError: error as NSError)
            XCTFail(error.localizedDescription)
        }
        
        // Then
        do {
            let repos = try StorageManager.shared.fetchData(for: Stored.Repos.rawValue) as Repositories
            XCTAssertEqual(repos.repositories?.first?.fullName, givenRepos.repositories?.first?.fullName)
        } catch let error {
            let error = XCTestError(_nsError: error as NSError)
            XCTFail(error.localizedDescription)
        }
    }
    
    

}
