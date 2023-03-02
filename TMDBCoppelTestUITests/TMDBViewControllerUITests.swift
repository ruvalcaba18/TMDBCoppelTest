//
//  TMDBViewControllerUITests.swift
//  TMDBCoppelTestUITests
//
//  Created by Jael  on 01/03/23.
//

import XCTest

final class TMDBViewControllerUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
              app = XCUIApplication()
              app.launch()
    }

  
    func test_CollectionViewDisplaysInCorrectNumberOfItems() throws {
           let collectionView = app.collectionViews["mainCollectionView"]
           let numberOfItems = try XCTUnwrap(collectionView.cells.count)
           XCTAssertEqual(numberOfItems, 0)
       }
    
    func test_GoToSecondViewController(){
        let loginButton = app.buttons["loginButton"]

       
        loginButton.tap()
    }
    
  
}
