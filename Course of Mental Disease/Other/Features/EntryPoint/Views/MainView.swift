//
//  MainView.swift
//  Course of Mental Disease
//
//  Created by Илья Паршин on 08.11.2023.
//

import SwiftUI
import SwiftData

struct MainView: View {
    
    @StateObject var viewModel = MainViewViewModel()
    @StateObject var loadState = AppLoadStateManager.shared
    @State private var showLoadScreen = true
    
    var body: some View {
        ZStack {
            Group {
                if viewModel.isAuthenticated {
                    SectionsFlowView()
                } else {
                    LogInView()
                }
            }
            if showLoadScreen && (!viewModel.isLoaded || (viewModel.isAuthenticated && !loadState.isAllDataLoaded)) {
                LoadScreen()
                    .onDisappear {
                        showLoadScreen = false
                    }
            }
        }
        .onAppear {
            AppLoadStateManager.shared.reset()
        }
        .task {
            await viewModel.authenticate()
        }
    }
}

#Preview {
    MainView()
}
