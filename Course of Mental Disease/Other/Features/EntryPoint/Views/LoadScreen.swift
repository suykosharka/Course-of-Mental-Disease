//
//  LoadScreen.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 13.04.2025.
//

import SwiftUI

struct LoadScreen: View {
    @State private var isAnimating: Bool = false
    private var animation: Animation {
        .linear
            .speed(0.1)
            .repeatForever(autoreverses: true)
        }
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.deadSea, .whistlesGold]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            Circle()
                .scaleEffect(isAnimating ? 1.75 : 1.30)
                .foregroundColor(.white.opacity(isAnimating ? 0.25 : 0.1))
                .scaledToFit()
            
            Circle()
                .scaleEffect(isAnimating ? 1.25 : 0.25)
                .foregroundColor(.white.opacity(isAnimating ? 0.75 : 0.1))
                .animation(.spring(duration: 2),value: isAnimating)
            
            VStack {
                Text("Course \n of \n Mental Disease")
                    .font(.custom("Comfortaa-Bold", size: 40))
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                    .opacity(isAnimating ? 1 : 0)
                    .scaleEffect(isAnimating ? 1 : 0.25)
                    .animation(.spring(duration: 2),value: isAnimating)
            }
        }
        .onAppear() {
            withAnimation(animation) {
                isAnimating.toggle()
            }
        }
    }
}

#Preview {
    LoadScreen()
}
