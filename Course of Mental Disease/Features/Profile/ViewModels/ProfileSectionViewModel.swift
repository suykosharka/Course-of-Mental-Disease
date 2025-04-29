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
    
    @Published var name = "Имя"
    @Published var birthDate = "Дата рождения"
    @Published var diagnosis = "Диагноз"
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
                    self.image = UIImage(data: data)
                }
             }
            await MainActor.run {
                self.name = profile.name ?? "Имя"
                self.birthDate = profile.birthDate ?? "Дата рождения"
                self.diagnosis = profile.diagnosis ?? "Диагноз"
                AppLoadStateManager.shared.isProfileLoaded = true
            }
        } catch {
            errorHandler.handle(error)
        }
      }
    
}
