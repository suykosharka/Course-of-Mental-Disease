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
        if let authError = error as? AuthError {
            switch authError.errorCode.rawValue {
                        case "invalid_login", "invalid_credentials":
                            return "Неверный email или пароль"
                        case "user_already_exists":
                            return "Пользователь с таким email уже существует"
                        case "validation_failed":
                            return "Неверный формат email"
                        case "weak_password":
                            return "Пароль слишком простой"
                        default:
                            return authError.message
                        }
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
