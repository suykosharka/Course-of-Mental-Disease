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
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    Image(systemName: "chevron.down")
                }
            }
        } label: {
            Text(label)
                .font(.custom("Comfortaa-Bold", size: 15))
                .foregroundStyle(.gray)
        }
        .padding(.vertical, -10)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .backgroundStyle(.white)
        .modifier(textModifier(roundedCorners: 22, borderColor: .muddyMauve, textColor: .muddyMauve))
        .padding(.horizontal, 15)
        .padding(.vertical, 5)
    }
}

#Preview {
    VStack {
        CustomPicker(value: "sdadуколаршоаиуклоаиуколаилкуоиаокулаилокуаиолкуаиокуиаолкуиаоикулоаикуолаиолкуаиолкиаолукиаоликуоаикуолаикуол", label: "asfaFa", content: {
            Text("dsffs")
        })
        CustomPicker(value: "sdadуколаршоаиуклоаиуколаилкуоиаокулаилокуаиолкуаиокуиаолкуиаоикулоаикуолаиолкуаиолкиаолукиаоликуоаикуолаикуол", label: "asfaFa", content: {
            Text("dsffs")
        })
        CustomPicker(value: "sdadуколаршоаиуклоаиуколаилкуоиаокулаилокуаиолкуаиокуиаолкуиаоикулоаикуолаиолкуаиолкиаолукиаоликуоаикуолаикуол", label: "asfaFa", content: {
            Text("dsffs")
        })
        CustomPicker(value: "sdadуколаршоаиуклоаиуколаилкуоиаокулаилокуаиолкуаиокуиаолкуиаоикулоаикуолаиолкуаиолкиаолукиаоликуоаикуолаикуол", label: "asfaFa", content: {
            Text("dsffs")
        })
        CustomPicker(value: "sdadуколаршоаиуклоаиуколаилкуоиаокулаилокуаиолкуаиокуиаолкуиаоикулоаикуолаиолкуаиолкиаолукиаоликуоаикуолаикуол", label: "asfaFa", content: {
            Text("dsffs")
        })
    }
}
