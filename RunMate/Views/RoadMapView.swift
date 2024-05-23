//
//  RoadMapView.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

struct RoadMapView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var textoSemanas: [String] = ["Primeira", "Segunda", "Terceira"]
    
    @State var semanas: [Semana] = []
    @State var semanaIndex: Int = 0

    @State var isShowingNextSheet: Bool = false
    
    @State var isShowingPrevious: Bool = false
    
    @Binding var telaSelecionada: TelaSelecionada
    
    @State var presentSemanaIndex: Semana?
    
    var body: some View {
        VStack {
            HStack {
                Text("Minha meta")
                    .font(Font.custom("Roboto-Bold", size: 28))
                    .foregroundStyle(Color.white)
                Spacer()
            }
            .padding(.leading, 30)
            
            HStack {
                Text("\(dao.metaSelecionlada == "5KM" ? String(dao.metaSelecionlada.prefix(1)) : String(dao.metaSelecionlada.prefix(2))) km - \(dao.nivelSelecionado)")
                    .foregroundStyle(.turquoiseGreen)
                    .font(Font.custom("Roboto-Regular", size: 24))
                Spacer()
            }
            .padding(.leading, 30)
            
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        ForEach(Array(semanas.enumerated()) , id: \.offset) {index, semana in
                            semanaDaVez(for: index)
                        }
                        Image("impar")
                            .resizable()
                    }
                }
            }
        }
        .background(.blackBlue)
        .navigationBarBackButtonHidden()
        .onAppear {
            semanas = dao.paginaDeTreinamento.planoDeTreinamento.semanas
        }
    }
    
    @ViewBuilder
    func semanaDaVez(for index: Int) -> some View {
        let semana = semanas[index]
        
        ZStack {
                    VStack {
                        Image( semana.semana % 2 == 1 ? "impar" : "par")
                            .resizable()
                        Button {
//                            self.semanaIndex = index
                            self.presentSemanaIndex = semana
                            if semanaIndex > dao.semanaAtual {
//                                isShowingNextSheet.toggle()
                            } else if semanaIndex == dao.semanaAtual {
                                telaSelecionada = .home
                            } else {
                                isShowingPrevious.toggle()
                            }
                        } label: {
                            SemanaRoadMap(semana: semana, isLocked: dao.semanaAtual < (semana.semana-1))
                        }
                        .padding(.leading, semana.semana % 2 == 1  ? -30 : 15)
                        .padding(.top, -47)
//                        .sheet(isPresented: $isShowingNextSheet) {
//                            PreviewSemanaSeguinte(index: semanaIndex)
//                        }
                        .sheet(item: $presentSemanaIndex, content: { semana in
                            PreviewSemanaSeguinte(index: semana.semana)
                        })
                        .sheet(isPresented: $isShowingPrevious) {
                            ParabénsView(semana: semana, index: index)
                        }
                    }
                    .padding(.bottom, -25)
                }
    }
}
