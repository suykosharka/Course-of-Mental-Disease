//
//  PhysicalSymptomsViewViewModel.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 16.02.2025.
//

import Foundation
import Factory

final class SomaticViewViewModel: ObservableObject {
    
    @Published var startDate = Date()
    @Published var endDate = Date()
    @Published var range: DateRangeType = .today
    @Published var apetiteAverage: Double?
    @Published var sleepAverage: Double?
    @Published var energyAverage: Double?
    @Published var libidoAverage: Double?
    @Published var isLoading = true
    
    @Injected(\.somaticService) private var somaticService
    @Injected(\.authService) private var authService
    @Injected(\.errorHandler) private var errorHandler

    func getSomaticAvgs() async {
        do {
            await MainActor.run { isLoading = true }
            let dateRange = range.getDateRange(startDate: startDate, endDate: endDate)
            let currentUserID = try await authService.getCurrentUserID()
            if let averages = try await somaticService.fetchSomaticAverages(userID: currentUserID, startDate: dateRange.0, endDate: dateRange.1) {
                await MainActor.run {
                    apetiteAverage = averages.apetite
                    sleepAverage = averages.sleep
                    energyAverage = averages.energy
                    libidoAverage = averages.libido
                }
            } else {
                await MainActor.run {
                    apetiteAverage = nil
                    sleepAverage = nil
                    energyAverage = nil
                    libidoAverage = nil
                }
            }
            await MainActor.run { isLoading = false }
        } catch {
            errorHandler.handle(error)
        }
    }
    
}
