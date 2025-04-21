//
//  Avatars.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 17.11.2023.
//
import Foundation
import SwiftUI

struct Avatar: View {
    
    var image:UIImage? = UIImage()
    var color: Color
    var diameter: CGFloat
    
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

        }
    }
}


struct EditableAvatar: View {
    
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
