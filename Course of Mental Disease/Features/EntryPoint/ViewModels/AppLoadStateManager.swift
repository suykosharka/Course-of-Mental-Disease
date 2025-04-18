//
//  AppLoadStateManager.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 17.04.2025.
//

import Foundation

final class AppLoadStateManager: ObservableObject {
    
    static let shared = AppLoadStateManager()
    
    @Published var isProfileLoaded: Bool = false
    @Published var isSomaticLoaded: Bool = false
    
    var isAllDataLoaded: Bool {
        isProfileLoaded && isSomaticLoaded
    }
    
    func reset() {
        isProfileLoaded = false
        isSomaticLoaded = false
    }
    
}
