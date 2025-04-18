//
//  SomaticAverges.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 17.04.2025.
//

import Foundation

struct SomaticAverages: Decodable {
    
    let apetite: Double?
    let sleep: Double?
    let energy: Double?
    let libido: Double?

    enum CodingKeys: String, CodingKey {
        case apetite = "average_apetite_rate"
        case sleep = "average_sleep_rate"
        case energy = "average_energy_rate"
        case libido = "average_libido_rate"
    }
    
}
