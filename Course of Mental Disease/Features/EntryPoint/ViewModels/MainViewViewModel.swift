//
//  MainViewViewModel.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 16.02.2025.
//

import Foundation
import Factory

final class MainViewViewModel: ObservableObject {
    
    @Published var isAuthenticated: Bool = false
    @Published var isLoaded: Bool = false
    
    @Injected(\.authService) private var authService: AuthServiceProtocol
    
    func authenticate() async {
        await MainActor.run { isLoaded = false }
        let start = Date()

        for await event in authService.observeAuthChanges() {
            switch event {
            case .initial(let sessionExists):
                await MainActor.run { isAuthenticated = sessionExists }
                
            case .signedIn:
                await MainActor.run { isAuthenticated = true }
                
            case .signedOut, .expired:
                await MainActor.run { isAuthenticated = false }
                
            case .error(let err):
                print("Auth error: \(err)")
                await MainActor.run { isAuthenticated = false }
                
            case .unknown:
                print("Unknown auth state")
                await MainActor.run { isAuthenticated = false }
            }
            let elapsed = Date().timeIntervalSince(start)
            if elapsed < 2 {
                try? await Task.sleep(nanoseconds: UInt64((2 - elapsed) * 1_000_000_000))
            }
            await MainActor.run { isLoaded = true }
        }
    }
    
}
