//
//  ProfileDetail.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 09.11.2023.
//

import SwiftUI
import SwiftData

struct ProfileView: View {

    @StateObject var viewModel = ProfileViewViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                
                //Background
                Rectangle()
                    .foregroundColor(.sugarMilk)
                    .ignoresSafeArea()

                ScrollView {
                    
                    VStack {
                        
                        //Avatar
                        Avatar(image: viewModel.image, color: .highPlateau, diameter: 125)
                        
                        //User Info
                        Text(viewModel.name)
                            .frame(width: 100, height: 0)
                            .modifier(textModifier(roundedCorners: 22, borderColor: .highPlateau, textColor: .gray))
                        
                        //Log Out Button
                        Text("Log Out")
                            .modifier(buttonModifier(borderColor: .highPlateau, textColor: .white, backgroundColor: .highPlateau))
                            .onTapGesture {
                                viewModel.logOut()
                            }

                        Text("Delete")
                            .modifier(buttonModifier(borderColor: .highPlateau, textColor: .white, backgroundColor: .highPlateau))
                        
                        Button("Edit"){
                            print("Edit")
                        }
                        .modifier(buttonModifier(borderColor: .highPlateau, textColor: .white, backgroundColor: .highPlateau))
                        
                    }
                    .padding(15)
                }
            }
        }
        .task {
            await viewModel.getInitialProfile()
        }
            
    }
}

#Preview {
    ProfileView()
}
