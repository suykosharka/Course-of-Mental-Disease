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
    @State var isEditable: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                
                //Background
                Rectangle()
                    .foregroundColor(.sugarMilk)
                    .ignoresSafeArea()

                //ProfileView
                VStack {
                    
                    if !isEditable {
                        
                        NonEditableProfileView(isEditable: $isEditable, viewModel: viewModel)
                        
                    } else {
                        
                        EditableProfileView(isEditable: $isEditable, viewModel: viewModel)
                        
                    }
                    
                    Spacer()
                    
                }
            }
        }
        .task(id: isEditable) {
            await viewModel.getInitialProfile()
        }
            
    }
}

#Preview {
    ProfileView()
}
