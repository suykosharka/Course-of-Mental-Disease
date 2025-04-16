//
//  PhysicalSymptomsViewViewModel.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 16.02.2025.
//

import Foundation
import Supabase

class SomaticViewViewModel: ObservableObject {
    
    @Published var showingPopover: Bool = false
    
    @Published var startDate = Date()
    @Published var endDate = Date()
    @Published var range: Ranges = .today
    
    enum Ranges: String, Identifiable, CaseIterable {
        case today = "Сегодня"
        case yesterday = "Вчера"
        case twoWeeks = "Последние 14 дней"
        case customRange = "Выбрать период"
        var id: Self { self }
    }
    
    @Published var apetiteAvg: Double?
    @Published var sleepAvg: Double?
    @Published var energyAvg: Double?
    @Published var libidoAvg: Double?

    func getSomaticAvgs() async {
        do {
            let dateRange = getDateRange()
            let currentUser = try await supabase.auth.session.user
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            
            let response: [[String:Double]] = try await
            supabase
                .rpc("get_average_somatic_rates",
                     params: [
                        "user_profile_id": currentUser.id.uuidString,
                        "start_date": formatter.string(from: dateRange.0),
                        "end_date": formatter.string(from: dateRange.1)
                     ]
                ).execute()
                .value
            
            if let data = response.first {
                await MainActor.run {
                    apetiteAvg = data["average_apetite_rate"]
                    sleepAvg = data["average_apetite_rate"]
                    energyAvg = data["average_apetite_rate"]
                    libidoAvg = data["average_apetite_rate"]
                }
            }
        } catch {
            debugPrint(error)
        }
    }
    
    func getDateRange() -> (Date, Date) {
        switch range {
        case .today: return (Date(), Date())
        case .yesterday: return (Date(timeIntervalSinceNow: -86400), Date(timeIntervalSinceNow: -86400))
        case .twoWeeks: return (Date(timeIntervalSinceNow: -1209600), Date())
        case .customRange: return (startDate, endDate)
        }
    }
    
    func isDataMissing() -> Bool {
        guard (apetiteAvg == nil) || (sleepAvg == nil) || (energyAvg == nil) || (libidoAvg == nil) else {
            return false
        }
        return true
    }
}
