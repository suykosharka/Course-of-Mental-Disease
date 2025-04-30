//
//  MainView.swift
//  Course of Mental Disease
//
//  Created by Илья Паршин on 08.11.2023.
//

import SwiftUI
import SwiftData

enum AuthScreen: Hashable {
    case login
    case signup
}

struct MainView: View {
    
    @StateObject var viewModel = MainViewViewModel()
    @StateObject var loadState = AppLoadStateManager.shared
    @State private var path = NavigationPath()
    @State private var showLoadScreen = true
    
    var body: some View {
        ZStack {
            if viewModel.isAuthenticated {
                SectionsFlowView()
            } else {
                NavigationStack(path: $path) {
                    LogInView {
                        path.append(AuthScreen.signup)
                    }
                    .navigationDestination(for: AuthScreen.self) { screen in
                        switch screen {
                        case .signup:
                            SignUpView {
                                path.removeLast()
                            }
                        case .login:
                            LogInView {
                                path.removeLast()
                            }
                        }
                    }
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
