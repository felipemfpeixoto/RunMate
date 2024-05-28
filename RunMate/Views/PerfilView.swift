//
//  PerfilView.swift
//  RunMate
//
//  Created by Giovana Nogueira on 17/05/24.
//

import SwiftUI
import Charts
import PostHog


var data: [DadosSemana] = [
    DadosSemana(velocidadeMédia: 5.5, calorias: 150, distância: 5, paceMedio: 8.3),
    DadosSemana(velocidadeMédia: 9.5, calorias: 200, distância: 3.5, paceMedio: 9),
    DadosSemana(velocidadeMédia: 8.0, calorias: 250, distância: 8, paceMedio: 6.7),
    DadosSemana(velocidadeMédia: 5.5, calorias: 150, distância: 5, paceMedio: 7.3),
    DadosSemana(velocidadeMédia: 9.5, calorias: 200, distância: 3.5, paceMedio: 7),
    DadosSemana(velocidadeMédia: 8.0, calorias: 250, distância: 10, paceMedio: 6.9),
    DadosSemana(velocidadeMédia: 5.5, calorias: 150, distância: 5, paceMedio: 8),
    DadosSemana(velocidadeMédia: 9.5, calorias: 200, distância: 3.5, paceMedio: 6),
    DadosSemana(velocidadeMédia: 8.0, calorias: 250, distância: 8, paceMedio: 5.9)
]

struct PerfilView: View {
    @State private var selectedWeek: String? = nil
    @Binding var isEditing: Bool
    
    @State var enterTime: Date?
    
    var body: some View {
        ZStack{
            Color.blackBlue.ignoresSafeArea()
            VStack(alignment: .leading){
                Spacer()
                header()
                    .padding(.top, 20)
                progressBar()
                    .padding(.bottom, 25)
                Spacer()
                ScrollView{
                    distanceChart()
                    Spacer()
                    caloriesChart()
                        .padding(.top, 60)
                    Spacer()
                    speedChart()
                        .padding(.top, 60)
                    Spacer()
                    
                    Button(action: {
                        isEditing = true
                        PostHogSDK.shared.capture("Resetou escolha")
                    }, label: {
                        Text("Resetar Escolhas")
                    })
                    .padding(.top, 30)
                    .padding(.bottom, 10)
                }
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
                Text("Perfil do Corredor")
                    .font(Font.custom("Roboto-Bold", size: 28))
                    .foregroundStyle(Color.white)
                
                Text("\(dao.metaSelecionlada == "5KM" ? String(dao.metaSelecionlada.prefix(1)) : String(dao.metaSelecionlada.prefix(2))) km - \(dao.nivelSelecionado)")
                    .font(Font.custom("Roboto-Regular", size: 24))
                    .foregroundStyle(Color.turquoiseGreen)
                    .padding(.bottom, 15)
            }
            Spacer()
        }
        .padding(.leading)
    }
}

struct progressBar: View {
    var body: some View {
        var total: Int = dao.paginaDeTreinamento.planoDeTreinamento.semanas.count
        var progress: Int = dao.semanaAtual
        var const: Double = Double(340/total)
        var percent = (progress * 100)/total
        ZStack {
            RoundedRectangle(cornerRadius: 100)
                .frame(width: 340, height: 19)
                .foregroundStyle(Color.oceanBlue)
            HStack(spacing: 0) {
                ZStack{
                    RoundedRectangle(cornerRadius: 100)
                        .frame(width: CGFloat(progress) * const, height: 19)
                        .foregroundStyle(Color.lilacPurple)
                    Text("\(percent)%")
                        .font(.custom("Roboto-Regular", size: 15))
                        .foregroundStyle(.blackBlue)

                }
                Spacer()
            }
        }
        .frame(width: 340)
        .padding(.leading)
    }
}

struct caloriesChart: View {
    
    let weeksWindowChart = 4
    
    var body: some View {
        VStack (alignment:.leading){
            HStack{
                Text("Calorias gastas")
                    .font(.custom("Roboto-Bold", size: 20))
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding(.bottom, 30)
            
            Chart {
                ForEach(data.indices, id: \.self) { index in
                    let isSemanaAtual = index == dao.semanaAtual
                    let cal = data[index].calorias
                    BarMark(
                        x: .value("Semana", "SEM \(index + 1)"),
                        y: .value("Calorias", cal)
                    )
                    .foregroundStyle(isSemanaAtual ? Color.turquoiseGreen : Color.lilacPurple)
                    .cornerRadius(5)
                    .annotation(position: .automatic, alignment: .center){
                        Text("\(Int(cal))")
                            .font(Font.custom("Roboto-Regular", size: 15))
                            .foregroundStyle(Color.white)
                    }
                }
            }
            .frame(height: 250)
            .chartScrollableAxes(.horizontal)
            .chartXVisibleDomain(length: weeksWindowChart)
            .chartXAxis {
                AxisMarks(preset: .aligned, values: .automatic) { _ in
                    AxisValueLabel()
                        .foregroundStyle(Color.white)
                }
            }
            .chartYAxis{
                AxisMarks(preset: .aligned, values: .automatic) { _ in
                    AxisGridLine()
                        .foregroundStyle(Color.ourLightBlue)
                    AxisValueLabel()
                        .offset(x:0)
                        .foregroundStyle(Color.white)
                        
                }
            }
            
        }
        .padding(.horizontal, 20)
    }
}

struct distanceChart: View {
    
    let weeksXWindowChart = 4
    let yBuffer = 1.0
    
    var body: some View {
        
        let maxDistance = data.map { $0.distância }.max() ?? 0.0
        let yMax = maxDistance + yBuffer

        VStack (alignment:.leading){
            HStack{
                Text("Quilômetros percorridos")
                    .font(.custom("Roboto-Bold", size: 20))
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding(.bottom, 30)
            
            Chart {
                ForEach(data.indices, id: \.self) { index in
                    let dist = data[index].distância
                    LineMark(
                        x: .value("Semana", "SEM \(index + 1)"),
                        y: .value("Distancia", dist)
                    )
                    .foregroundStyle(Color.lilacPurple)
                    .cornerRadius(5)
                    .lineStyle(.init(lineWidth: 3))
                    .symbol{
                        Circle()
                            .fill(Color.lilacPurple)
                            .frame(width: 5, height: 5)
                            .overlay {
                                Text(String(format: "%.1f", dist))
                                    .frame(width: 40)
                                    .font(Font.custom("Roboto-Regular", size: 15))
                                    .foregroundStyle(Color.white)
                                    .offset(y: -15)
                                    
                            }
                    }
                }
            }
            .frame(height: 250)
            .chartScrollableAxes(.horizontal)
            .chartXVisibleDomain(length: weeksXWindowChart)
            .chartYScale(domain: 0...yMax)
            .chartXAxis {
                AxisMarks(preset: .aligned, values: .automatic) { _ in
                    AxisValueLabel()
                        .foregroundStyle(Color.white)
                }
            }
            .chartYAxis{
                AxisMarks(preset: .aligned, values: .automatic) { _ in
                    AxisGridLine()
                        .foregroundStyle(Color.ourLightBlue)
                    AxisValueLabel()
                        .foregroundStyle(Color.white)
                        
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

struct speedChart: View {
    
    let weeksXWindowChart = 4
    let yBuffer = 1.0
    
    var body: some View {
        
        let maxSpeed = data.map { $0.velocidadeMédia }.max() ?? 0.0
        let yMax = maxSpeed + yBuffer

        VStack (alignment:.leading){
            HStack{
                Text("Velocidade média")
                    .font(.custom("Roboto-Bold", size: 20))
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding(.bottom, 30)
            
            Chart {
                ForEach(data.indices, id: \.self) { index in
                    let vel = data[index].velocidadeMédia
                    LineMark(
                        x: .value("Semana", "SEM \(index + 1)"),
                        y: .value("Velocidade", vel)
                    )
                    .foregroundStyle(Color.turquoiseGreen)
                    .cornerRadius(5)
                    .lineStyle(.init(lineWidth: 3))
                    .symbol{
                        Circle()
                            .fill(Color.turquoiseGreen)
                            .frame(width: 5, height: 5)
                            .overlay {
                                Text(String(format: "%.1f", vel))
                                    .frame(width: 40)
                                    .font(Font.custom("Roboto-Regular", size: 15))
                                    .foregroundStyle(Color.white)
                                    .offset(y: -15)
                                    
                            }
                    }
                }
            }
            .frame(height: 250)
            .chartScrollableAxes(.horizontal)
            .chartXVisibleDomain(length: weeksXWindowChart)
            .chartYScale(domain: 0...yMax)
            .chartXAxis {
                AxisMarks(preset: .aligned, values: .automatic) { _ in
                    AxisValueLabel()
                        .foregroundStyle(Color.white)
                }
            }
            .chartYAxis{
                AxisMarks(preset: .aligned, values: .automatic) { _ in
                    AxisGridLine()
                        .foregroundStyle(Color.ourLightBlue)
                    AxisValueLabel()
                        .foregroundStyle(Color.white)
                        
                }
            }
        }
        .padding(.horizontal, 20)
    }
}


