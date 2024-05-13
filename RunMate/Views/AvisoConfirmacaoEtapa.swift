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
    
    var body: some View {
        ZStack {
            Color.blackBlue
                .opacity(0.2)
                .ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.oceanBlue)
                .stroke(Color.turquoiseGreen, lineWidth: 4)
                .frame(maxWidth: .infinity)
                .frame(height: 230)
                .padding(25)
            
            VStack(spacing: 20) {
                
                Text("ATENÇÃO")
                    .font(Font.custom("Poppins-SemiBold", size: 22))
                    .foregroundStyle(Color.turquoiseGreen)
                
                Text("Tem certeza que deseja concluir essa etapa?")
                    .font(Font.custom("Poppins-SemiBold", size: 18))
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                
                Text("Essa ação não poderá ser desfeita")
                    .font(Font.custom("Poppins-SemiBold", size: 16))
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30)
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 30)
            .cornerRadius(25)
            VStack{
                
                VStack{
                    
                }.frame(height: 220)
                
                HStack{
                    
                    Button(action: {apareceAtencao = false}, label: {
                        Text("CANCELAR")
                            .foregroundColor(.turquoiseGreen)
                            .font(Font.custom("Poppins-SemiBold", size: 18))
                            .padding(.vertical, 16)
                            .padding(.horizontal, 20)
                            .background(Color.lakeBlue)
                    })
                    .cornerRadius(18)
                    
                    
                    Button(action: {
                        withAnimation(Animation.spring(duration: 0.75)) {
                            apareceAtencao = false
                        }
                        
                        if dao.diasConcluidos.count == 6   {
                            if (dao.semanaAtual + 1) == dao.paginaDeTreinamento.planoDeTreinamento.semanas.count {
                                dao.semanaAtual = 0
                                apareceParabensMeta = true
                                print("semana atual depois: \(dao.semanaAtual)")
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
                        Text("CONCLUIR")
                            .foregroundColor(.oceanBlue)
                            .font(Font.custom("Poppins-SemiBold", size: 18))
                            .padding(.vertical, 16)
                            .padding(.horizontal, 20)
                            .background(Color.turquoiseGreen)
                    })
                    .cornerRadius(18)
                }
            }
        
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

//#Preview {
//    AvisoConfirmacaoEtapa(apareceAtencao: .constant(true), apareceParabensMeta: .constant(false))
//}
