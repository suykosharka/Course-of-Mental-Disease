//
//  ErrorHandlerProtocol.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 17.04.2025.
//

import Foundation

protocol ErrorHandlerProtocol {
    
    func errorMessage(for error: Error) -> String?
    
    func handle(_ error: Error)
    
}
