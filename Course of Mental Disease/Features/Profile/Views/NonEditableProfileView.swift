//
//  NonEditableProfileView.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 29.04.2025.
//

import SwiftUI

struct NonEditableProfileView: View {
    
    @Binding var isEditable: Bool
    @ObservedObject var viewModel: ProfileViewViewModel
    
    @State var showingLogOutConfirmationDialog: Bool = false
    
    var body: some View {
        VStack {
            
            HStack {
                
                Spacer()
                
                //Edit Button
                Button("Редактировать"){
                    isEditable = true
                }
                .modifier(buttonModifier(borderColor: .highPlateau, textColor: .white, backgroundColor: .highPlateau))
                
            }
            .padding(.vertical, 15)
            
            if viewModel.isLoading {
                Spacer()
                ProgressView()
                Spacer()
            } else {
                VStack {
                    
                    //Avatar
                    Avatar(image: viewModel.avatarToDisplay, color: .highPlateau, diameter: 125)
                        .padding(15)
                    
                    VStack(alignment: .center, spacing: 15) {
                        
                        //User Info
                        //Name
                        HStack() {
                            Text("Имя: ")
                                .frame(alignment: .leading)
                                .layoutPriority(1)
                            Text(viewModel.profile?.name ?? "Не указано")
                                .frame(alignment: .center)
                        }
                        .modifier(textModifier(roundedCorners: 22, borderColor: .highPlateau, textColor: .gray))
                        
                        //BirthDate
                        HStack() {
                            Text("Дата рождения: ")
                                .frame(alignment: .center)
                                .layoutPriority(1)
                            Text((viewModel.profile?.birthDate ?? "Не указана").formattedDateString())
                                .frame(alignment: .center)
                        }
                        .modifier(textModifier(roundedCorners: 22, borderColor: .highPlateau, textColor: .gray))
                        
                        //Sex
                        HStack() {
                            Text("Пол: ")
                                .frame(alignment: .leading)
                                .layoutPriority(1)
                            Text(viewModel.profile?.sex ?? "Не указан")
                                .frame(alignment: .center)
                        }
                        .modifier(textModifier(roundedCorners: 22, borderColor: .highPlateau, textColor: .gray))
                        
                        //Diagnosis
                        HStack() {
                            Text("Диагноз: ")
                                .frame(alignment: .leading)
                                .layoutPriority(1)
                            Text(viewModel.profile?.diagnosis ?? "Не указан")
                                .frame(alignment: .center)
                        }
                        .modifier(textModifier(roundedCorners: 22, borderColor: .highPlateau, textColor: .gray))
                        
                    }
                    .fixedSize()
                    
                    //Log Out Button
                    Button("Выйти") {
                        showingLogOutConfirmationDialog = true
                    }
                    .modifier(buttonModifier(borderColor: .highPlateau, textColor: .white, backgroundColor: .highPlateau))
                    .padding(15)
                }
            }
        }
        .padding(15)
        .alert(Text("Вы действительно хотите выйти из аккаунта?"),
                isPresented: $showingLogOutConfirmationDialog,
                actions: {
                    Button("Да") {
                        Task {
                            await viewModel.logOut()
                        }
                    }
                    Button("Нет", role: .cancel) { }
                }
            )
        
    }
}

#Preview {
    NonEditableProfileView(isEditable: .constant(false), viewModel: ProfileViewViewModel())
}
