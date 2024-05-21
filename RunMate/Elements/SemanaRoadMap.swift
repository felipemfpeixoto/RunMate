//
//  SemanaRoadMap.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

struct SemanaRoadMap: View {
    let semana: Semana
    let isLocked: Bool
    
    var body: some View {
        ZStack {
            if isLocked {
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(semana.semana)ª Semana")
                            .foregroundColor(.white)
                            .font(.custom("Poppins-SemiBold", size: 20))
                            .fontWeight(.semibold)
                        Text("BLOQUEADA")
                            .font(.custom("Poppins-SemiBold", size: 14))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Image("cadeadoTransparente")
                }
                .background {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(.oceanBlue)
                        .frame(width: 300,height: 80)
                }
            } else if dao.semanaAtual == (semana.semana - 1) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(semana.semana)ª Semana")
                            .foregroundColor(.oceanBlue)
                            .font(.custom("Poppins-SemiBold", size: 20))
                            .fontWeight(.semibold)
                        Text("EM PROGRESSO")
                            .font(.custom("Poppins-SemiBold", size: 14))
                            .foregroundColor(.oceanBlue)
                    }
                    Spacer()
                    Image("cadeadoAbertoTransparente")
                }
                .background {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(.turquoiseGreen)
                        .frame(width: 300,height: 80)
                }
            } else {
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("\(semana.semana)ª Semana")
                            .foregroundColor(.white)
                            .font(.custom("Poppins-SemiBold", size: 20))
                            .fontWeight(.semibold)
                        Text("CONCLUÍDA")
                            .font(.custom("Poppins-SemiBold", size: 14))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Image("Medalha")
                }
                .background {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(.lilacPurple)
                        .frame(width: 300,height: 80)
                }
            }
               
        }
        .frame(width: 250)
    }
}
