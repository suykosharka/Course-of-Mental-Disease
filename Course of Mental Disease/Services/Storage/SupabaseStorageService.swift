//
//  SupabaseStorageService.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 16.04.2025.
//

import Foundation
import SwiftUI
import Supabase
import Storage

final class SupabaseStorageService: StorageServiceProtocol {
    
    func uploadImage(_ image: UIImage?) async throws -> String? {
        guard let data = image?.aspectFittedToHeight(200).jpegData(compressionQuality: 0.2) else { return nil }
        let filePath = "\(UUID().uuidString).jpeg"
        try await supabase.storage
          .from("avatars")
          .upload(
            filePath,
            data: data,
            options: FileOptions(contentType: "image/jpeg")
          )
        return filePath
      }
    
    func downloadImage(_ path: String) async throws -> Data {
        return try await supabase.storage.from("avatars").download(path: path)
    }
    
}
