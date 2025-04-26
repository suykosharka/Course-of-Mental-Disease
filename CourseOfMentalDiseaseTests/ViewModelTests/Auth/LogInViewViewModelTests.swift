//
//  LogInViewViewModelTests.swift
//  CourseOfMentalDiseaseTests
//
//  Created by Илья Паршин on 23.04.2025.
//

import XCTest
import Factory
@testable import CourseOfMentalDisease

final class LogInViewViewModelTests: XCTestCase {

    var viewModel: LogInViewViewModel!
    var mockAuthService: MockAuthService!
    var mockErrorHandler: MockErrorHandler!

    override func setUp() {
        super.setUp()
        Container.shared.reset()
        
        mockAuthService = MockAuthService()
        mockErrorHandler = MockErrorHandler()

        Container.shared.authService.register { self.mockAuthService }
        Container.shared.errorHandler.register { self.mockErrorHandler }

        viewModel = LogInViewViewModel()
    }

    func testLogIn_SuccessfulLogin_CallsAuthService() async {
        viewModel.email = "tes@example.com"
        viewModel.password = "12345678"

        await viewModel.logIn()

        XCTAssertTrue(mockAuthService.signInCalled)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testLogIn_WhenAuthServiceFails_SetsErrorMessage() async {
        mockAuthService.shouldThrowOnSignIn = true
        mockErrorHandler.customMessage = "Неверный логин"

        viewModel.email = "tes@example.com"
        viewModel.password = "12345678"

        await viewModel.logIn()

        XCTAssertTrue(mockAuthService.signInCalled)
        XCTAssertEqual(viewModel.errorMessage, "Неверный логин")
        XCTAssertTrue(mockErrorHandler.handleCalled)
    }

    func testLogIn_WhenErrorMessageExists_DoesNotCallAuthService() async {
        viewModel.errorMessage = "Уже ошибка"
        viewModel.email = "tes@example.com"
        viewModel.password = "12345678"

        await viewModel.logIn()

        XCTAssertFalse(mockAuthService.signInCalled)
    }

}

