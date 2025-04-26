//
//  SomaticNewRecordView.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 31.03.2025.
//

import SwiftUI

struct SomaticNewRecord: View {
    
    @StateObject var viewModel = SomaticNewRecordViewModel()
    @State private var showError = false
    @State private var showSuccess = false
    
    var body: some View {
        
        ZStack {
            
            //Background
            Rectangle()
                .foregroundColor(.sugarMilk)
                .ignoresSafeArea()
            
            VStack {
                
                DatePicker(selection: $viewModel.date,
                           in: ...Date(),
                        displayedComponents: .date,
                        label: {
                            Text("Дата")
                        }
                )
                .frame(width: 200, height: 0)
                .modifier(textModifier(roundedCorners: 22, borderColor: .muddyMauve, textColor: .gray))
                
                Spacer()
                
                CustomPicker(value: viewModel.apetiteValue.description, label: "Аппетит",
                             content: {
                    Picker("Аппетит", selection: $viewModel.apetiteValue,
                           content: {
                        ForEach(Rates.Apetite.allCases) { data in
                            Text(data.description).tag(data)
                        }
                    })
                })
                
                CustomPicker(value: viewModel.sleepValue.description, label: "Сон",
                             content: {
                    Picker("Сон", selection: $viewModel.sleepValue,
                           content: {
                        ForEach(Rates.Sleep.allCases) { data in
                            Text(data.description).tag(data)
                        }
                    })
                })
                
                CustomPicker(value: viewModel.energyValue.description, label: "Энергичность",
                             content: {
                    Picker("Энергичность", selection: $viewModel.energyValue,
                           content: {
                        ForEach(Rates.Energy.allCases) { data in
                            Text(data.description).tag(data)
                        }
                    })
                })
                
                CustomPicker(value: viewModel.libidoValue.description, label: "Либидо",
                             content: {
                    Picker("Либидо", selection: $viewModel.libidoValue,
                           content: {
                        ForEach(Rates.Libido.allCases) { data in
                            Text(data.description).tag(data)
                        }
                    })
                })
                
                Spacer()
                
                Button {
                    Task {
                        await viewModel.uploadNewRecord()
                    }
                } label: {
                    Text("Сохранить запись")
                        .modifier(buttonModifier(borderColor: .muddyMauve, textColor: .white, backgroundColor: .muddyMauve))
                }
            }
        }
        .tint(.muddyMauve)
        .onReceive(viewModel.$successMessage.compactMap { $0 }) { _ in
            showSuccess = true
        }
        .onReceive(viewModel.$errorMessage.compactMap { $0 }) { _ in
            showError = true
        }
        .floater(isShowing: $showError, message: $viewModel.errorMessage, color: .pink)
        .floater(isShowing: $showSuccess, message: $viewModel.successMessage , color: .green)
        
    }
}

#Preview {
    SomaticNewRecord()
}
