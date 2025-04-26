//
//  MockAuthService.swift
//  CourseOfMentalDiseaseTests
//
//  Created by Илья Паршин on 23.04.2025.
//

import Foundation
@testable import CourseOfMentalDisease

final class MockAuthService: AuthServiceProtocol {
    
    var signInCalled = false
    var signUpCalled = false
    var shouldThrowOnSignIn = false
    var shouldThrowOnSignUp = false
    var passedAvatarURL: String?

    func signIn(email: String, password: String) async throws {
        signInCalled = true
        if shouldThrowOnSignIn {
            throw DummyError.some
        }
    }

    func signUp(name: String, email: String, password: String, avatarURL: String?) async throws {
        signUpCalled = true
        passedAvatarURL = avatarURL
        if shouldThrowOnSignUp {
            throw DummyError.some
        }
    }

    func signOut() async throws {}
    func getCurrentUserID() async throws -> String { return "123" }

    func observeAuthChanges() -> AsyncStream<AuthStateEvent> {
        AsyncStream { _ in }
    }
}

enum DummyError: Error {
    case some
}
