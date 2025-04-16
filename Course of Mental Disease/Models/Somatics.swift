//
//  Somatics.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 01.04.2025.
//

import Foundation

import Foundation
struct Somatics: Decodable, Encodable {
    let profile_id: UUID
    let date: String
    let apetiteRate: Int8
    let sleepRate: Int8
    let energyRate: Int8
    let libidoRate: Int8
    
    enum CodingKeys: String, CodingKey {
        case profile_id = "profile_id"
        case date = "created_at"
        case apetiteRate = "apetite_rate"
        case sleepRate = "sleep_rate"
        case energyRate = "energy_rate"
        case libidoRate = "libido_rate"
    }
}
