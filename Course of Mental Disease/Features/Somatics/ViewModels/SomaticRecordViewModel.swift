//
//  SomaticRecordViewViewModel.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 28.04.2025.
//

import Foundation
import Factory

@MainActor final class SomaticRecordViewModel: ObservableObject {
    
    @Published var record: Somatics
    @Published var apetite: Rates.Apetite
    @Published var sleep: Rates.Sleep
    @Published var energy: Rates.Energy
    @Published var libido: Rates.Libido
    
    init(record: Somatics) {
        self.record = record
        self.apetite = Rates.Apetite(rawValue: record.apetiteRate) ?? .usual
        self.sleep = Rates.Sleep(rawValue: record.sleepRate) ?? .usual
        self.energy = Rates.Energy(rawValue: record.energyRate) ?? .usual
        self.libido = Rates.Libido(rawValue: record.libidoRate) ?? .usual
    }
    
    @Injected(\.authService) private var authService
    @Injected(\.somaticService) private var somaticService
    @Injected(\.errorHandler) private var errorHandler
    
    func updateSomaticRecord() async {
        do {
            let newRecord = Somatics(profile_id: record.profile_id,
                                     date: record.date,
                                     apetiteRate: apetite.rawValue,
                                     sleepRate: sleep.rawValue,
                                     energyRate: energy.rawValue,
                                     libidoRate: libido.rawValue)
           try await somaticService.updateSomaticRecord(newRecord)
        }catch {
            errorHandler.handle(error)
        }
    }
    
    func deleteSomaticRecord() async {
        do {
            try await somaticService.deleteSomaticRecord(record)
        }catch {
            errorHandler.handle(error)
        }
    }
    
}
