//
//  SignUpPage.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 12.11.2023.
//

import SwiftUI
import PhotosUI
import PopupView

struct SignUpView: View {
    
    @StateObject var viewModel = SignUpViewViewModel()
    
    @State private var albumShowSheet = false
    @State private var cameraShowSheet = false
    @State private var isPhotoPicker = false
    @State private var showError = false
    @State private var showPopover = false
    
    var body: some View {
        NavigationView {
            ZStack {
                
                //Background
                AuthorizationPagesBackground()
                
                VStack(alignment: .center, spacing: 10) {
                    
                    //Avatar + PhotoPicker
                    EditableAvatar(image: viewModel.image,
                                   color: .odeToGreen,
                                   diameter: 150,
                                   albumShowSheet: $albumShowSheet,
                                   cameraShowSheet: $cameraShowSheet,
                                   isPhotoPicker: $isPhotoPicker)
                    
                    //SignUp Form
                    TextField("E-mail:", text: $viewModel.email)
                        .frame(width: 250)
                        .modifier(textModifier(roundedCorners: 22, borderColor: .odeToGreen, textColor: .gray))
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    TextField("Имя:", text: $viewModel.name)
                        .frame(width: 250)
                        .modifier(textModifier(roundedCorners: 22, borderColor: .odeToGreen, textColor: .gray))
                        .disableAutocorrection(true)
                        .keyboardType(.default)
                        .textContentType(.givenName)
                    
                    HStack {
                        SecureField("Пароль:", text: $viewModel.password)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .textContentType(.password)
                        Image(systemName: "info.circle")
                            .onTapGesture {
                                showPopover.toggle()
                            }
                    }
                    .popover(isPresented: $showPopover) {
                        Text("Пароль должен состоять не менее чем из 6 символов и содержать заглавные и строчные буквы, а также как минимум одну цифру и спецсимвол")
                            .padding(3)
                            .font(.custom("Comfortaa-Bold", size: 12))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .presentationCompactAdaptation(.popover)
                    }
                    .frame(width: 250)
                    .modifier(textModifier(roundedCorners: 22, borderColor: .odeToGreen, textColor: .gray))
                    
                    //Sign up button
                    if (viewModel.password == "") || (viewModel.name == "") || (viewModel.email == "") {
                        Text("Создать")
                            .modifier(buttonModifier(borderColor: .gray, textColor: .white, backgroundColor: .gray))
                            .padding(.top, 10)
                        
                    }else {
                        Button {
                            Task {
                                await viewModel.signUp()
                            }
                        } label: {
                            Text("Создать")
                                .modifier(buttonModifier(borderColor: .odeToGreen, textColor: .white, backgroundColor: .odeToGreen))
                                .padding(.top, 10)
                            
                        }
                    }
                    
                    //LogIn Link
                    HStack(alignment: .center) {
                        Text("Уже есть аккунт? ")
                            .font(.custom("Comfortaa-Bold", size: 14))
                            .foregroundColor(.gray)
                        NavigationLink {
                            LogInView()
                                .navigationBarBackButtonHidden(true)
                        }label: {
                            Text("Войти")
                                .font(.custom("Comfortaa-Bold", size: 14))
                                .foregroundColor(.deadSea)
                        }
                    }
                    .padding(.top, 10)
                    
                }
            }
            .sheet(isPresented: $albumShowSheet) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: $viewModel.image)
                    .ignoresSafeArea()
            }
            .sheet(isPresented: $cameraShowSheet) {
                ImagePicker(sourceType: .camera, selectedImage: $viewModel.image)
                    .ignoresSafeArea()
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
    SignUpView()
}
