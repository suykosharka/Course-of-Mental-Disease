//
//  SomaticNewRecordViewModel.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 31.03.2025.
//

import Foundation
import Supabase

class SomaticNewRecordViewModel: ObservableObject {
    
    @Published var showAlert = false
    @Published var isUploaded: Bool = false
    @Published var apetiteValue: Rates.Apetite = .usual
    @Published var sleepValue: Rates.Sleep = .usual
    @Published var energyValue: Rates.Energy = .usual
    @Published var libidoValue: Rates.Libido = .usual
    @Published var date: Date = Date()
    
    func uploadNewRecord() {
        Task {
            do {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let currentUser = try await supabase.auth.session.user
                let somatics = Somatics(profile_id: currentUser.id, date: formatter.string(from: date),
                                        apetiteRate: apetiteValue.rawValue, sleepRate: sleepValue.rawValue,
                                        energyRate: energyValue.rawValue, libidoRate: libidoValue.rawValue)
                try await supabase
                    .from("somatics")
                    .insert(somatics)
                    .execute()
                
                await MainActor.run { self.isUploaded = true }
                
            } catch {
                if let error = error as? PostgrestError {
                    if error.code == "23505" {
                        await MainActor.run { self.showAlert = true }
                        print("Запись с такой датой уже сещуществует.")
                    } else { print("Ошибка: \(error)") }
                } else { print ("Неизвестная ошибка: \(error.localizedDescription)")}
            }
        }
    }
}
