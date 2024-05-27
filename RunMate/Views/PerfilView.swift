//
//  PerfilView.swift
//  RunMate
//
//  Created by Giovana Nogueira on 17/05/24.
//

import SwiftUI
import Charts
import PostHog


struct PerfilView: View {
    
    @Binding var isEditing: Bool
    
    @State var enterTime: Date?
    
    var body: some View {
        ZStack{
            Color.blackBlue.ignoresSafeArea()
            VStack{
                Spacer()
                header()
                Spacer()
                distanceChart()
                    
                Spacer()
                
                Button(action: {
                    isEditing = true
                    PostHogSDK.shared.capture("Resetou escolha")
                }, label: {
                    Text("Resetar Escolhas")
                })
            }
        }
        .onAppear {
            self.enterTime = Date()
        }
        .onDisappear {
            if let enterTime = self.enterTime {
                let duration = Date().timeIntervalSince(enterTime)
                PostHogSDK.shared.capture("Screen Exited", properties: [
                    "screen": "Perfil",
                    "duration": duration
                ])
            }
        }
    }
}

struct header: View {
    var body: some View {
        HStack(){
            VStack(alignment: .leading){
                Text("Perfil do Corredror")
                    .font(Font.custom("Poppins-SemiBold", size: 24))
                    .foregroundStyle(Color.white)
                Text("Perfil do Corredror")
                    .font(Font.custom("Roboto-Regular", size: 24))
                    .foregroundStyle(Color.turquoiseGreen)
            }
            Spacer()
        }
        .padding(.leading)
    }
}
struct distanceChart: View {
    
    var data: [DadosSemana] = [
        DadosSemana(velocidadeMédia: 5.5, calorias: 150, distância: 5),
        DadosSemana(velocidadeMédia: 9.5, calorias: 200, distância: 3.5),
        DadosSemana(velocidadeMédia: 8.0, calorias: 250, distância: 8)
    ]
    var body: some View {
        Chart {
            ForEach(data.indices, id: \.self) {index in
                BarMark (
                    x: .value("semana", "sem \(index + 1)"  ),
                    y: .value("distancia", data[index].distância)
                )
            }
        }
        .frame(width: 300, height: 300)
        .foregroundColor(.lilacPurple)
        .chartXAxis {
            AxisMarks(preset: .aligned, values: .automatic) { _ in
                // Não adicionar AxisGridLine para remover as linhas de grade do eixo Y
                AxisTick()
                    .foregroundStyle(Color.clear) // Tornar as marcações do eixo X transparentes
                AxisValueLabel()
                    .foregroundStyle(Color.clear) // Tornar os rótulos do eixo X transparentes
            }
        }
        .chartYAxis {
            AxisMarks(preset: .aligned, values: .automatic) { _ in
                
                AxisGridLine()
                    .foregroundStyle(Color.ourLightBlue) // Cor das linhas de grade do eixo Y
                AxisTick()
                    .foregroundStyle(Color.ourLightBlue) // Cor das marcações do eixo Y
                AxisValueLabel()
                    .foregroundStyle(Color.white) // Cor dos rótulos do eixo Y
                
            }
        }
    }
}


