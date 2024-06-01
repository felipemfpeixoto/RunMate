//
//  RoadMapView.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI
import PostHog

struct RoadMapView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var textoSemanas: [String] = ["Primeira", "Segunda", "Terceira"]
    
    @State var semanas: [Semana] = []
    @State var semanaIndex: Int = 0

    @State var isShowingNextSheet: Bool = false
    
    @State var isShowingPrevious: Bool = false
    
    @Binding var telaSelecionada: TelaSelecionada
    
    @State var presentSemanaIndex: Semana?
    
    @State var enterTime: Date?
    
    @Binding var showPro: Bool
    
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
            self.enterTime = Date()
            if dao.isBlocked{
                showPro = true
            }
        }
        .onDisappear {
            if let enterTime = self.enterTime {
                let duration = Date().timeIntervalSince(enterTime)
                PostHogSDK.shared.capture("Screen Exited", properties: [
                    "screen": "RoadMapView",
                    "duration": duration
                ])
            }
        }
        .sheet(isPresented: $showPro, content: {
            RunMateProView()
        })
    }
    
    @ViewBuilder
    func semanaDaVez(for index: Int) -> some View {
        let semana = semanas[index]
        
        ZStack {
                VStack {
                    Image( semana.semana % 2 == 1 ? "impar" : "par")
                        .resizable()
                    Button {
                        if dao.isBlocked{
                            showPro = true
                        }
                        else{
                            self.semanaIndex = index
                            if semanaIndex > dao.semanaAtual {
                                isShowingNextSheet.toggle()
                                PostHogSDK.shared.capture("Viu semana \(index + 1) posterior à atual")
                            } else if semanaIndex == dao.semanaAtual {
                                telaSelecionada = .home
                                PostHogSDK.shared.capture("Navegou para SemanaView a partir do RoadMap")
                            } else {
                                isShowingPrevious.toggle()
                                PostHogSDK.shared.capture("Viu semana \(index + 1) anterior à semana atual")
                            }
                        }
                    } label: {
                        if semana.semana % 2 == 1 {
                                SemanaRoadMap(semana: semana, isLocked: dao.semanaAtual < (semana.semana-1))
                        } else {
                                SemanaRoadMap(semana: semana, isLocked: dao.semanaAtual < (semana.semana-1))
                        }
                    }
                    .padding(.leading, semana.semana == 1  ? -30 : 10)
                    .padding(.top, -47)
                    .sheet(isPresented: $isShowingNextSheet) {
                        PreviewSemanaSeguinte(index: semanaIndex)
                    }
                    .sheet(isPresented: $isShowingPrevious) {
                        ParabénsView(semana: semana, index: index)
                    }
                }
                .padding(.bottom, -25)
            }
    }
}
