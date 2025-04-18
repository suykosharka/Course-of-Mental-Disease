//
//  ProfileSectionViewModel.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 16.02.2025.
//

import SwiftUI
import Foundation
import Factory

final class ProfileSectionViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var email = ""
    @Published var image: UIImage?
    
    @Injected(\.profileService) private var profileService
    @Injected(\.authService) private var authService
    @Injected(\.storageService) private var storageService
    @Injected(\.errorHandler) private var errorHandler
    
    func getInitialProfile() async {
        do {
            let currentUserID = try await authService.getCurrentUserID()
            let profile: Profile = try await profileService.fetchProfile(for: currentUserID)
            if let avatarURL = profile.avatarURL, !avatarURL.isEmpty {
               let data = try await storageService.downloadImage(avatarURL)
                await MainActor.run {
                    image = UIImage(data: data)
                }
             }
            await MainActor.run {
                name = profile.name ?? ""
                email = profile.email ?? ""
                AppLoadStateManager.shared.isProfileLoaded = true
            }
        } catch {
            errorHandler.handle(error)
        }
      }
    
}
