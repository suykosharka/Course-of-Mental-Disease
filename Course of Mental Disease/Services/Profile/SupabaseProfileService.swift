//
//  SupabaseProfileService.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 16.04.2025.
//

import Foundation

final class SupabaseProfileService: ProfileServiceProtocol {
    
    func fetchProfile(for userID: String) async throws -> Profile {
        try await supabase
          .from("profiles")
          .select()
          .eq("id", value: userID)
          .single()
          .execute()
          .value
    }
    
    func updateProfile(for userID: String, profile: Profile) async throws {
        try await supabase
            .from("profiles")
            .update(profile)
            .eq("id", value: userID)
            .execute()
    }
    
}
