//
//  AuthServiceProtocol.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 16.04.2025.
//

import Foundation

protocol AuthServiceProtocol {
    
    func signIn(email: String, password: String) async throws
    
    func signUp(name: String, email: String, password: String, avatarURL: String?) async throws
    
    func signOut() async throws
    
    func getCurrentUserID() async throws -> String
    
    func observeAuthChanges() -> AsyncStream<AuthStateEvent>
    
}

enum AuthStateEvent {
    case initial(sessionExists: Bool)
    case signedIn
    case signedOut
    case expired
    case error(Error)
    case unknown
}
