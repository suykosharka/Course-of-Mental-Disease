//
//  Model.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 17.02.2025.
//

import Foundation

struct Profile: Decodable, Encodable {
    
    let name: String?
    let sex: String?
    let diagnosis: String?
    let birthDate: String?
    let avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case name = "full_name"
        case sex
        case diagnosis
        case birthDate = "birth_date"
        case avatarURL = "avatar_url"
  }
    
}
