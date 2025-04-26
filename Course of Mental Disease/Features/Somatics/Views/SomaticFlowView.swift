//
//  SomaticFlowView.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 15.04.2025.
//

import SwiftUI

enum Tab {
    case new
    case indicators
    case list
}

struct SomaticFlowView: View {
    
    init() {
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor.sugarMilk
        
        let font = UIFont(name: "Comfortaa-Bold", size: 12) ?? UIFont.systemFont(ofSize: 16)
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .font: font,
            .foregroundColor: UIColor.gray
        ]
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .font: font,
            .foregroundColor: UIColor.muddyMauve
        ]
            
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        }

    @State private var selectedTab: Tab = .indicators
    
    var body: some View {
        TabView(selection: $selectedTab){
            
            SomaticNewRecord()
                .transition(.move(edge: .leading))
                .tabItem {
                    Label("Добавить", systemImage: "plus")
                }
                .tag(Tab.new)
            
            SomaticView()
                .transition(.move(edge: .trailing))
                .tabItem {
                    Label("Индикаторы", systemImage: "slider.horizontal.3")
                }
                .tag(Tab.indicators)
            
            SomaticRecordsListView()
                .transition(.opacity)
                .tabItem {
                    Label("Записи", systemImage: "list.dash")
                }
                .tag(Tab.list)
        }
        .onDisappear() {
            selectedTab = .indicators
        }
    }
}

#Preview {
    SomaticFlowView()
}
