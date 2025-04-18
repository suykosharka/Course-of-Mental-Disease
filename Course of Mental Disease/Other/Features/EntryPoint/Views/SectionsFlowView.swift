//
//  SectionsFlowView.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 12.11.2023.
//

import SwiftUI
import SwiftData

struct SectionsFlowView: View {
    
    @State var mainColor: Color?
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                //Background
                Rectangle()
                    .foregroundColor(.sugarMilk)
                    .ignoresSafeArea()
                
                //Sections and Navigation
                ScrollView() {
                    NavigationLink {
                        ProfileView()
                            .toolbarRole(.editor)
                            .onAppear{
                                mainColor = Color(.highPlateau)
                            }
                    } label: {
                        ProfileSection()
                    }
                    
                    NavigationLink {
                        SomaticView()
                            .toolbarRole(.editor)
                            .onAppear{
                                mainColor = Color(.muddyMauve)
                            }
                            .navigationBarTitleDisplayMode(.inline)
                                    .toolbar {
                                        ToolbarItem(placement: .principal) {
                                            VStack {
                                                Text("Соматические проявления")
                                                    .frame(height: 0)
                                                    .modifier(textModifier(roundedCorners: 22, borderColor: .muddyMauve, textColor: .gray))
                                            }
                                        }
                                    }
                    } label: {
                        SomaticSection()
                    }
                    
                    NavigationLink {
                        EmotionsView()
                            .toolbarRole(.editor)
                            .onAppear{
                                mainColor = Color(.alphabetBlue)
                            }
                    } label: {
                        EmotionsSection()
                    }
                }
            }
        }
        .tint(mainColor)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    SectionsFlowView()
}
