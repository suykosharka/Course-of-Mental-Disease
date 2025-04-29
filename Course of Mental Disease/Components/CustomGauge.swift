//
//  CustomGauge.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 28.03.2025.
//

import SwiftUI

struct CustomGauge: View {
    
    var imageName: String
    var title: String
    var value: Double
    var tintColor: Color
    
    var body: some View {
        Gauge(value: value, in: -3...3) {
            HStack {
                Image(systemName: imageName)
                    .foregroundStyle(.gray)
                Text(title)
                    .frame(width: 125)
                    .modifier(textModifier(roundedCorners: 22, borderColor: .muddyMauve, textColor: .gray))
            }
            .padding(.bottom, 1)
        }
        .tint(tintColor)
        .padding(.vertical, 5)
        .padding(.horizontal, 30)
    }
}

#Preview {
    CustomGauge(imageName: "fork.knife", title: "Энергичность", value: 50, tintColor: .muddyMauve)
}
