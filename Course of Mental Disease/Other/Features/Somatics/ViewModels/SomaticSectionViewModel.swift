//
//  PhysicalSymptomsSectionViewModel.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 16.02.2025.
//

import Foundation
import Factory

final class SomaticSectionViewModel: ObservableObject {

    @Published var dateRange = (Date(timeIntervalSinceNow: -1209600), Date())
    @Published var apetiteAverage: Double?
    @Published var sleepAverage: Double?
    @Published var energyAverage: Double?
    @Published var libidoAverage: Double?
    
    @Injected(\.somaticService) private var somaticService
    @Injected(\.authService) private var authService
    @Injected(\.errorHandler) private var errorHandler

    func getSomaticAvgs() async {
        do {
            let currentUserID = try await authService.getCurrentUserID()
            if let averages = try await somaticService.fetchSomaticAverages(userID: currentUserID, startDate: dateRange.0, endDate: dateRange.1) {
                await MainActor.run {
                    apetiteAverage = averages.apetite
                    sleepAverage = averages.sleep
                    energyAverage = averages.energy
                    libidoAverage = averages.libido
                    AppLoadStateManager.shared.isSomaticLoaded = true
                }
            } else {
                await MainActor.run {
                    apetiteAverage = nil
                    sleepAverage = nil
                    energyAverage = nil
                    libidoAverage = nil
                    AppLoadStateManager.shared.isSomaticLoaded = true
                }
            }
        } catch {
            errorHandler.handle(error)
        }
    }
    
}
