//
//  Course_of_Mental_DiseaseApp.swift
//  Course of Mental Disease
//
//  Created by Илья Паршин on 08.11.2023.
//

import SwiftUI
import SwiftData
import Supabase

@main
struct CourseOfMentalDiseaseApp: App {
    
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            User.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
    
    var body: some Scene {
        WindowGroup {
            MainView()
//                .modelContainer(sharedModelContainer)
        }
    }
}


