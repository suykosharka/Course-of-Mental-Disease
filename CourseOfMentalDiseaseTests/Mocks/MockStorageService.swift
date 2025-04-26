//
//  MockStorageService.swift
//  CourseOfMentalDiseaseTests
//
//  Created by Илья Паршин on 23.04.2025.
//

import Foundation
import SwiftUI
@testable import CourseOfMentalDisease

final class MockStorageService: StorageServiceProtocol {
    var uploadImageCalled = false
    var shouldThrow = false
    var returnedURL: String? = "mock_url.jpeg"

    func uploadImage(_ image: UIImage?) async throws -> String? {
        uploadImageCalled = true
        guard image != nil else { return nil }
        if shouldThrow {
            throw DummyError.some
        }
        return returnedURL
    }

    func downloadImage(_ path: String) async throws -> Data {
        return Data()
    }
}

