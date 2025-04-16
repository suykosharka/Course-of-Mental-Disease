//
//  PhysicalSymptomsSectionViewModel.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 16.02.2025.
//

import Foundation
import Supabase

class SomaticSectionViewModel: ObservableObject {

    @Published var dateRange = (Date(timeIntervalSinceNow: -1209600), Date())
    //
    @Published var apetiteAvg: Double?
    @Published var sleepAvg: Double?
    @Published var energyAvg: Double?
    @Published var libidoAvg: Double?

    func getSomaticAvgs() async {
        do {
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
    
    func isDataMissing() -> Bool {
        guard (apetiteAvg == nil) || (sleepAvg == nil) || (energyAvg == nil) || (libidoAvg == nil) else {
            return false
        }
        return true
    }
}
