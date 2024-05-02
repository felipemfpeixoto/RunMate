//
//  EscolhaNivelView.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

struct EscolhaNivelView: View {
    var body: some View {
        ZStack {
            Color.blackBlue
                .ignoresSafeArea()
            VStack {
                Text("Bora traçar nossa meta!")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                ZStack {
                    RoundedRectangle(cornerRadius: 100)
                        .frame(width: 320, height: 8)
                        .foregroundStyle(Color.oceanBlue)
                    HStack(spacing: 0) {
                        RoundedRectangle(cornerRadius: 100)
                            .frame(width: 96, height: 8)
                            .foregroundStyle(Color.turquoiseGreen)
                        Text("🏃🏻‍♂️")
                            .font(.system(size: 40))
                            .scaleEffect(x: -1, y: 1)
                            .padding(.leading, -20)
                        Spacer()
                    }
                }.frame(width: 320)
                Text("Selecione seu nível de corredor:")
                    .foregroundStyle(.white)
                    .font(.title3.bold())
                BotaoEscolha(texto: "Iniciante")
                BotaoEscolha(texto: "Intermediário")
                BotaoEscolha(texto: "Avançado")
                Spacer()
                NavigationLink(destination: EscolhaObjetivoView()) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(Color.turquoiseGreen)
                            .frame(width: 243, height: 56)
                        Text("Proximo")
                            .foregroundStyle(.black)
                            .font(.title3.bold())
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    EscolhaNivelView()
}
