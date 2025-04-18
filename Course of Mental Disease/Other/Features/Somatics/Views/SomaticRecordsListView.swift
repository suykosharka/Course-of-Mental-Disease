//
//  RecordsListView.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 02.04.2025.
//

import SwiftUI

struct SomaticRecordsListView: View {
    
    @State var isSample = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                //Background
                Rectangle()
                    .foregroundColor(.sugarMilk)
                    .ignoresSafeArea()
                
                List {
                    ForEach(0..<100) { _ in
                        NavigationLink {
                            CustomPicker(value: "dsfewfa", label: "fsfdsgsg", content: {Text("gsdgdzshg")})
                        } label: {
                            sample()
                        }
                        .modifier(textModifier(roundedCorners: 22, borderColor: .muddyMauve, textColor: .gray))
                    }
                    .listRowBackground(Color.clear)
                }
//                .modifier(textModifier(roundedCorners: 22, borderColor: .muddyMauve, textColor: .gray))
                .listStyle(.plain)
//                .padding()
                
            }
        }
    }
}

#Preview {
    SomaticRecordsListView()
}

struct sample: View {
    var body: some View {
        HStack {
            Text("2025-04-02")
        }
//        .frame(maxWidth: .infinity)
    }
}
