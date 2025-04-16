//
//  ContentView.swift
//  Course of Mental Disease
//
//  Created by Илья Паршин on 08.11.2023.
//

import SwiftUI
import SwiftData

struct MainView: View {
    
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        ZStack {
            Group {
                if viewModel.isAuthenticated {
                    MainPageView()
                } else {
                    LogInView()
                }
            }
            if viewModel.isLoading {
                LoadScreen()
            }
        }
        .task {
            await viewModel.authenticate()
        }
    }
}
#Preview {
    MainView()
}
