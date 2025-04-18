//
//  EmotionsSection.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 25.12.2023.
//

import SwiftUI

struct EmotionsSection: View {
    
    
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(
                    gradient: .init(colors: [.connecticutLilac, .timelessSeafoam]),
                      startPoint: .leading,
                      endPoint: .bottom
                    ))
                .frame(height: 350)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.alphabetBlue, lineWidth: 3))
        }
        .padding(10)
    }
}

#Preview {
    EmotionsSection()
}
