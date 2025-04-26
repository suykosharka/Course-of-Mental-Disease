//
//  SomaticNewRecordViewModel.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 31.03.2025.
//

import Foundation
import Factory

final class SomaticNewRecordViewModel: ObservableObject {
    
    @Published var errorMessage: String? = nil
    @Published var successMessage: String? = nil
    @Published var isUploaded: Bool = false
    @Published var apetiteValue: Rates.Apetite = .usual
    @Published var sleepValue: Rates.Sleep = .usual
    @Published var energyValue: Rates.Energy = .usual
    @Published var libidoValue: Rates.Libido = .usual
    @Published var date: Date = Date()
    
    @Injected(\.somaticService) private var somaticService
    @Injected(\.authService) private var authService
    @Injected(\.errorHandler) private var errorHandler
    
    func uploadNewRecord() async {
        guard errorMessage == nil else { return }
        do {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let currentUserID = try await authService.getCurrentUserID()
            let somatics = Somatics(profile_id: currentUserID, date: formatter.string(from: date),
                                    apetiteRate: apetiteValue.rawValue, sleepRate: sleepValue.rawValue,
                                    energyRate: energyValue.rawValue, libidoRate: libidoValue.rawValue)
            try await somaticService.uploadSomatic(somatics)
            await MainActor.run { successMessage = "Запись создана!" }
        } catch {
            errorHandler.handle(error)
            await MainActor.run { errorMessage = errorHandler.errorMessage(for: error) }
        }
    }
}
