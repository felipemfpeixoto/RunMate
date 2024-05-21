//
//  ExerciciosDetalhadosView.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

struct ExerciciosDetalhadosView: View {
    
    var exercicios: [Exercicio]
    
    let gridItems = [GridItem(.fixed(150)), GridItem(.fixed(200))]
    
    let isLocked: Bool
    
    let isOverview: Bool
    
    var body: some View {
        VStack {
            if dao.diaAtual == -1 {
                ProgressView()
            } else {
                ForEach(exercicios, id: \.self){ ex in
                    let size = ex.exercíciosDetalhados.count
                    ZStack(alignment: .leading) {
                        VStack {
                            ForEach(ex.exercíciosDetalhados, id: \.self) { e in
                                let text = e.tempo == nil ? "km" : "min"
                                
                                var descricao: String {
                                    if e.nome == "Caminhada"{
                                      return dao.fcmDescricao.caminhada
                                   }
                                   else if e.nome == "Corrida Leve"{
                                       return dao.fcmDescricao.leve
                                   }
                                   else if e.nome == "Corrida Moderada"{
                                       return dao.fcmDescricao.moderada
                                   }
                                   else if e.nome == "Corrida Forte"{
                                       return dao.fcmDescricao.forte
                                   }
                                   else if e.nome == "Corrida Muito Forte"{
                                       return dao.fcmDescricao.muitoForte
                                   }
                                   else{
                                       return e.descricao
                                   }
                                }

                                LazyVGrid(columns: gridItems, alignment: .leading) {
                                        Text("\(e.tempo == nil ? e.distancia ?? 0 : e.tempo ?? 0) \(text)")
                                            .font(.custom("Poppins-SemiBold", size: 18))
                                            .padding(.leading, 80)
                                        
                                        VStack(alignment: .leading){
                                            Text(e.nome)
                                                .font(.custom("Poppins-SemiBold", size: 15).bold())
                                            Text(descricao)
                                                .font(.custom("Poppins-Medium", size: 12))
                                        }
                                }
                                .padding(.horizontal, 40)
                                .foregroundColor(.white)
                                .frame(width: 359, height: 65)
                            }
                        }
                        Text("\(ex.repeticoes)X")
                            .font(.custom("Poppins-Medium", size: 18))
                            .foregroundColor(.oceanBlue)
                            .frame(width: 63, height: size > 1 ? CGFloat((size * 70)) : 65) // Ajeitar o height de acordo com a quantidade de exercícios
                            .background(dao.diasConcluidos.contains(dao.diaAtual + 1) || isOverview ?  Color.lilacPurple : (isLocked ? Color.ourLightBlue : Color.turquoiseGreen))
                            .cornerRadius(18)
                    }
                    .background(isLocked ? Color.lakeBlue : Color.oceanBlue)
                    .cornerRadius(18)
                }
            }
        }
    }
}
