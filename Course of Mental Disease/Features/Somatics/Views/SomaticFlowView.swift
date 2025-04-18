//
//  SomaticFlowView.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 15.04.2025.
//

import SwiftUI

struct SomaticFlowView: View {
    @available(iOS 17.0, *)
    var body: some View {
            TabView {
                
                SomaticNewRecord(presentMe: .constant(true))
                    .tabItem {
                                        Label("Menu", systemImage: "plus")
                                    }
                
                SomaticView()
                    .tabItem {
                        Text("Menu")
                            .modifier(textModifier(roundedCorners: 22, borderColor: .muddyMauve, textColor: .gray))
                                    }
                
                SomaticRecordsListView()
                    .tabItem {
                                        Label("Menu", systemImage: "list.dash")
                            .tint(Color.red)
                                    }
                    

        }
            .background(.clear)
            .tint(.muddyMauve)
            .foregroundStyle(.red)
    }
}

#Preview {
    SomaticFlowView()
}
