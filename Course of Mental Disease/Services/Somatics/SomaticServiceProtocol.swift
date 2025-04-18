//
//  SomaticServiceProtocol.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 16.04.2025.
//

import Foundation

protocol SomaticServiceProtocol {
    
    func fetchSomaticAverages(userID: String, startDate: Date, endDate: Date) async throws -> SomaticAverages?
    
    func uploadSomatic(_ record: Somatics) async throws
    
}
