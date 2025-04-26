//
//  MockErrorHandler.swift
//  CourseOfMentalDiseaseTests
//
//  Created by Илья Паршин on 23.04.2025.
//

import Foundation
@testable import CourseOfMentalDisease

final class MockErrorHandler: ErrorHandlerProtocol {
    var handleCalled = false
    var customMessage: String?

    func errorMessage(for error: Error) -> String? {
        return customMessage
    }

    func handle(_ error: Error) {
        handleCalled = true
    }
}
