//
//  SupabaseErrorHandler.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 17.04.2025.
//

import Foundation
import Supabase

final class SupabaseErrorHandler: ErrorHandlerProtocol {
    
    func errorMessage(for error: Error) -> String? {
        if let validationError = error as? AppValidationError {
            return validationError.localizedDescription
        }
        if let authError = error as? AuthError,
           authError.errorCode.rawValue == "invalid_credentials" {
            return "Неверное имя пользователя или пароль"
        }
        if let dbError = error as? PostgrestError,
           dbError.code == "23505" {
            return "Запись с такими данными уже существует"
        }
        return nil
    }

    func handle(_ error: Error) {
        // TODO: logging
        print("Error logged: \(error)")
    }
    
}
