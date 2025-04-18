//
//  DIContainer.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 17.04.2025.
//

import Foundation

final class DIContainer {
    static let shared = DIContainer()

    let authService: any AuthServiceProtocol
    let storageService: StorageServiceProtocol
    let profileService: ProfileServiceProtocol
    let somaticService: SomaticServiceProtocol
    let errorHandler: ErrorHandlerProtocol

    private init() {
        self.authService = SupabaseAuthService()
        self.storageService = SupabaseStorageService()
        self.profileService = SupabaseProfileService()
        self.somaticService = SupabaseSomaticService()
        self.errorHandler = SupabaseErrorHandler()
    }
    
}
