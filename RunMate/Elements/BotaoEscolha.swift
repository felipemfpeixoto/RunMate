//
//  BotaoEscolha.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

struct BotaoEscolha: View {
    
    let texto: String
    
    var body: some View {
        Button(action: {
            // faz nada ainda
        }, label: {
            ZStack {
                Color.oceanBlue
                Text(texto)
                    .foregroundStyle(.white)
                    .font(.title2.bold())
            }
            .frame(width: 317, height: 69)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        })
    }
}

#Preview {
    BotaoEscolha(texto: "Iniciante")
}
