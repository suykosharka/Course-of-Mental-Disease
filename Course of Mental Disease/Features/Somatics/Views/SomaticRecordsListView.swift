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
                if viewModel.isRecordsLoading {
                    ProgressView()
                } else if let somatics = viewModel.somatics {
                    List {
                        ForEach(somatics.filter{
                            searchText.isEmpty || $0.date.contains(searchText)
                        }, id: \.self) { record in
                            NavigationLink {
                                SomaticRecordView(viewModel: SomaticRecordViewModel(record: record))
                            } label: {
                                HStack {
                                    Text("Запись за: \(record.date.formattedDateString())")
                                        .padding(5)
                                }
                            }
                            .modifier(textModifier(roundedCorners: 22, borderColor: .muddyMauve, textColor: .gray))
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                   
                }
                
            }
            .onAppear() {
                Task {
                    await viewModel.fetchSomatics()
                }
            }
            .toolbarRole(.editor)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Записи")
                            .padding(-2)
                            .modifier(textModifier(roundedCorners: 22, borderColor: .muddyMauve, textColor: .gray))
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: prompt)
        .font(.custom("Comfortaa-Bold", size: 15))
        
    }
}

#Preview {
    SomaticRecordsListView()
}
