//
//  SomaticRecordView.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 26.04.2025.
//

import SwiftUI

struct SomaticRecordView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: SomaticRecordViewModel
    @State var showingUpdateConfirmationDialog: Bool = false
    @State var showingDeleteConfirmationDialog: Bool = false
    
    var body: some View {
        ZStack {
            
            //Background
            Rectangle()
                .foregroundColor(.sugarMilk)
                .ignoresSafeArea()
            
            VStack {
                
                HStack() {
                    Button {
                        Task {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Text("Назад")
                            .modifier(buttonModifier(borderColor: .muddyMauve, textColor: .white, backgroundColor: .muddyMauve))
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 15)
                    
                    Spacer()
                    
                    Text("Запись за: \(viewModel.record.date.formattedDateString())")
                        .modifier(textModifier(roundedCorners: 22, borderColor: .muddyMauve, textColor: .muddyMauve))
                        .padding(.top, 10)
                        .padding(.horizontal, 15)
                    
                }
                .frame(maxWidth: .infinity)
                
                CustomPicker(value: viewModel.apetite.description, label: "Аппетит",
                             content: {
                    Picker("Аппетит", selection: $viewModel.apetite,
                           content: {
                        ForEach(Rates.Apetite.allCases) { data in
                            Text(data.description).tag(data)
                        }
                    })
                })
                
                CustomPicker(value: viewModel.sleep.description, label: "Сон",
                             content: {
                    Picker("Сон", selection: $viewModel.sleep,
                           content: {
                        ForEach(Rates.Sleep.allCases) { data in
                            Text(data.description).tag(data)
                        }
                    })
                })
                
                CustomPicker(value: viewModel.energy.description, label: "Энергичность",
                             content: {
                    Picker("Энергичность", selection: $viewModel.energy,
                           content: {
                        ForEach(Rates.Energy.allCases) { data in
                            Text(data.description).tag(data)
                        }
                    })
                })
                
                CustomPicker(value: viewModel.libido.description, label: "Либидо",
                             content: {
                    Picker("Либидо", selection: $viewModel.libido,
                           content: {
                        ForEach(Rates.Libido.allCases) { data in
                            Text(data.description).tag(data)
                        }
                    })
                })
                
                Spacer()
                
                HStack(alignment: .center) {
                    
                    Button {
                        Task {
                            showingDeleteConfirmationDialog = true
                        }
                    } label: {
                        Text("Удалить")
                            .modifier(buttonModifier(borderColor: .muddyMauve, textColor: .white, backgroundColor: .muddyMauve))
                    }
                    .padding(.horizontal, 30)
                    
                    Button {
                        showingUpdateConfirmationDialog = true
                    } label: {
                        Text("Сохранить")
                            .modifier(buttonModifier(borderColor: .muddyMauve, textColor: .white, backgroundColor: .muddyMauve))
                    }
                    .padding(.horizontal, 30)
                    
                }
                .padding(.bottom, 10)
            }
        }
        .navigationBarBackButtonHidden(true)
        .alert(Text("Вы действительно хотите внести изменения в эту запись?"),
                isPresented: $showingUpdateConfirmationDialog,
                actions: {
                    Button("Сохранить") {
                        Task {
                            await viewModel.updateSomaticRecord()
                        }
                    }
                    Button("Отменить", role: .cancel) { }
                }
            )
        .alert(Text("Вы действительно хотите удалить эту запись?"),
                isPresented: $showingDeleteConfirmationDialog,
                actions: {
                    Button("Удалить") {
                        Task {
                            await viewModel.deleteSomaticRecord()
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                    Button("Отменить", role: .cancel) { }
                }
            )
    }
}

#Preview {
    SomaticRecordView(viewModel: SomaticRecordViewModel(record: Somatics(profile_id: "bfdbdb", date: "fdbbdfb", apetiteRate: 3, sleepRate: 3, energyRate: 3, libidoRate: 3)))
}
