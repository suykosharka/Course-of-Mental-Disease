//
//  LogInView.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 12.11.2023.
//

import SwiftUI
import PopupView

struct LogInView: View {
    
    var onSignUpTap: () -> Void
    @StateObject var viewModel = LogInViewViewModel()
    @State private var showError = false
    
    var body: some View {
        ZStack {
            
            //Background
            AuthorizationPagesBackground()
            
            VStack(alignment: .center, spacing: 10) {
                
                //LogIn Form
                TextField("E-mail:", text: $viewModel.email)
                    .padding(3)
                    .frame(width: 250)
                    .modifier(textModifier(roundedCorners: 22, borderColor: .odeToGreen, textColor: .gray))
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .textContentType(.emailAddress)
                
                SecureField("Пароль:", text: $viewModel.password)
                    .padding(3)
                    .frame(width: 250)
                    .modifier(textModifier(roundedCorners: 22, borderColor: .odeToGreen, textColor: .gray))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .textContentType(.password)
                
                HStack(alignment: .center) {
                    
                    //Log In Button
                    if viewModel.email == "" || viewModel.password == "" {
                        Text("Войти")
                            .modifier(buttonModifier(borderColor: .gray, textColor: .white, backgroundColor: .gray))
                    }else {
                        Button {
                            Task {
                                await viewModel.logIn()
                            }
                        } label: {
                            Text("Войти")
                                .modifier(buttonModifier(borderColor: .odeToGreen, textColor: .white, backgroundColor: .odeToGreen))
                        }
                    }
                    
                    //Sign Up Button
                    Text("Создать аккаунт")
                        .modifier(buttonModifier(borderColor: .odeToGreen, textColor: .white, backgroundColor: .odeToGreen))
                        .onTapGesture {
                            onSignUpTap()
                        }
                    
                }
                .frame(width: 300)
                .padding(.top, 10)
                
            }
        }
        .tint(.deadSea)
        .onReceive(viewModel.$errorMessage.compactMap { $0 }) { _ in
            showError = true
        }
        .floater(isShowing: $showError, message: $viewModel.errorMessage, color: .pink)
        
    }
}

#Preview {
    LogInView(onSignUpTap: { print("SignUp") })
}
