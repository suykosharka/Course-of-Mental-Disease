//
//  ValidationService.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 16.04.2025.
//

import Foundation

final class ValidationService {
    
    static func validateEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    static func validatePassword(_ password: String) -> Bool {
        //Потом поменять
        let passwordRegEx = "^.*(?=.{6,})(?=.*[A-Z])(?=.*[a-zA-Z])((?=.*\\d)|(?=.*[_!#$%&?])).*$"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }

    static func validateNotEmpty(_ string: String) -> Bool {
        !string.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
}
