//
//  SomaticNewRecordView.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 31.03.2025.
//

import SwiftUI

struct SomaticNewRecord: View {
    
    @Binding var presentMe: Bool
    @StateObject var viewModel = SomaticNewRecordViewModel()
    
    var body: some View {
        
        ZStack {
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
                
                Button {
                    viewModel.uploadNewRecord()
                } label: {
                    Text("Сохранить запись")
                        .modifier(buttonModifier(borderColor: .muddyMauve, textColor: .white, backgroundColor: .muddyMauve))
                }
            }
            .alert(Text("Запись с такой датой уже существует"),
                   isPresented: $viewModel.showAlert,
                    actions: {
                        Button("ОК", role: .cancel) { }
                    }, message: {
                        Text("Выберите другую дату или удалите существующую запись.")
                    }
                )
        }
        .tint(.muddyMauve)
        .onChange(of: viewModel.isUploaded) {
            presentMe = false
        }
        
    }
}

#Preview {
    SomaticNewRecord(presentMe: .constant(true))
}
