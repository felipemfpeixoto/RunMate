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
                    
                    ForEach(ex.exercíciosDetalhados, id: \.self) { e in
                        
                        let text = e.tempo == nil ? "Km" : "MIN"
                        
                        ZStack(alignment: .leading){
                            
                            
                            HStack(spacing: 40){
                                Text("\(e.tempo == nil ? e.distancia ?? 0 : e.tempo ?? 0) \(text)")
                                    .font(.custom("Poppins-SemiBold", size: 18))
                                    .padding(.leading, 40)
                                
                                VStack(alignment: .leading){
                                    Text(e.nome)
                                        .font(.custom("Poppins-SemiBold", size: 18))
                                    Text(e.descricao)
                                        .font(.custom("Poppins-Medium", size: 14))
                                }
                            }
                            .padding(.horizontal, 40)
                            .foregroundColor(.white)
                            .frame(width: 359, height: 65)
                            .background(Color.oceanBlue)
                            .cornerRadius(18)
                            
                            Text("\(ex.repeticoes)X")
                                .font(.custom("Poppins-Medium", size: 18))
                                .foregroundColor(.oceanBlue)
                                .frame(width: 63, height: 65)
                                .background(Color.turquoiseGreen)
                                .cornerRadius(18)
                            
                            
                        }
                    }
                }
            }
        }
        .onAppear {
            print(dao.diaAtual)
//            exercicios = dao.paginaDeTreinamento.planoDeTreinamento.semanas[dao.semanaAtual].dias[dao.diaAtual].exercicios
//            print(exercicios ?? "tem nada nao")
//            print("---------------------------")
//            print(exercicios![0].exercíciosDetalhados[0] ?? "se fudeu")
        }
    }
}

//#Preview {
//    ExerciciosDetalhadosView() 
//}
