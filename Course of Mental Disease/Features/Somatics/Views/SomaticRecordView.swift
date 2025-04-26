//
//  SomaticRecordView.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 26.04.2025.
//

import SwiftUI

struct SomaticRecordView: View {
    
    @State var apetite: Rates.Apetite
    @State var sleep: Rates.Sleep
    @State var energy: Rates.Energy
    @State var libido: Rates.Libido
    
    var body: some View {
        ZStack {
            
            //Background
            Rectangle()
                .foregroundColor(.sugarMilk)
                .ignoresSafeArea()
            
            VStack {
                CustomPicker(value: apetite.description, label: "Аппетит",
                             content: {
                    Picker("Аппетит", selection: $apetite,
                           content: {
                        ForEach(Rates.Apetite.allCases) { data in
                            Text(data.description).tag(data)
                        }
                    })
                })
                
                CustomPicker(value: sleep.description, label: "Сон",
                             content: {
                    Picker("Сон", selection: $sleep,
                           content: {
                        ForEach(Rates.Sleep.allCases) { data in
                            Text(data.description).tag(data)
                        }
                    })
                })
                
                CustomPicker(value: energy.description, label: "Энергичность",
                             content: {
                    Picker("Энергичность", selection: $energy,
                           content: {
                        ForEach(Rates.Energy.allCases) { data in
                            Text(data.description).tag(data)
                        }
                    })
                })
                
                CustomPicker(value: libido.description, label: "Либидо",
                             content: {
                    Picker("Либидо", selection: $libido,
                           content: {
                        ForEach(Rates.Libido.allCases) { data in
                            Text(data.description).tag(data)
                        }
                    })
                })
            }
        }
    }
}

#Preview {
//    SomaticRecordView()
}
