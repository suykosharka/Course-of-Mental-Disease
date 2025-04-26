//
//  DIContainer.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 17.04.2025.
//

import Foundation
import Factory

extension Container {

    var authService: Factory<AuthServiceProtocol> {
        self { SupabaseAuthService() }.shared
    }
    var storageService: Factory<StorageServiceProtocol> {
        self { SupabaseStorageService() }.shared
    }
    var profileService: Factory<ProfileServiceProtocol> {
        self { SupabaseProfileService() }.shared
    }
    var somaticService: Factory<SomaticServiceProtocol> {
        self { SupabaseSomaticService() }.shared
    }
    var errorHandler: Factory<ErrorHandlerProtocol> {
        self { SupabaseErrorHandler() }.shared
    }
    
}
