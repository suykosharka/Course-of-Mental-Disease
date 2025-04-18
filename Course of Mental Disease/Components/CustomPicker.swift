//
//  CustomRecord.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 31.03.2025.
//

import SwiftUI

struct CustomPicker<Content: View>: View {
    
    var value: String
    var label: String
    @ViewBuilder let content: Content
    
    var body: some View {
        GroupBox {
            Menu {
                content
            }
            label: {
                HStack() {
                    Text(value)
                    Image(systemName: "chevron.down")
                }
            }
        } label: {
            Text(label)
                .font(.custom("Comfortaa-Bold", size: 15))
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity)
        .backgroundStyle(.white)
        .modifier(textModifier(roundedCorners: 22, borderColor: .muddyMauve, textColor: .muddyMauve))
        .padding(.horizontal, 15)
        .padding(.vertical, 5)
    }
}

#Preview {
    CustomPicker(value: "sdad", label: "asfaFa", content: {
        Text("dsffs")
    })
}
