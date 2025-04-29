//
//  EditableProfileView.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 29.04.2025.
//

import SwiftUI

struct EditableProfileView: View {
    
    @Binding var isEditable: Bool
    @ObservedObject var viewModel: ProfileViewViewModel
    
    @State private var albumShowSheet = false
    @State private var cameraShowSheet = false
    @State private var isPhotoPicker = false
    @State private var showError = false
    @State private var showingUpdateConfirmationDialog = false
    
    var body: some View {
        
        VStack {
            HStack {
                
                //Cancel Button
                Button("Отменить"){
                    viewModel.pickedImage = nil
                    isEditable = false
                }
                .modifier(buttonModifier(borderColor: .highPlateau, textColor: .white, backgroundColor: .highPlateau))
                
                Spacer()
                
                //Edit Button
                Text("Редактировать")
                    .modifier(buttonModifier(borderColor: .gray, textColor: .white, backgroundColor: .gray))
                
            }
            .padding(.vertical, 15)
            
            //Avatar
            EditableAvatar(image: viewModel.avatarToDisplay, color: .highPlateau, diameter: 125, albumShowSheet: $albumShowSheet, cameraShowSheet: $cameraShowSheet, isPhotoPicker: $isPhotoPicker)
                .padding(15)
            
            VStack(alignment: .center, spacing: 15) {
                
                //User Info
                //Name
                HStack() {
                    Text("Имя: ")
                        .frame(alignment: .leading)
                        .layoutPriority(1)
                    TextField("Имя", text: $viewModel.name)
                        .frame(alignment: .center)
                }
                .frame(maxWidth: .infinity)
                .modifier(textModifier(roundedCorners: 22, borderColor: .highPlateau, textColor: .gray))
                 
                //BirthDate
                HStack() {
                    Text("Дата рождения: ")
                        .frame(alignment: .center)
                        .fixedSize(horizontal: false, vertical: true)
                        .layoutPriority(1)
                    DatePicker("", selection: $viewModel.birthDate,
                               in: ...Date(),
                            displayedComponents: .date)
                    .labelsHidden()
                    .frame(maxHeight: 0)
                }
                .frame(maxWidth: .infinity)
                .modifier(textModifier(roundedCorners: 22, borderColor: .highPlateau, textColor: .gray))
                
                //Sex
                HStack() {
                    Text("Пол: ")
                        .frame(alignment: .leading)
                        .layoutPriority(1)
                    Menu {
                        Picker("", selection: $viewModel.sex,
                               content: {
                            ForEach(Sex.allCases) { data in
                                Text(data.rawValue).tag(data)
                            }
                        })
        
                    }
                    label: {
                        HStack() {
                            Text(viewModel.sex.rawValue)
                            Image(systemName: "chevron.down")
                        }
                        .font(.custom("Comfortaa-Bold", size: 15))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity)
                .modifier(textModifier(roundedCorners: 22, borderColor: .highPlateau, textColor: .gray))
                
                //Diagnosis
                HStack() {
                    Text("Диагноз: ")
                        .frame(alignment: .leading)
                        .layoutPriority(1)
                    TextField("Диагноз", text: $viewModel.diagnosis)
                        .frame(alignment: .center)
                }
                .frame(maxWidth: .infinity)
                .modifier(textModifier(roundedCorners: 22, borderColor: .highPlateau, textColor: .gray))
                
            }
            .fixedSize()
            
            //Save Button
            Button("Сохранить") {
                showingUpdateConfirmationDialog = true
            }
            .modifier(buttonModifier(borderColor: .highPlateau, textColor: .white, backgroundColor: .highPlateau))
            .padding(15)
        }
        .padding(15)
        .sheet(isPresented: $albumShowSheet) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $viewModel.pickedImage)
                .ignoresSafeArea()
        }
        .sheet(isPresented: $cameraShowSheet) {
            ImagePicker(sourceType: .camera, selectedImage: $viewModel.pickedImage)
                .ignoresSafeArea()
        }
        .alert(Text("Сохранить изменения?"),
                isPresented: $showingUpdateConfirmationDialog,
                actions: {
                    Button("Сохранить") {
                        Task {
                            await viewModel.updateProfile()
                            await MainActor.run { isEditable = false }
                        }
                    }
                    Button("Отменить", role: .cancel) { }
                }
            )
        .onAppear() {
            viewModel.birthDate = viewModel.getBirthDateFromString(viewModel.birthDateString)
        }
        
    }
}

#Preview {
    EditableProfileView(isEditable: .constant(true), viewModel: ProfileViewViewModel())
}
