//
//  AvisoConfirmacaoEtapa.swift
//  RunMate
//
//  Created by Giovana Nogueira on 10/05/24.
//

import SwiftUI

struct AvisoConfirmacaoEtapa: View {
    
    @Binding var apareceAtencao: Bool
    
    @Binding var apareceParabensMeta: Bool
    
    @Binding var apareceParabens: Bool
    
    @Binding var isEditing: Bool
    
    @Binding var isShowingExAndamento: Bool
    
    @Binding var isSHowingSelf: Bool
    
    @Binding var calDiaria: Double
    @Binding var distDiaria: Double
    @Binding var velDiaria: Double
    
    @Binding var locationManager: LocationManager
    @Binding var stopWatchManager: StopWatchManager
    
    let tempoMinutos: Int
   
//    var calSemanal: Double = dao.dadosSemanas[dao.semanaAtual].calorias
//    var distSemanal: Double = dao.dadosSemanas[dao.semanaAtual].distância
//    var velSemanal: Double = dao.dadosSemanas[dao.semanaAtual].velocidadeMédia
    
    var body: some View {
            ZStack {
                Color.blackBlue
                    .ignoresSafeArea()
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.oceanBlue)
                    .stroke(Color.turquoiseGreen, lineWidth: 0)
                    .frame(maxWidth: .infinity)
                    .frame(height: 280)
                    .padding(35)
                
                VStack{
                    
                    Text("ATENÇÃO")
                        .font(Font.custom("Poppins-SemiBold", size: 22))
                        .foregroundStyle(Color.turquoiseGreen)
                        .padding(.bottom, 8)
                    
                    Text("Tem certeza que deseja finalizar esta corrida?")
                        .font(Font.custom("Poppins-SemiBold", size: 18))
                        .foregroundStyle(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 50)
                        .padding(.bottom, 10)
                
                        
                        Button(action: {apareceAtencao = false}, label: {
                            Text("CANCELAR")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .font(Font.custom("Poppins-SemiBold", size: 18))
                                .padding(.vertical, 16)
                                .background(Color.lakeBlue)
                            
                        })
                        .cornerRadius(18)
                        .padding(.bottom, 2)
                        .padding(.horizontal, 60)
                        
                        Button(action: {
                            // Para de pegar as locations e zera o cronômetro
                            locationManager.stopCollectingLocations(timeInMinutes: Double(tempoMinutos))
                            stopWatchManager.stop()
                            
                            dao.dadosSemanas[dao.semanaAtual].calorias = calDiaria/Double(dao.diaAtual + 1)
                            dao.dadosSemanas[dao.semanaAtual].distância = distDiaria/Double(dao.diaAtual + 1)
                            dao.dadosSemanas[dao.semanaAtual].velocidadeMédia = velDiaria/Double(dao.diaAtual + 1)
                            withAnimation(Animation.spring(duration: 0.75)) {
                                isSHowingSelf.toggle()
                                isShowingExAndamento.toggle()
                            }
                            if dao.diasConcluidos.count == 6   {
                                if (dao.semanaAtual + 1) == dao.paginaDeTreinamento.planoDeTreinamento.semanas.count {
                                    dao.semanaAtual = 0
                                    apareceParabensMeta = true
                                } else {
                                    dao.diaAtual = 0
                                    dao.diasConcluidos = []
                                    dao.semanaAtual += 1
                                    withAnimation(Animation.bouncy(duration: 0.75)) {
                                        apareceParabens = true
                                    }
                                }
                            } else {
                                dao.diasConcluidos.append(dao.diaAtual+1)
                                dao.diaAtual += 1
                            }
                        }, label: {
                            Text("FINALIZAR")
                                .foregroundColor(.oceanBlue)
                                .frame(maxWidth: .infinity)
                                .font(Font.custom("Poppins-SemiBold", size: 18))
                                .padding(.vertical, 16)
                                .background(Color.turquoiseGreen)
                        })
                        .cornerRadius(18)
                        .padding(.bottom, 2)
                        .padding(.horizontal, 60)
                    
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


