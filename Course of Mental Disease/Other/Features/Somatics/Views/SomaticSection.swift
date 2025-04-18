//
//  Dosages.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 18.11.2023.
//

import SwiftUI

struct SomaticSection: View {
    
    @StateObject var viewModel = SomaticSectionViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(
                        gradient: .init(colors: [.brilliantBeige, .connecticutLilac]),
                        startPoint: .leading,
                        endPoint: .bottom
                    ))
                    .frame(height: 350)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.muddyMauve , lineWidth: 3))
                
                VStack {
                                        
                    if let apetite = viewModel.apetiteAverage,
                       let sleep = viewModel.sleepAverage,
                       let energy = viewModel.energyAverage,
                       let libido = viewModel.libidoAverage  {
                        
                        //Indicators
                        VStack {
                            CustomGauge(imageName: "fork.knife", title: "Аппетит", value: apetite, tintColor: .white)
                            CustomGauge(imageName: "moon.zzz.fill", title: "Cон", value: sleep, tintColor: .white)
                            CustomGauge(imageName: "bolt.fill", title: "Энергичность", value: energy, tintColor: .white)
                            CustomGauge(imageName: "bed.double.fill", title: "Либидо", value: libido, tintColor: .white)
                        }
                        
                    } else {
                        
                        //Empty view
                        ContentUnavailableView {
                            VStack {
                                Image(systemName: "heart.text.clipboard")
                                    .font(.system(size: 50, weight: .bold))
                                    .foregroundStyle(.pink)
                                    .symbolRenderingMode(.hierarchical)
                                Text("Здесь пока пусто")
                                    .font(.custom("Comfortaa-Bold", size: 20))
                                    .foregroundStyle(.white)
                            }
                                
                        } description: {
                            Text("Но будут отображаться показатели ваших соматических проявлений за последние две недели. Нажмите на окно для перехода.")
                                .font(.custom("Comfortaa-Bold", size: 17))
                                .frame(width: 300)
                                .foregroundStyle(.gray)
                        }
                        .frame(height: 350)
                        
                    }
                }
                
            }
        }
        .padding(10)
        .task {
            await viewModel.getSomaticAvgs()
        }
        
    }
}

#Preview {
    SomaticSection()
}
