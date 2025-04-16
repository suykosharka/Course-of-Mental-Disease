//
//  LogInViewViewModel.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 16.02.2025.
//

import Storage
import Supabase
import Foundation

import
 UIKit

class LogInViewViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String?
    
    init() {}
    
    
    func logIn() {
        errorMessage = nil
        guard validate() else {
            return
        }
        Task {
            do{
                try await supabase.auth.signIn(email: email, password: password)
            } catch {
                if let error = error as? AuthError {
                    if error.errorCode.rawValue == "invalid_credentials" {
                        await MainActor.run { errorMessage = "Неверное имя пользователя или пароль" }
                    } else { await MainActor.run { errorMessage = error.localizedDescription } }
                } else { print ("Ошибка: \(error.localizedDescription)")}
            }
        }
    }
    
    private func validate() -> Bool {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Убедитесь, что все поля заполнены"
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Неверный формат электронной почты"
            return false
        }
        
        return true
    }
}
