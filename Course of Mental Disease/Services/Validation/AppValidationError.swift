//
//  AppValidationError.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 17.04.2025.
//

import Foundation

enum AppValidationError: LocalizedError {
    
    case emptyFields
    case invalidEmail
    case weakPassword

    var errorDescription: String? {
        switch self {
        case .emptyFields: return "Убедитесь, что все поля заполнены"
        case .invalidEmail: return "Некорректный формат электронной почты"
        case .weakPassword: return "Пароль должен состоять не менее чем из 6 символов и содержать заглавные и строчные буквы, а также как минимум одну цифру и спец. знак"
        }
    }
    
}
