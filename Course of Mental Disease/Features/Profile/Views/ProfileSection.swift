//
//  Profile.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 08.11.2023.
//

import SwiftUI
import SwiftData

struct ProfileSection: View {

    @StateObject var viewModel = ProfileSectionViewModel()
    
    var body: some View {
            ZStack(alignment: .center) {
                
                //Frame
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(
                        gradient: .init(colors: [.aspenYellow, .brilliantBeige]),
                          startPoint: .leading,
                          endPoint: .bottom
                        ))
                    .frame(height: 150)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.highPlateau, lineWidth: 3))
                
                HStack(alignment: .center) {
                    
                    //Avatar
                    if let image = viewModel.image {
                        PFP(image: image)
                    } else {
                        DefaultPFP()
                    }
                    
                    //Profile Info
                    VStack (alignment: .center, spacing: 15){
                        Text(viewModel.name)
                            .frame(width: 155, height: 0)
                            .modifier(textModifier(roundedCorners: 22, borderColor: .highPlateau, textColor: .gray))
                        Text(viewModel.email)
                            .frame(width: 155, height: 0)
                            .modifier(textModifier(roundedCorners: 22, borderColor: .highPlateau, textColor: .gray))
                        Text(viewModel.name)
                            .frame(width: 155, height: 0)
                            .modifier(textModifier(roundedCorners: 22, borderColor: .highPlateau, textColor: .gray))
                    }
                }
            }
            .padding(10)
            .task {
                await viewModel.getInitialProfile()
            }
        
    }
}

#Preview {
    ProfileSection()
}
