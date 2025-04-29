//
//  ProfileViewViewModel.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 16.02.2025.
//

import SwiftUI
import Foundation
import Factory

enum Sex: String, CaseIterable, Identifiable {
    case male = "Мужской"
    case female = "Женский"
    case unspecified = "Не указан"
    
    var id: Self { self }
}

final class ProfileViewViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var name: String = ""
    @Published var birthDateString: String = ""
    @Published var birthDate: Date = Date()
    @Published var diagnosis: String = ""
    @Published var sex: Sex = .unspecified
    @Published var imageURL: String?
    @Published var profile: Profile?
    @Published var displayedImage: UIImage?
    @Published var pickedImage: UIImage? = nil
    private var originalImageData: Data?
    
    @Injected(\.profileService) private var profileService
    @Injected(\.authService) private var authService
    @Injected(\.storageService) private var storageService
    @Injected(\.errorHandler) private var errorHandler
    
    var avatarToDisplay: UIImage? {
        pickedImage ?? displayedImage
    }
    
    func getInitialProfile() async {
        do {
            await MainActor.run { self.isLoading = true }
            let currentUserID = try await authService.getCurrentUserID()
            let profile: Profile = try await profileService.fetchProfile(for: currentUserID)
            if let avatarURL = profile.avatarURL, !avatarURL.isEmpty {
               let data = try await storageService.downloadImage(avatarURL)
                await MainActor.run {
                    self.displayedImage = UIImage(data: data)
                    self.originalImageData = data
                }
             }
            await MainActor.run {
                self.profile = profile
                self.name = profile.name ?? ""
                self.birthDateString = profile.birthDate ?? ""
                self.diagnosis = profile.diagnosis ?? ""
                if let sex = profile.sex {
                    self.sex = Sex(rawValue: sex) ?? .unspecified
                }
                self.isLoading = false
            }
        } catch {
            errorHandler.handle(error)
        }
      }
    
    @MainActor func updateProfile () async {
        do {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let currentUserID = try await authService.getCurrentUserID()
            if let newImage = pickedImage,
               let imageData = newImage.aspectFittedToHeight(200).jpegData(compressionQuality: 0.2),
               imageData != originalImageData {
                imageURL = try await storageService.uploadImage(newImage)
                displayedImage = newImage
                originalImageData = imageData
                pickedImage = nil
            } else {
                imageURL = profile?.avatarURL
            }
            let updateProfile: Profile = Profile(name: name,
                                           sex: sex.rawValue,
                                           diagnosis: diagnosis,
                                           birthDate: formatter.string(from: birthDate),
                                           avatarURL: imageURL)
            try await profileService.updateProfile(for: currentUserID, profile: updateProfile)
            
        } catch {
            errorHandler.handle(error)
        }
    }
    
    func logOut() async {
        try! await authService.signOut()
        await MainActor.run {
            AppLoadStateManager.shared.reset()
        }
    }
    
    func getBirthDateFromString(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        guard let date = dateFormatter.date(from: dateString) else { return Date() }
        return date
    }
    
}
