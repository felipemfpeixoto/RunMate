//
//  AvisoConfirmacaoEtapa.swift
//  RunMate
//
//  Created by Giovana Nogueira on 10/05/24.
//

import SwiftUI

struct AvisoConfirmacaoEtapa: View {
    
    @Binding var apareceAtencao: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.oceanBlue)
                .stroke(Color.turquoiseGreen, lineWidth: 4)
                .frame(maxWidth: .infinity)
                .frame(height: 260)
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
                    .padding(.bottom, 5)
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 30)
            .cornerRadius(25)
            VStack{
                
                VStack{
                    
                }.frame(height: 255)
                
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
                    
                    
                    Button(action: {apareceAtencao = false}, label: {
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
//        .background(Color.blackBlue.opacity(0.4))
    }
}

#Preview {
    AvisoConfirmacaoEtapa(apareceAtencao: .constant(true))
}
