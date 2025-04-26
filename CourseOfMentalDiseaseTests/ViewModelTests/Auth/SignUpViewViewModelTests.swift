//
//  SignUpViewViewModelTests.swift
//  CourseOfMentalDiseaseTests
//
//  Created by Илья Паршин on 24.04.2025.
//

import Foundation
import XCTest
import Factory
@testable import CourseOfMentalDisease

final class SignUpViewViewModelTests: XCTestCase {

    var viewModel: SignUpViewViewModel!
    var mockAuthService: MockAuthService!
    var mockStorageService: MockStorageService!
    var mockErrorHandler: MockErrorHandler!

    override func setUp() {
        super.setUp()
        Container.shared.reset()
        
        mockAuthService = MockAuthService()
        mockStorageService = MockStorageService()
        mockErrorHandler = MockErrorHandler()

        Container.shared.authService.register { self.mockAuthService }
        Container.shared.storageService.register { self.mockStorageService }
        Container.shared.errorHandler.register { self.mockErrorHandler }

        viewModel = SignUpViewViewModel()
    }

    func testSignUp_Successful_CallsAllServices() async {
        viewModel.name = "Test"
        viewModel.email = "test@example.com"
        viewModel.password = "12345678"
        viewModel.image = UIImage(systemName: "person")

        await viewModel.signUp()

        XCTAssertTrue(mockStorageService.uploadImageCalled)
        XCTAssertTrue(mockAuthService.signUpCalled)
        XCTAssertEqual(mockAuthService.passedAvatarURL, "mock_url.jpeg")
        XCTAssertNil(viewModel.errorMessage)
    }

    func testSignUp_WhenImageIsNil_PassesNilToAvatarURL() async {
        viewModel.name = "Test"
        viewModel.email = "test@example.com"
        viewModel.password = "12345678"
        viewModel.image = nil

        await viewModel.signUp()

        XCTAssertTrue(mockStorageService.uploadImageCalled)
        XCTAssertTrue(mockAuthService.signUpCalled)
        XCTAssertNil(mockAuthService.passedAvatarURL)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testSignUp_WhenUploadFails_SetsErrorMessage() async {
        mockStorageService.shouldThrow = true
        mockErrorHandler.customMessage = "Ошибка загрузки"

        viewModel.name = "Test"
        viewModel.email = "test@example.com"
        viewModel.password = "12345678"
        viewModel.image = UIImage(systemName: "person")

        await viewModel.signUp()

        XCTAssertTrue(mockStorageService.uploadImageCalled)
        XCTAssertFalse(mockAuthService.signUpCalled)
        XCTAssertEqual(viewModel.errorMessage, "Ошибка загрузки")
        XCTAssertTrue(mockErrorHandler.handleCalled)
    }

    func testSignUp_WhenSignUpFails_SetsErrorMessage() async {
        mockAuthService.shouldThrowOnSignUp = true
        mockErrorHandler.customMessage = "Ошибка регистрации"

        viewModel.name = "Test"
        viewModel.email = "test@example.com"
        viewModel.password = "12345678"

        await viewModel.signUp()
        
        XCTAssertTrue(mockAuthService.signUpCalled)
        XCTAssertTrue(mockStorageService.uploadImageCalled)
        XCTAssertEqual(viewModel.errorMessage, "Ошибка регистрации")
        XCTAssertTrue(mockErrorHandler.handleCalled)
    }

    func testSignUp_WhenErrorMessageExists_DoesNotCallServices() async {
        viewModel.errorMessage = "Уже ошибка"
        await viewModel.signUp()
        
        XCTAssertFalse(mockAuthService.signUpCalled)
        XCTAssertFalse(mockStorageService.uploadImageCalled)
    }

}
