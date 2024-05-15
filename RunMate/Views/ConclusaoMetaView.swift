//
//  ConclusaoMetaView.swift
//  RunMate
//
//  Created by Roberta Cordeiro on 09/05/24.
//

import SwiftUI

struct ConclusaoMetaView: View {
    @State private var animateMedal = false
    var body: some View {
        ZStack {
            Color(Color.blackBlue)
                .ignoresSafeArea()
            VStack {
                Image("Trofeu")
                    .shadow(color: .turquoiseGreen, radius: 13.0)
                    .scaleEffect(animateMedal ? 1.1 : 0.9)
                    .animation(
                        Animation.easeInOut(duration: 0.5)
                            .repeatCount(3, autoreverses: true)
                            .delay(0.2)
                    )
                
                Text("META CONCLUÍDA!")
                    .font(Font.custom("Poppins-SemiBold", size: 28))
                    .foregroundStyle(.turquoiseGreen)
                    .padding(.vertical, 20)
                
                Text("Você cruzou a linha de chegada! Sua meta foi alcançada com sucesso e o troféu é seu.")
                    .font(Font.custom("Poppins-SemiBold", size: 18))
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 10)
                
                Text("Bora partir para a próxima conquista?")
                    .font(Font.custom("Poppins-SemiBold", size: 18))
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
                
                    }
            
            .padding(.horizontal, 30)
            .onAppear {
                self.animateMedal.toggle() // Inicia a animação quando a view aparece
            }
        }
    }
}

#Preview {
    ConclusaoMetaView()
}
