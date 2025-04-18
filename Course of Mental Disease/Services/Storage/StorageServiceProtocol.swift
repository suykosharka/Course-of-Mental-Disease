//
//  StorageServiceProtocol.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 16.04.2025.
//

import Foundation
import SwiftUI

protocol StorageServiceProtocol {
    
    func uploadImage(_ image: UIImage?) async throws -> String?
    
    func downloadImage(_ path: String) async throws -> Data
    
}
