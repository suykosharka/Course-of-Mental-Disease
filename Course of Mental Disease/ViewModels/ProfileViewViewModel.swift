//
//  ProfileViewViewModel.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 16.02.2025.
//

import Storage
import Supabase
import SwiftUI
import Foundation
class ProfileViewViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var image: UIImage?
    
    func getInitialProfile() async {
        do {
          let currentUser = try await supabase.auth.session.user

          let profile: Profile =
          try await supabase
            .from("profiles")
            .select()
            .eq("id", value: currentUser.id)
            .single()
            .execute()
            .value

            if let avatarURL = profile.avatarURL, !avatarURL.isEmpty {
               try await downloadImage(path: avatarURL)
             }
            
            await MainActor.run {
                name = profile.name ?? ""
                email = profile.email ?? ""
            }

        } catch {
          debugPrint(error)
        }
      }
    
    private func downloadImage(path: String) async throws {
        let data = try await supabase.storage.from("avatars").download(path: path)
        await MainActor.run {
            image = UIImage(data: data)
        }
      }
    
    func logOut() {
        Task {
            try! await supabase.auth.signOut()
        }
    }
}
