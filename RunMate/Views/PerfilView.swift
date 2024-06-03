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
    @State private var selectedWeek: String? = nil
    
    @Binding var isEditing: Bool
    
    @Binding var showPro: Bool
    
    @State var enterTime: Date?
    
    var body: some View {
        ZStack{
            Color.blackBlue.ignoresSafeArea()
            VStack(alignment: .leading){
                Spacer()
                header(isEditing: $isEditing, showPro: $showPro)
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
    @Binding var isEditing: Bool
    @Binding var showPro: Bool
    var body: some View {
        HStack(){
            VStack(alignment: .leading){
                Text("Perfil do Corredor")
                    .font(Font.custom("Roboto-Bold", size: 28))
                    .foregroundStyle(Color.white)
                
                Text("\(dao.metaSelecionlada == "5KM" ? String(dao.metaSelecionlada.prefix(1)) : String(dao.metaSelecionlada.prefix(2))) km - \(dao.nivelSelecionado)")
                    .font(Font.custom("Roboto-Regular", size: 24))
                    .foregroundStyle(Color.turquoiseGreen)
                    .padding(.bottom, 5)
                
                
                if !dao.isPurchased{
                    NavigationLink(destination: RunMateProView(isEditing: $isEditing, showPro: $showPro), label: {
                        
                        HStack{
                            Text("RunMate Pro")
                                .font(.custom("Poppins", size: 18))
                            Image(systemName: "figure.run")
                        }
                        .foregroundColor(.turquoiseGreen)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                        .background(Color.lakeBlue)
                        .cornerRadius(11)
                    })
                }
            }
            .padding(.bottom, 15)
            Spacer()
        }
        .padding(.leading)
    }
}

struct progressBar: View {
    var body: some View {
        let total: Int = dao.paginaDeTreinamento.planoDeTreinamento.semanas.count
        let progress: Int = dao.semanaAtual
        let const: Double = Double(340/total)
        let percent = (progress * 100)/total
        ZStack {
            RoundedRectangle(cornerRadius: 100)
                .frame(width: 340, height: 25)
                .foregroundStyle(Color.oceanBlue)
            HStack(spacing: 0) {
                ZStack{
                    RoundedRectangle(cornerRadius: 100)
                        .frame(width: CGFloat(progress) * const, height: 25)
                        .foregroundStyle(Color.lilacPurple)
                    Text("\(percent)%")
                        .font(.custom("Roboto-Regular", size: 15))
                        .foregroundStyle(progress == 0 ? .white : .blackBlue)

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
                ForEach(dao.dadosSemanas.indices, id: \.self) { index in
                    let isSemanaAtual = index == dao.semanaAtual
                    let cal = dao.dadosSemanas[index].calorias
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
        
        let maxDistance = dao.dadosSemanas.map { $0.distância }.max() ?? 0.0
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
                ForEach(dao.dadosSemanas.indices, id: \.self) { index in
                    let dist = dao.dadosSemanas[index].distância
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
        
        let maxSpeed = dao.dadosSemanas.map { $0.velocidadeMédia }.max() ?? 0.0
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
                ForEach(dao.dadosSemanas.indices, id: \.self) { index in
                    let vel = dao.dadosSemanas[index].velocidadeMédia
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


