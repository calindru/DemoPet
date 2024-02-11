//
//  APITests.swift
//  DemoPetTests
//
//  Created by Calin Drule on 11.02.2024.
//

import XCTest
@testable import DemoPet
import RxSwift

final class APITests: XCTestCase {
    let disposeBag = DisposeBag()
    var session: URLSession!
    
    override func setUpWithError() throws {
        session = URLSession.shared
    }

    override func tearDownWithError() throws {
        session = nil
    }
    
    func testAuthentication() async throws {
        let expectation = XCTestExpectation(description: "Obtain token data")
        
        let apiService = APIService()
        apiService.authenticate()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { event in
                guard !event.isCompleted else { return }
                
                XCTAssertNotNil(event.element, "Could not retrieve the auth token.")
                expectation.fulfill()
            }
            .disposed(by: disposeBag)
        
        await fulfillment(of: [expectation],timeout: 10.0, enforceOrder: false)
    }
    
    func testGetAnimals() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        Requester.shared.getAnimals()
            .subscribe(onNext: { animalData in
                XCTAssertTrue(true)
            }, onError: { error in
                XCTAssert(false)
            })
            .disposed(by: disposeBag)
        
    }
}
