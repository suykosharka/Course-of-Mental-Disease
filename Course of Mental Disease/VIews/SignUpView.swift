//
//  SignUpPage.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 12.11.2023.
//

import SwiftUI
import PhotosUI

struct SignUpView: View {
    
    @StateObject var viewModel = SignUpViewViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                
                //Background
                AuthorizationPagesBackground()
                
                VStack(alignment: .center, spacing: 10) {
                    
                    //PhotoPicker
                    if let image = viewModel.image {
                        SignUpPFP(image: image)
                            .onTapGesture {
                                viewModel.isPhotoPicker = true
                            }
                            .confirmationDialog("Select your profile Picture", isPresented: $viewModel.isPhotoPicker) {
                                Button {
                                    viewModel.cameraShowSheet = true
                                } label: {
                                    Label("Take a photo", systemImage: "questionmark.circle")
                                }
                                
                                Button {
                                    viewModel.albumShowSheet = true
                                } label: {
                                    Label("Select from library", systemImage: "questionmark.circle")
                                }
                            }
                        
                    } else {
                        DefaultSignUpPFP()
                            .onTapGesture {
                                viewModel.isPhotoPicker = true
                            }
                            .confirmationDialog("Select your profile Picture", isPresented: $viewModel.isPhotoPicker) {
                                Button {
                                    viewModel.cameraShowSheet = true
                                } label: {
                                    Label("Take a photo", systemImage: "questionmark.circle")
                                }
                                
                                Button {
                                    viewModel.albumShowSheet = true
                                } label: {
                                    Label("Select from library", systemImage: "questionmark.circle")
                                }
                            }
                        
                    }
                    
                    //Form errors
                    if let error = viewModel.errorMessage{
                        Text(error)
                            .frame(width: 250)
                            .font(.custom("appetite", size: 12))
                            .foregroundStyle(.pink.secondary)
                        
                    }
                    
                    //SignUp Form
                    TextField("E-mail:", text: $viewModel.email)
                        .frame(width: 250, height: 10)
                        .modifier(textModifier(roundedCorners: 22, borderColor: .odeToGreen, textColor: .gray))
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    TextField("Имя:", text: $viewModel.name)
                        .frame(width: 250, height: 10)
                        .modifier(textModifier(roundedCorners: 22, borderColor: .odeToGreen, textColor: .gray))
                        .disableAutocorrection(true)
                        .textContentType(.oneTimeCode)
                    
                    SecureField("Пароль:", text: $viewModel.password)
                        .frame(width: 250, height: 10)
                        .modifier(textModifier(roundedCorners: 22, borderColor: .odeToGreen, textColor: .gray))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .textContentType(.oneTimeCode)
                    
                    //Sign up button
                    if (viewModel.password == "") || (viewModel.name == "") || (viewModel.email == "") {
                        Text("Создать")
                            .modifier(buttonModifier(borderColor: .gray, textColor: .white, backgroundColor: .gray))
                            .padding(.top, 10)
                        
                    }else {
                        Button {
                            viewModel.signUp()
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
            .sheet(isPresented: $viewModel.albumShowSheet) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: $viewModel.image)
                    .ignoresSafeArea()
            }
            .sheet(isPresented: $viewModel.cameraShowSheet) {
                ImagePicker(sourceType: .camera, selectedImage: $viewModel.image)
                    .ignoresSafeArea()
            }
        }
        .tint(.deadSea)
        
    }
}

#Preview {
    SignUpView()
}
