//
//  AvisoResetarView.swift
//  RunMate
//
//  Created by Roberta Cordeiro on 24/05/24.
//

import SwiftUI

struct AvisoResetarView: View {
    var body: some View {    
        ZStack {
            Color.blackBlue
                .ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.oceanBlue)
                .stroke(Color.turquoiseGreen, lineWidth: 0)
                .frame(maxWidth: .infinity)
                .frame(height: 350)
                .padding(35)
            
            VStack {
                Text("ATENÇÃO")
                    .font(Font.custom("Poppins-SemiBold", size: 22))
                    .foregroundStyle(Color.turquoiseGreen)
                    .padding(.bottom, 8)
                
                Text("Ao alterar minha meta essa ação não poderá ser desfeita.")
                    .font(Font.custom("Poppins-SemiBold", size: 18))
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 50)
                    .padding(.bottom, 10)
                
                Text("Deseja mudá-la e apagar seu histórico de corrida?")
                    .font(Font.custom("Poppins-SemiBold", size: 18))
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 50)
                    .padding(.bottom, 10)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("CANCELAR")
                        .foregroundColor(.turquoiseGreen)
                        .frame(maxWidth: .infinity)
                        .font(Font.custom("Poppins-SemiBold", size: 18))
                        .padding(.vertical, 16)
                        .background(Color.lakeBlue)
                })
                .cornerRadius(18)
                .padding(.bottom, 4)
                .padding(.horizontal, 60)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("PROSSEGUIR")
                        .foregroundColor(.blackBlue)
                        .frame(maxWidth: .infinity)
                        .font(Font.custom("Poppins-SemiBold", size: 18))
                        .padding(.vertical, 16)
                        .background(Color.turquoiseGreen)
                })
                .cornerRadius(18)
                .padding(.bottom, 3)
                .padding(.horizontal, 60)
            }
        }
    }
}

#Preview {
    AvisoResetarView()
}
