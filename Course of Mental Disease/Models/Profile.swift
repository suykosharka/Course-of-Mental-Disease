//
//  Model.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 17.02.2025.
//

import Foundation

struct Profile: Decodable {
    
  let email: String?
  let name: String?
  let avatarURL: String?

  enum CodingKeys: String, CodingKey {
    case email
    case name = "full_name"
    case avatarURL = "avatar_url"
  }
    
}
