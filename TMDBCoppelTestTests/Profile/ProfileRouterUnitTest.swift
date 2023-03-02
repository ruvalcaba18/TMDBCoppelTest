//
//  ProfileRouterUnitTest.swift
//  TMDBCoppelTestTests
//
//  Created by Jael  on 01/03/23.
//

import XCTest

final class ProfileRouterUnitTest: XCTestCase {

        func testCreateProfileModule() {
            let viewController = ProfileRouter.createProfileModule() as? ProfileViewController
                XCTAssertNotNil(viewController)
                XCTAssertNotNil(viewController?.presenter)
        }

}
