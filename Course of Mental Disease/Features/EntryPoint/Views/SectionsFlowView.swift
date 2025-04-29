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
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor.sugarMilk

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
    }
    
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
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement: .principal) {
                                    VStack {
                                        Text("Профиль")
                                            .modifier(textModifier(roundedCorners: 22, borderColor: .highPlateau, textColor: .gray))
                                            .padding(.bottom, 5)
                                    }
                                }
                            }
                    } label: {
                        ProfileSection()
                    }
                    
                    NavigationLink {
                        SomaticFlowView()
                            .toolbarRole(.editor)
                            .onAppear{
                                mainColor = Color(.muddyMauve)
                            }
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement: .principal) {
                                    VStack {
                                        Text("Соматические проявления")
                                            .modifier(textModifier(roundedCorners: 22, borderColor: .muddyMauve, textColor: .gray))
                                            .padding(.bottom, 5)
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
