//
//  SomaticRecordsListViewModel.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 02.04.2025.
//

import Foundation
import Factory

final class SomaticRecordsListViewModel: ObservableObject {
    
    @Injected(\.authService) private var authService
    @Injected(\.somaticService) private var somaticService
    @Injected(\.errorHandler) private var errorHandler
    @Published var isLoading = false
        private var currentPage = 1
        private var canLoadMore = true

    
    @Published var somatics: [Somatics]? = nil
    
    func fetchSomatics() async {
        do {
            let currentUserId = try await authService.getCurrentUserID()
            let somatics = try await somaticService.fetchSomaticRecords(userID: currentUserId)
            await MainActor.run { self.somatics = somatics }
        } catch {
            errorHandler.handle(error)
        }
    }
}
