//
//  CustomTextFields.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 13.11.2023.
//

import Foundation
import SwiftUI

struct textModifier: ViewModifier {
    var roundedCorners: CGFloat
    var borderColor: Color
    var textColor: Color

    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(.white))
            .cornerRadius(roundedCorners)
            .padding(1)
            .foregroundColor(textColor)
            .overlay(
                RoundedRectangle(cornerRadius: roundedCorners)
                    .stroke(Color(borderColor), lineWidth: 3)
            )
            .font(.custom("Comfortaa-Bold", size: 15))
    }
}

#Preview {
    Text("qwertyuiopasdfghjklzxcvbnm,")
        .modifier(textModifier(roundedCorners: 22, borderColor: .muddyMauve, textColor: .black))
}
