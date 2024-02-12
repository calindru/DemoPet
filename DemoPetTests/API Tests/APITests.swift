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
    
    func testGetAnimals() async throws {
        let expectation = XCTestExpectation(description: "Obtain a list of animals")
        
        Requester.shared.getAnimals()
            .subscribe { event in
                guard !event.isCompleted else { return }
                
                XCTAssertNotNil(event.element, "Could not retrieve the animals.")
                expectation.fulfill()
            }
            .disposed(by: disposeBag)
        
        await fulfillment(of: [expectation],timeout: 10.0, enforceOrder: false)
    }
    
    func testGetAnimalDetails() async throws {
        let expectation = XCTestExpectation(description: "Obtain animal details")
        
        Requester.shared.getAnimalDetails(id: 70700899)
            .subscribe { event in
                guard !event.isCompleted else { return }
                
                XCTAssertNotNil(event.element, "Could not retrieve the animal details.")
                expectation.fulfill()
            }
            .disposed(by: disposeBag)
        
        await fulfillment(of: [expectation],timeout: 10.0, enforceOrder: false)
    }
}
