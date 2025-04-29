//
//  SomaticRecordsListViewModel.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 02.04.2025.
//

import Foundation
import Factory

final class SomaticRecordsListViewModel: ObservableObject {
    
    @Published var isRecordsLoading = false
    @Published var somatics: [Somatics]? = nil
    
    @Injected(\.authService) private var authService
    @Injected(\.somaticService) private var somaticService
    @Injected(\.errorHandler) private var errorHandler
    
    func fetchSomatics() async {
        do {
            await MainActor.run { self.isRecordsLoading = true }
            let currentUserId = try await authService.getCurrentUserID()
            let somatics = try await somaticService.fetchSomaticRecords(userID: currentUserId)
            await MainActor.run {
                self.somatics = somatics
                self.isRecordsLoading = false
            }
        } catch {
            errorHandler.handle(error)
        }
    }
}
