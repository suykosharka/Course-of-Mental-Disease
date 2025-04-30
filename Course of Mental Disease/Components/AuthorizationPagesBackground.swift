//
//  AuthorizationPages.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 15.11.2023.
//

import SwiftUI

struct AuthorizationPagesBackground: View {
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.deadSea, .whistlesGold]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            
            Circle()
                .scaleEffect(1.75)
                .foregroundColor(.white.opacity(0.15))
                .scaledToFit()
            
            Circle()
                .scaleEffect(1.25)
                .foregroundColor(.white.opacity(0.75))
            
        }
    }
}

#Preview {
    AuthorizationPagesBackground()
}
#Preview {
    SignUpView(onBackTap: { print("LogIn") })
}
#Preview {
    LogInView(onSignUpTap: { print("SignUp") })
}
