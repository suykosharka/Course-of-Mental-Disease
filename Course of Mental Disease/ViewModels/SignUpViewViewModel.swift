//
//  SignUpViewViewModel.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 16.02.2025.
//
import Storage
import Supabase
import Foundation
import SwiftUI

class SignUpViewViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var image: UIImage? = nil
    @Published var errorMessage: String?
    
    @Published var albumShowSheet = false
    @Published var cameraShowSheet = false
    @Published var isPhotoPicker = false
    
    init() {}
    
    func signUp() {
        errorMessage = nil
        guard validate() else {
            return
        }
        Task {
            do {
                let imageURL = try await uploadImage()
                try await supabase.auth.signUp(email: email, password: password, data: [
                    "full_name": .string(name),
                    "avatar_url": imageURL != nil  ? .string(imageURL!) : nil
                ])
            } catch {
                return
            }
        }
        
    }
    
    private func uploadImage() async throws -> String? {
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
    
    private func validate() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Убедитесь, что все поля заполнены"
            return false
        }

        guard email.isValidEmail else {
            errorMessage = "Неккоректный формат электронной почты"
            return false
        }
        
        guard password.isValidPassword else {
            errorMessage = "Пароль должен состоять не менее, чем из 6 символов, и содержать заглавные и строчные буквы, а также как минимум одну цифру и спец. знак"
            return false
        }
        return true
        
    }

}
