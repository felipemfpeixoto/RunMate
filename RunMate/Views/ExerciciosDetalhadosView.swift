//
//  ExerciciosDetalhadosView.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

struct ExerciciosDetalhadosView: View {
    
    var exercicios: [Exercicio]
    
    var body: some View {
        VStack {
            if dao.diaAtual == -1 {
                ProgressView()
            } else {
                
                ForEach(exercicios, id: \.self){ ex in
                    let size = ex.exercíciosDetalhados.count
                    ZStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            ForEach(ex.exercíciosDetalhados, id: \.self) { e in
                                let text = e.tempo == nil ? "Km" : "MIN"
                                HStack(spacing: 30){
                                    Text("\(e.tempo == nil ? e.distancia ?? 0 : e.tempo ?? 0) \(text)")
                                        .font(.custom("Poppins-SemiBold", size: 18))
                                        .padding(.leading, 40)
                                    
                                    VStack(alignment: .leading){
                                        Text(e.nome)
                                            .font(.custom("Poppins-SemiBold", size: 15).bold())
                                        Text(e.descricao)
                                            .font(.custom("Poppins-Medium", size: 13))
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
                            .background(dao.diasConcluidos.contains(dao.diaAtual + 1) ?  Color.lilacPurple : Color.turquoiseGreen)
                            .cornerRadius(18)
                    }
                    .background(Color.oceanBlue)
                    .cornerRadius(18)
                }
            }
        }
    }
}
