//
//  FloaterModifier.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 21.04.2025.
//

import Foundation
import SwiftUI
import PopupView

struct errorFloater: ViewModifier {
    @Binding var showError: Bool
    @Binding var errorMessage: String?
    
    func body(content: Content) -> some View {
        content
        .popup(isPresented: $showError) {
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .padding()
                    .background(.pink.secondary.opacity(0.5))
                    .cornerRadius(22)
                    .font(.custom("Comfortaa-Bold", size: 15))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
            }
        } customize: {
            $0
                .type(.floater())
                .displayMode(.overlay)
                .useKeyboardSafeArea(true)
                .position(.top)
                .closeOnTapOutside(true)
                .autohideIn(3)
                .dismissCallback {
                    showError = false
                    errorMessage = nil
                }
        }
    }
}
