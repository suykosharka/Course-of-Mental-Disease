//
//  SupabaseSomaticService.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 16.04.2025.
//

import Foundation

final class SupabaseSomaticService: SomaticServiceProtocol {
    
    func fetchSomaticRecords(userID: String) async throws -> [Somatics] {
        try await supabase.from("somatics")
            .select()
            .eq("profile_id", value: userID)
            .execute()
            .value
    }
    
    func fetchSomaticAverages(userID: String, startDate: Date, endDate: Date) async throws -> SomaticAverages? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let response: [SomaticAverages] = try await
        supabase
            .rpc("get_average_somatic_rates",
                 params: [
                    "user_profile_id": userID,
                    "start_date": formatter.string(from: startDate),
                    "end_date": formatter.string(from: endDate)
                 ]
            ).execute()
            .value
        return response.first
    }
    
    func uploadSomatic(_ record: Somatics) async throws {
        try await supabase
            .from("somatics")
            .insert(record)
            .execute()
    }
    
}
