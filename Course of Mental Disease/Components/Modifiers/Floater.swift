//
//  Floater.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 21.04.2025.
//

import Foundation
import SwiftUI
import PopupView

struct Floater: ViewModifier {
    @Binding var isShowing: Bool
    @Binding var message: String?
    var color: Color
    
    func body(content: Content) -> some View {
        content
        .popup(isPresented: $isShowing) {
            if let message = message {
                Text(message)
                    .padding(10)
                    .background(color)
                    .cornerRadius(22)
                    .padding(1)
                    .overlay {
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(color.opacity(0.25), lineWidth: 5)
                    }
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
                    isShowing = false
                    message = nil
                }
        }
    }
}

extension View {
    func floater(isShowing: Binding<Bool>, message: Binding<String?>, color: Color) -> some View {
        self.modifier(Floater(isShowing: isShowing, message: message, color: color))
    }
}

#Preview {
    VStack{
        Text("qwertyuiopasdfghjklzxcvbnm,")
            .modifier(textModifier(roundedCorners: 22, borderColor: .muddyMauve, textColor: .black))
        Spacer()
    }
    .frame(maxWidth:.infinity)
    .background(.sugarMilk)
    .floater(isShowing: .constant(true), message: .constant("Запись с такими данными уже существует!"), color: .pink)
    VStack{
        Text("qwertyuiopasdfghjklzxcvbnm,")
            .modifier(textModifier(roundedCorners: 22, borderColor: .muddyMauve, textColor: .black))
        Spacer()
    }
    .frame(maxWidth:.infinity)
    .background(.sugarMilk)
    .floater(isShowing: .constant(true), message: .constant("Запись сохранена!"), color: .green)
}

