//
//  AvisoView.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

struct AvisoView: View {
    
    @Binding var isShowingPopUp: Bool
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 10) {
                
               Image("Aviso")
                    .padding(.vertical, 30)
                
                
                Text("Antes de se exercitar ou participar de atividades físicas intensas, como corrida, consulte seu médico ou profissional de saúde.")
                    .font(Font.custom("Poppins-SemiBold", size: 18))
                    .padding(.horizontal, 5)
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 20)
                   
                     
                
                
                Text("Certifique-se de sua saúde cardiovascular e de condições médicas pré-existentes.")
                    .font(Font.custom("Poppins-SemiBold", size: 18))
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 5)
                    .multilineTextAlignment(.center)
                
                   
                
                
                Button(action: {
                    isShowingPopUp = false
                }, label: {
                    Text("ESTOU PRONTO!")
                    
                        .foregroundColor(.darkPurple)
                        .font(Font.custom("Poppins-SemiBold", size: 18))
                        .padding(.vertical, 16)
                        .padding(.horizontal, 50)
                        .background(Color.turquoiseGreen)

                        
                    
                })
                .cornerRadius(11)
                .padding(.top, 100)
                


            }
            .padding(.vertical, 25)
            .padding(.horizontal, 30)
                        
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.oceanBlue.opacity(1).ignoresSafeArea())
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    AvisoView(isShowingPopUp: .constant(true))
}
