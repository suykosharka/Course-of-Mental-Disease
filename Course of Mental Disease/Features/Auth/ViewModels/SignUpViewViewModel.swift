//
//  SignUpViewViewModel.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 16.02.2025.
//

import Foundation
import SwiftUI
import Factory

final class SignUpViewViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var image: UIImage? = nil
    @Published var errorMessage: String? = nil
    
    @Injected(\.authService) private var authService
    @Injected(\.storageService) private var storageService
    @Injected(\.errorHandler) private var errorHandler
    
    func signUp() async {
        guard errorMessage == nil else { return }
        do {
            let imageURL = try await storageService.uploadImage(image)
            try await authService.signUp(name: name, email: email, password: password, avatarURL: imageURL)
        } catch {
            errorHandler.handle(error)
            await MainActor.run { errorMessage = errorHandler.errorMessage(for: error) }
        }
    }
}
