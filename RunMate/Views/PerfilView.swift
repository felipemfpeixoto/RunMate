//
//  PerfilView.swift
//  RunMate
//
//  Created by Giovana Nogueira on 17/05/24.
//

import SwiftUI
import Charts



var data: [DadosSemana] = [
    DadosSemana(velocidadeMédia: 5.5, calorias: 150, distância: 5),
    DadosSemana(velocidadeMédia: 9.5, calorias: 200, distância: 3.5),
    DadosSemana(velocidadeMédia: 8.0, calorias: 250, distância: 8),
    DadosSemana(velocidadeMédia: 5.5, calorias: 150, distância: 5),
    DadosSemana(velocidadeMédia: 9.5, calorias: 200, distância: 3.5),
    DadosSemana(velocidadeMédia: 8.0, calorias: 250, distância: 10),
    DadosSemana(velocidadeMédia: 5.5, calorias: 150, distância: 5),
    DadosSemana(velocidadeMédia: 9.5, calorias: 200, distância: 3.5),
    DadosSemana(velocidadeMédia: 8.0, calorias: 250, distância: 8)
]

struct PerfilView: View {
    @State private var selectedWeek: String? = nil
    @Binding var isEditing: Bool
    
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
                        .padding(.top, 100)
                    
                    Spacer()
                    
                    Button(action: {
                        isEditing = true
                    }, label: {
                        Text("Resetar Escolhas")
                    })
                    .padding(.top, 30)
                    .padding(.bottom, 10)
                }
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
    
//    @State var scrollPosition: Int = dao.semanaAtual - 3
    
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
//            .chartScrollPosition(initialX: Double(scrollPosition))
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


//#Preview {
//    PerfilView()
//}
