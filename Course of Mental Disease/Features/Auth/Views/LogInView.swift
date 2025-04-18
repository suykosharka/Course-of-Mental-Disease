//
//  LogInPage.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 12.11.2023.
//

import SwiftUI

struct LogInView: View {
    
    @StateObject var viewModel = LogInViewViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                
                //Background
                AuthorizationPagesBackground()
                
                VStack(alignment: .center, spacing: 10) {
                    
                    //LogIn errors
                    
                    if let error = viewModel.errorMessage{
                        Text(error)
                            .frame(width: 250)
                            .font(.custom("appetite", size: 12))
                            .foregroundStyle(.pink.secondary)
                        
                    }
                    
                    //LogIn Form
                    TextField("E-mail:", text: $viewModel.email)
                        .frame(width: 250)
                        .modifier(textModifier(roundedCorners: 22, borderColor: .odeToGreen, textColor: .gray))
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .textContentType(.emailAddress)
                    
                    SecureField("Пароль:", text: $viewModel.password)
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
                                viewModel.logIn()
                            } label: {
                                Text("Войти")
                                    .modifier(buttonModifier(borderColor: .odeToGreen, textColor: .white, backgroundColor: .odeToGreen))
                            }
                        }
                        
                        //Sign Up Button
                        NavigationLink{
                            SignUpView()
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Text("Создать аккаунт")
                                .modifier(buttonModifier(borderColor: .odeToGreen, textColor: .white, backgroundColor: .odeToGreen))
                        }
                        
                    }
                    .frame(width: 300)
                    .padding(.top, 10)
                    
                }
            }
        }
        .tint(.deadSea)
        
    }
}

#Preview {
    LogInView()
}
