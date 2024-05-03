//
//  ExerciciosDetalhadosView.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

struct ExerciciosDetalhadosView: View {
    
    var exD1: ExercicioDetalhado
    var exD2: ExercicioDetalhado
    var exD3: [ExercicioDetalhado]
        
    var ex1: Exercicio
    var ex2: Exercicio
    var ex3: Exercicio
    
    var exercicios: [Exercicio]
        
        init() {
            exD1 = ExercicioDetalhado(nome: "Corrida Leve", descricao: "FCM 65% a 75%", tempo: 30, distancia: 4)
            exD2 = ExercicioDetalhado(nome: "Corrida Forte", descricao: "FCM 65% a 75%", tempo: 5, distancia: 4)
            exD3 = [ExercicioDetalhado(nome: "Caminhada", descricao: "FCM 65% a 75%", tempo: 15, distancia: 4), ExercicioDetalhado(nome: "Corrida Leve", descricao: "FCM 65% a 75%", tempo: 30, distancia: 4)]
            
            ex1 = Exercicio(exercíciosDetalhados: [exD1], repeticoes: 1)
            ex2 = Exercicio(exercíciosDetalhados: [exD2], repeticoes: 3)
            ex3 = Exercicio(exercíciosDetalhados: exD3, repeticoes: 1)
            
            exercicios = [ex1, ex2, ex3]
        }
    
    
    
    var body: some View {
        
        ForEach(exercicios, id: \.self){ ex in
            
            ZStack(alignment: .leading){
                
                
                HStack(spacing: 40){
                    Text("10 MIN")
                        .font(.custom("Poppins-SemiBold", size: 18))
                        .padding(.leading, 40)
                    
                    VStack(alignment: .leading){
                        Text("Corrida Leve")
                            .font(.custom("Poppins-SemiBold", size: 18))
                        Text("FCM de 65% a 75%")
                            .font(.custom("Poppins-Medium", size: 14))
                    }
                }
                .padding(.horizontal, 40)
                .foregroundColor(.white)
                .frame(width: 359, height: 65)
                .background(Color.oceanBlue)
                .cornerRadius(18)
                
                Text("1X")
                    .font(.custom("Poppins-Medium", size: 18))
                    .foregroundColor(.oceanBlue)
                    .frame(width: 63, height: 65)
                    .background(Color.turquoiseGreen)
                    .cornerRadius(18)
                
                
            }
        }
    }
}

#Preview {
    ExerciciosDetalhadosView()
}
