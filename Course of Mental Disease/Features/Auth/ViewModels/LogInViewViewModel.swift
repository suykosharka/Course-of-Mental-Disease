//
//  LogInViewViewModel.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 16.02.2025.
//

import Foundation
import Factory

final class LogInViewViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String? = nil
    
    @Injected(\.authService) private var authService
    @Injected(\.errorHandler) private var errorHandler
    
    func logIn() {
        guard errorMessage == nil else { return }
        Task {
            do{
                try await authService.signIn(email: email, password: password)
            } catch {
                errorHandler.handle(error)
                await MainActor.run { errorMessage = errorHandler.errorMessage(for: error) }
            }
        }
    }
}
