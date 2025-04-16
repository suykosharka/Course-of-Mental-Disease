//
//  MainViewViewModel.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 16.02.2025.
//

import Foundation

class MainViewViewModel: ObservableObject {
    
    @Published var isAuthenticated: Bool = false
    @Published var isLoading: Bool = true
    
    func authenticate() async {
        await MainActor.run { isLoading = true }
        for await state in supabase.auth.authStateChanges {
            if [.initialSession, .signedIn, .signedOut].contains(state.event) {
                await MainActor.run { isAuthenticated = state.session != nil }
                sleep(4)
                await MainActor.run { isLoading = false }
            }
        }
    }
}
