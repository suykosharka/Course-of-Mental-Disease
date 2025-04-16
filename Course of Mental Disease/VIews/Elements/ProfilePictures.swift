//
//  ProfilePictures.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 17.11.2023.
//
import Foundation
import SwiftUI

struct DefaultSignUpPFP: View {
    
    var body: some View {
        Image(systemName: "person.circle")
            .resizable()
            .cornerRadius(100)
            .frame(width: 150, height: 150)
            .background(Color.white)
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
            .foregroundColor(.odeToGreen.opacity(0.45))
            .overlay(
                Circle()
                    .stroke(.odeToGreen, lineWidth: 3)
            )
    }
}

struct SignUpPFP: View {
    var image = UIImage()
    
    var body: some View {
        Image(uiImage: self.image)
            .resizable()
            .cornerRadius(100)
            .frame(width: 150, height: 150)
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(.odeToGreen, lineWidth: 3)
            )
    }
}
    

struct DefaultPFP: View {
    var body: some View {
        Image(systemName: "person.circle")
            .resizable()
            .scaledToFit()
            .background(Color.white)
            .cornerRadius(125)
            .frame(width: 125)
            .foregroundColor(.gray.opacity(0.25))
            .overlay(
                Circle()
                    .stroke(.highPlateau, lineWidth: 3))
    }
}

struct PFP: View {
    var image = UIImage()
    
    var body: some View {
        Image(uiImage: self.image)
            .resizable()
            .cornerRadius(125)
            .frame(width: 125, height: 125)
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(.highPlateau, lineWidth: 3))
    }
}
