//
//  CoursSwiftUiTests.swift
//  CoursSwiftUiTests
//
//  Created by Enzo Cosson on 15/10/2024.
//

import XCTest
@testable import CoursSwiftUi

final class CoursSwiftUiTests: XCTestCase {
    
    var viewModel: ModelAuth!

    override func setUp() {
        super.setUp()
        viewModel = ModelAuth()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testGiven_WhenLoginFalse() {

        viewModel.username = "jack"
        viewModel.password = "jill"
        
        let awaitedResult = false

        viewModel.checkCredentials()
        
        XCTAssertEqual(viewModel.isValid, awaitedResult, "L'authentification devrait échouer avec des identifiants incorrects.")
    }

    func testGiven_WhenLoginTrue() {

        viewModel.username = "admin"
        viewModel.password = "password"
        
        let awaitedResult = true
        
        viewModel.checkCredentials()
        
        XCTAssertEqual(viewModel.isValid, awaitedResult, "L'authentification devrait réussir avec des identifiants corrects.")
    }
    
    func testGiven_WhenLoginEitherTrueOrFalse() {
           viewModel.username = "user1"
           viewModel.password = "pass123"
           viewModel.checkCredentials()
           XCTAssertTrue(viewModel.isValid, "L'authentification devrait réussir avec les bons identifiants.")
           
           viewModel.username = "user3"
           viewModel.password = "wrongpass"
           viewModel.checkCredentials()
           XCTAssertFalse(viewModel.isValid, "L'authentification devrait échouer avec des identifiants incorrects.")
       }
}
