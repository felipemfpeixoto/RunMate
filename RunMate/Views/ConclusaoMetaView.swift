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
                    .scaleEffect(animateMedal ? 1.1 : 0.9) // Escala inicial é 1.1 quando animada, 0.9 quando não animada
                    .animation(
                        Animation.easeInOut(duration: 0.5) // Animando a escala da medalha
                            .repeatCount(3, autoreverses: true) // Repete uma vez e reverte
                            .delay(0.2) // Delay de 1 segundo antes de começar a animação
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
                    
                Button{
                    dao.paginaDeTreinamento.planoDeTreinamento.semanas = []
//                    try? DAO.delete()
//                    dao = DAO.instance
                } label: {
                    Text("CRIE UMA NOVA META")
                        .foregroundColor(.oceanBlue)
                        .font(Font.custom("Poppins-SemiBold", size: 18))
                        .padding(.vertical, 16)
                        .padding(.horizontal, 25)
                        .background(Color.turquoiseGreen)
                        .clipShape(Capsule())
                        .padding(.top, 40)
                        .padding(.bottom, 20)
                }
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
