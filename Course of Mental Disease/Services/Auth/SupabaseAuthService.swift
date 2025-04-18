//
//  SupabaseAuthService.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 16.04.2025.
//

import Foundation
import Supabase

final class SupabaseAuthService: AuthServiceProtocol {
    
    func signIn(email: String, password: String) async throws {
        try await supabase.auth.signIn(email: email, password: password)
    }
    
    func signUp(name: String, email: String, password: String, avatarURL: String?) async throws {
        try await supabase.auth.signUp(email: email, password: password, data: [
            "full_name": .string(name),
            "avatar_url": avatarURL != nil  ? .string(avatarURL!) : nil
        ])
    }
    
    func signOut() async throws {
        try! await supabase.auth.signOut()
    }
    
    func getCurrentUserID() async throws -> String {
        try await supabase.auth.session.user.id.uuidString
    }
    
    func observeAuthChanges() -> AsyncStream<AuthStateEvent> {
        return AsyncStream { continuation in
            Task {
                for await state in supabase.auth.authStateChanges {
                    switch state.event {
                    case .initialSession:
                        continuation.yield(.initial(sessionExists: state.session != nil))
                    case .signedIn:
                        continuation.yield(.signedIn)
                    case .signedOut:
                        continuation.yield(.signedOut)
                    case .userDeleted:
                        continuation.yield(.expired)
                    default:
                        continuation.yield(.unknown)
                    }
                }
            }
        }
    }
    
}
