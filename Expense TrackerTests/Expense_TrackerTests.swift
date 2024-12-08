//
//  Expense_TrackerTests.swift
//  Expense TrackerTests
//
//  Created by Mashhood Qadeer on 07/12/2024.
//

import XCTest
import Combine

@testable import Expense_Tracker

final class Expense_TrackerTests: XCTestCase {

    //Dispose bags
    var disposeaBags: Set<AnyCancellable> = Set<AnyCancellable>()
    
    func testExample() async throws {
        
         let expectation = self.expectation(description: "Waiting for transactions response")
        
         //Fetching the API Response
         let api = API.TRANSACTIONS
         
         Networking.networking.callApi(api, [Transaction].self)?.sink(receiveCompletion: { completion in
            
             switch(completion) {
                 
             case .failure( let error ):
                   XCTAssertNil(error)
                   break
                 
             case .finished:
                   expectation.fulfill()
                   break
                 
             }
             
             
         }, receiveValue: { transactionsList in
            
             XCTAssertNotNil(transactionsList)
             
         }).store(in: &self.disposeaBags)
        
         wait(for: [expectation], timeout: 30.0)
        
    }
    
}
