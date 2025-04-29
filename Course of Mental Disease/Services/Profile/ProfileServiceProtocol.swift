//
//  ProfileServiceProtocol.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 16.04.2025.
//

import Foundation

protocol ProfileServiceProtocol {
    
    func fetchProfile(for userID: String) async throws -> Profile
    
    func updateProfile(for userID: String, profile: Profile) async throws
    
}
