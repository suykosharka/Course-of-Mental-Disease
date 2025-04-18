//
//  CustomButtons.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 13.11.2023.
//

import Foundation
import SwiftUI

struct buttonModifier: ViewModifier {
    var borderColor: Color
    var textColor: Color
    var backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(backgroundColor)
            .cornerRadius(.infinity)
            .padding(3)
            .foregroundColor(textColor)
            .overlay(
                Capsule()
                    .stroke(Color(borderColor), lineWidth: 3)
            )
            .font(.custom("Comfortaa-Bold", size: 15))
    }
}
