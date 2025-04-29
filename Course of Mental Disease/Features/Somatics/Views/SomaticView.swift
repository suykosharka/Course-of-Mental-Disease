//
//  SomaticView.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 25.12.2023.
//

import SwiftUI

struct SomaticView: View {
    
    @StateObject var viewModel = SomaticViewViewModel()
    @State var showingPopover: Bool = false
    
    var body: some View {
        
        ZStack {
            
            //Background
            Rectangle()
                .foregroundColor(.sugarMilk)
                .ignoresSafeArea()
            
            VStack {
                
                //Range picker
                Menu {
                    Picker("", selection: $viewModel.range,
                           content: {
                        ForEach(DateRangeType.allCases) { data in
                            Text(data.rawValue).tag(data)
                        }
                    })
    
                }
                label: {
                    HStack() {
                        Text(viewModel.range.rawValue)
                        Image(systemName: "chevron.down")
                    }
                    .font(.custom("Comfortaa-Bold", size: 15))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .padding(.bottom, 10)

                //Custom range datepickers
                if viewModel.range == .customRange {
                    HStack(alignment: .center, spacing: 20) {
                        VStack(alignment: .center, spacing: 10) {
                            //Start date
                            DatePicker(selection: $viewModel.startDate,
                                       in: ...viewModel.endDate,
                                       displayedComponents: .date,
                                       label: {
                                Text("С")
                            }
                            )
                            .frame(height: 15)
                            .modifier(textModifier(roundedCorners: 22, borderColor: .muddyMauve, textColor: .gray))
                            
                            //End date
                            DatePicker(selection: $viewModel.endDate,
                                       in: viewModel.startDate...Date(),
                                    displayedComponents: .date,
                                    label: {
                                        Text("По")
                                    }
                            )
                            .frame(height: 15)
                            .modifier(textModifier(roundedCorners: 22, borderColor: .muddyMauve, textColor: .gray))
                        }
                        .fixedSize()
                        
                        VStack() {
                            
                            //Show button
                            
                            Button {
                                //Update gauges
                                Task {
                                    await viewModel.getSomaticAvgs()
                                }
                            } label: {
                                Text("Показать")
                                    .modifier(buttonModifier(borderColor: .muddyMauve, textColor: .white, backgroundColor: .muddyMauve))
                            }
                            
                        }
                    }
                    .padding()
                    
                }
                
                if viewModel.isLoading {
                    
                    ProgressView()
                        .frame(height: 350)
                    
                }else if let apetite = viewModel.apetiteAverage,
                    let sleep = viewModel.sleepAverage,
                    let energy = viewModel.energyAverage,
                    let libido = viewModel.libidoAverage {
                    
                    //Indicators
                    VStack {
                        CustomGauge(imageName: "fork.knife", title: "Аппетит", value: apetite, tintColor: .muddyMauve)
                        CustomGauge(imageName: "moon.zzz.fill", title: "Cон", value: sleep, tintColor: .muddyMauve)
                        CustomGauge(imageName: "bolt.fill", title: "Энергичность", value: energy, tintColor: .muddyMauve)
                        CustomGauge(imageName: "bed.double.fill", title: "Либидо", value: libido, tintColor: .muddyMauve)
                    }
                    .frame(height: 350)
                    
                } else {
                    
                    //Empty view
                    ContentUnavailableView {
                        VStack {
                            Image(systemName: "heart.text.clipboard")
                                .font(.system(size: 50, weight: .bold))
                                .foregroundStyle(.pink)
                                .symbolRenderingMode(.hierarchical)
                            Text("Нет данных за выбранный период")
                                .font(.custom("Comfortaa-Bold", size: 20))
                                .foregroundStyle(.gray)
                        }
                            
                    } description: {
                        Text("Сделайте новую запись или выберите другой временной период")
                            .font(.custom("Comfortaa-Bold", size: 15))
                            .frame(width: 150)
                            .foregroundStyle(.tertiary)
                    }
                    .frame(height: 350)
                    
                }
            }

        }
        .tint(.muddyMauve)
        .task(id: viewModel.range) {
            await viewModel.getSomaticAvgs()
        }

    }
}

#Preview {
    SomaticView()
}
