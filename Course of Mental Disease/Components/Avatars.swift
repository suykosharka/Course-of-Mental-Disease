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


struct EditablePFP: View {
    
    var image:UIImage? = UIImage()
    var color: Color
    var diameter: CGFloat
    @Binding var albumShowSheet: Bool
    @Binding var cameraShowSheet: Bool
    @Binding var isPhotoPicker: Bool
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .cornerRadius(diameter)
                .frame(width: diameter, height: diameter)
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(color, lineWidth: 3)
                )
                .onTapGesture {
                    isPhotoPicker = true
                }
                .confirmationDialog("Select your profile Picture", isPresented: $isPhotoPicker) {
                    Button {
                        cameraShowSheet = true
                    } label: {
                        Label("Take a photo", systemImage: "questionmark.circle")
                    }
                    
                    Button {
                        albumShowSheet = true
                    } label: {
                        Label("Select from library", systemImage: "questionmark.circle")
                    }
                }
        } else {
            Image(systemName: "person.circle")
                .resizable()
                .cornerRadius(diameter)
                .frame(width: diameter, height: diameter)
                .background(Color.white)
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .foregroundColor(color.opacity(0.45))
                .overlay(
                    Circle()
                        .stroke(color, lineWidth: 3)
                )
                .onTapGesture {
                    isPhotoPicker = true
                }
                .confirmationDialog("Select your profile Picture", isPresented: $isPhotoPicker) {
                    Button {
                        cameraShowSheet = true
                    } label: {
                        Label("Take a photo", systemImage: "questionmark.circle")
                    }
                    
                    Button {
                        albumShowSheet = true
                    } label: {
                        Label("Select from library", systemImage: "questionmark.circle")
                    }
                }

        }
    }
}
