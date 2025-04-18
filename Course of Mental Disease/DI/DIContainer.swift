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
        self { SupabaseAuthService() }
    }
    var storageService: Factory<StorageServiceProtocol> {
        self { SupabaseStorageService() }
    }
    var profileService: Factory<ProfileServiceProtocol> {
        self { SupabaseProfileService() }
    }
    var somaticService: Factory<SomaticServiceProtocol> {
        self { SupabaseSomaticService() }
    }
    var errorHandler: Factory<ErrorHandlerProtocol> {
        self { SupabaseErrorHandler() }
    }
    
}
