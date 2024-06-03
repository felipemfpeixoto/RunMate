//
//  PreviewSemanaSeguinte.swift
//  RunMate
//
//  Created by infra on 20/05/24.
//

import SwiftUI
struct PreviewSemanaSeguinte: View {
    
    let index: Int
    var semana: Semana
    let gridItems = [GridItem(.fixed(150)), GridItem(.fixed(200))]
    
    var body: some View {
        ZStack {
            Color(.oceanBlue).ignoresSafeArea()
            VStack {
                Spacer()
                headerPrincipal
                contentView
                Spacer()
            }
            .onChange(of: dao.semanaAtual) { oldValue, newValue in
                print("semana = " + String(newValue))
            }
            .onChange(of: dao.diaAtual) { oldValue, newValue in
                print("dia = " + String(newValue))
            }
        }
    }
    
    var contentView: some View {
        VStack {
            if dao.paginaDeTreinamento.planoDeTreinamento.semanas.count > 0 {
                if dao.paginaDeTreinamento.planoDeTreinamento.semanas[index].dias[dao.diaAtual].exercicios.isEmpty {
                    diaLivre
                } else if (dao.semanaAtual + 1) == dao.paginaDeTreinamento.planoDeTreinamento.semanas.count && dao.diaAtual == 6 {
                    diaProva
                } else {
                    VStack {
                        ExerciciosDetalhadosView(exercicios: dao.paginaDeTreinamento.planoDeTreinamento.semanas[index].dias[dao.diaAtual].exercicios, isLocked: true, isOverview: false)
                        Spacer()
                    }
                    .padding(.vertical, 20)
                }
            }
        }
    }
    
    var minhaMeta: some View {
        VStack(alignment: .leading) {
            Text("\(semana.semana)ª Semana")
                .font(Font.custom("Roboto-Bold", size: 28))
                .foregroundStyle(Color.white)
            
            Text("Bloqueada")
                .font(Font.custom("Roboto-Regular", size: 24))
                .foregroundStyle(Color.ourLightBlue)
                .padding(.bottom, 30)
        }
    }
    
    var headerPrincipal: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                minhaMeta
                Spacer()
                Image("cadeadoTransparente")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
            }
            scrollViewHorizontal
        }
        .padding(.horizontal)
        .padding(.top, 40)
    }
    
    var scrollViewHorizontal: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(semana.dias, id: \.dia) { dia in
                    let isEqual = dia.dia == (dao.diaAtual + 1)
                    let myButtonStyle = diaEstiloButton(isEqual: isEqual)

                    Button(action: {
                        if dia.dia != (dao.diaAtual + 1) {
                            self.updateDiaAtual(dia: dia)
                        }
                    }, label: {
                        diaLabel(dia: dia, isEqual: isEqual)
                    })
                    .buttonStyle(myButtonStyle)
                }
            }
            .padding(.leading, 10)
        }
        .padding(.leading, -10)
    }
    
    var diaLivre: some View {
        VStack {
            Text("DIA LIVRE")
                .font(.custom("Poppins-SemiBold", size: 30))
                .foregroundColor(.lakeBlue)
                .padding(.top, 30)
            Image("Cadeira")
                .resizable()
                .scaledToFit()
                .frame(width: 136, height: 133)
            Text("Tire uma folga do seu \ncronograma de corrida e \naproveite um dia de descanso!")
                .font(.custom("Poppins-SemiBold", size: 18))
                .foregroundColor(.lakeBlue)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
    
    var diaProva: some View {
        VStack {
            ZStack(alignment: .leading) {
                VStack {
                    LazyVGrid(columns: gridItems, alignment: .leading) {
                        Text(dao.metaSelecionlada)
                            .font(.custom("Poppins-SemiBold", size: 18))
                            .padding(.leading, 80)
                        
                        VStack(alignment: .leading) {
                            Text("Corrida Definitiva")
                                .font(.custom("Poppins-SemiBold", size: 15).bold())
                            Text("Distância final da meta")
                                .font(.custom("Poppins-Medium", size: 12))
                        }
                    }
                    .padding(.horizontal, 40)
                    .foregroundColor(.white)
                    .frame(width: 359, height: 65)
                }
                
                Text("1X")
                    .font(.custom("Poppins-Medium", size: 18))
                    .foregroundColor(.oceanBlue)
                    .frame(width: 63, height: 65)
                    .background(dao.diasConcluidos.contains(dao.diaAtual + 1) ?  Color.lilacPurple : Color.turquoiseGreen)
                    .cornerRadius(18)
            }
            .background(Color.oceanBlue)
            .cornerRadius(18)
            Spacer()
        }
        .padding(.vertical, 20)
    }
    
    func updateDiaAtual(dia: Dia) {
        if dia.dia == (dao.diaAtual + 1) {
            dao.diaAtual = dia.dia
        } else {
            dao.diaAtual = (dia.dia - 1)
        }
    }

    func diaLabel(dia: Dia, isEqual: Bool) -> some View {
        VStack {
            Text("\(dia.dia)º")
                .font(Font.custom("Roboto-Bold", size: 30))
            Text("Dia")
                .font(Font.custom("Roboto-Bold", size: 18))
        }
        .foregroundStyle(isEqual ? Color.oceanBlue : Color.white)
    }

    func diaEstiloButton(isEqual: Bool) -> some ButtonStyle {
        if isEqual {
            return AnyButtonStyle(BotaoDiaLightBlue())
        } else {
            return AnyButtonStyle(BotaoDiaLakeBlue())
        }
    }
}

#Preview {
    PreviewSemanaSeguinte(index: 1, semana: Semana(semana: 1, dias: []))
}
