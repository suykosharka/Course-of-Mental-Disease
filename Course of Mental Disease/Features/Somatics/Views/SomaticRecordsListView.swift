//
//  RecordsListView.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 02.04.2025.
//

import SwiftUI

struct SomaticRecordsListView: View {
    
    init() {
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
            .setTitleTextAttributes([.font: UIFont(name: "Comfortaa-Bold", size: 15)!], for: .normal)
    }
    
    @StateObject var viewModel = SomaticRecordsListViewModel()
    @State private var searchText: String = ""
    @State private var prompt: String = "Поиск"
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                //Background
                Rectangle()
                    .foregroundColor(.sugarMilk)
                    .ignoresSafeArea()
                
                if let somatics = viewModel.somatics {
                    List {
                        ForEach(somatics.filter{
                            searchText.isEmpty || $0.date.contains(searchText)
                        }, id: \.self) { item in
                            NavigationLink {
                                let apetite = Rates.Apetite(rawValue: item.apetiteRate)!
                                let sleep = Rates.Sleep(rawValue: item.sleepRate)!
                                let energy = Rates.Energy(rawValue: item.energyRate)!
                                let libido = Rates.Libido(rawValue: item.libidoRate)!
                                SomaticRecordView(apetite: apetite, sleep: sleep, energy: energy, libido: libido)
                            } label: {
                                HStack {
                                    Text(item.date)
                                }
                            }
                            .modifier(textModifier(roundedCorners: 22, borderColor: .muddyMauve, textColor: .gray))
                        }
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                    .toolbarRole(.editor)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            VStack {
                                Text("Записи")
                                    .frame(height: 0)
                                    .modifier(textModifier(roundedCorners: 22, borderColor: .muddyMauve, textColor: .gray))
                            }
                        }
                    }
                    .searchable(text: $searchText, prompt: prompt)
                    .font(.custom("Comfortaa-Bold", size: 15))
                   
                }
                
            }
            .onAppear() {
                Task {
                    await viewModel.fetchSomatics()
                }
            }
        }
        
    }
}

#Preview {
    SomaticRecordsListView()
}
